# ChatApp

A modern real-time chat application built with Flutter and Firebase.

## Features

- **Real-time messaging** - Send and receive messages instantly
- **User authentication** - Secure login/register with Firebase Auth
- **User profiles** - Customizable user profiles
- **Dark/Light theme** - Toggle between themes
- **Block users** - Manage unwanted contacts
- **Settings** - Customize app preferences
- **Cross-platform** - Works on Android, iOS

## Tech Stack

- **Flutter** - UI framework
- **Firebase** - Backend services
  - Firebase Authentication
  - Cloud Firestore (database)
- **Get** - State management
- **Google Fonts** - Typography

## Getting Started

### Prerequisites

- Flutter SDK (3.8.1+)
- Firebase project with Authentication and Firestore enabled

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Rahim10020/chatapp
cd chatapp
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Add your Firebase configuration files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS)
   - Update `lib/firebase_options.dart` with your Firebase project configuration

4. Run the app:
```bash
flutter run
```

## Usage

1. **Register/Login** - Create an account or sign in
2. **Home** - View and join chat rooms
3. **Chat** - Send real-time messages
4. **Settings** - Customize your experience
5. **Profile** - Manage your user information

## Project Structure

```
lib/
├── components/     # Reusable UI components
├── controllers/    # State management controllers
├── models/         # Data models
├── pages/          # App screens
├── services/       # Firebase services
└── themes/         # Light and dark themes
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is private and not published to pub.dev.
