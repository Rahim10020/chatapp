import 'package:chatapp/models/message.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatService extends GetxController {
  // get instance of firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final authService = AuthService();

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each individual user
        final user = doc.data();
        return user;
      }).toList();
    });
  }

  // get all users stream except blocked users
  Stream<List<Map<String, dynamic>>> getAllUsersStreamExcludingBlocked() {
    final currentUser = authService.getCurrentUser();
    return _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
          // get blocked user ids
          final blockedUserIds = snapshot.docs.map((doc) => doc.id).toList();

          // get all users
          final usersSnapshot = await _firestore.collection('Users').get();

          // return as a stream list
          return usersSnapshot.docs
              .where(
                (doc) =>
                    doc.data()['email'] != currentUser.email &&
                    !blockedUserIds.contains(doc.id),
              )
              .map((doc) => doc.data())
              .toList();
        });
  }

  // send message
  Future<void> sendMessage(String receiverId, String message) async {
    // first we need to get the current user infos
    final String currentUserId = authService.getCurrentUser()!.uid;
    final String currentUserEmail = authService.getCurrentUser()!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    // construct a chat room id for the two users (sorted to ensure uniqueness)
    List<String> ids = [currentUserId, receiverId];
    ids.sort(); // this ensure that the chatroom id is unique for 2 people

    String chatRoomId = ids.join('_');

    // add new message to the database
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  // get messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    // construct a chatroom id for the two users
    List<String> ids = [userId, otherUserId];

    ids.sort();

    String chatRoomId = ids.join('_');

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  // report user
  Future<void> reportUser(String messageId, String userId) async {
    final currentUser = authService.getCurrentUser();
    final report = {
      'reportedBy': currentUser!.uid,
      'messageId': messageId,
      'messageOwnerId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('Reports').add(report);
  }

  // block user
  Future<void> blockUser(String userId) async {
    final currentUser = authService.getCurrentUser();
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(userId)
        .set({});

    update();
  }

  // unblock user
  Future<void> unblockUser(String blockedUserId) async {
    final currentUser = authService.getCurrentUser();
    await _firestore
        .collection('Users')
        .doc(currentUser!.uid)
        .collection('BlockedUsers')
        .doc(blockedUserId)
        .delete();
  }

  // get blocked users stream
  Stream<List<Map<String, dynamic>>> getBlockedUsers(String userId) {
    return _firestore
        .collection('Users')
        .doc(userId)
        .collection('BlockedUsers')
        .snapshots()
        .asyncMap((snapshot) async {
          // get a list blocked users ids
          final blockedUsersIds = snapshot.docs.map((doc) => doc.id).toList();

          final userDocs = await Future.wait(
            blockedUsersIds.map(
              (id) => _firestore.collection('Users').doc(id).get(),
            ),
          );

          return userDocs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();
        });
  }
}
