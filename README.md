# G-Chat

G-Chat is a Flutter-based chat application that allows users to sign up, sign in, and chat with other users. It uses Firebase for authentication and real-time database operations.

## Table of Contents

- [Setup Instructions](#setup-instructions)
- [Deployment Steps](#deployment-steps)
- [Features](#features)
- [Folder Structure](#folder-structure)
- [License](#license)

## Setup Instructions

### Prerequisites

- **Flutter:** Ensure you have Flutter installed. You can download it from the [official Flutter website](https://flutter.dev/docs/get-started/install).
- **Firebase:** You'll need a Firebase project. Set up Firebase for your project by following the [Firebase setup instructions](https://firebase.google.com/docs/flutter/setup).

### Clone the Repository

- git clone https://github.com/johnwillz-ux/gchat.git
- cd gchat

## Install Dependencies

flutter pub get

## Configure Firebase

Android:
- Place the google-services.json file in the android/app directory.
- Ensure you have the correct dependencies in your android/build.gradle and android/app/build.gradle files.

iOS:
- Place the GoogleService-Info.plist file in the ios/Runner directory.
- Make sure your ios/Podfile contains the necessary Firebase dependencies.


## Deployment Steps

Running the App
- To run the app in development mode, use:
- flutter run

Building the App
- for Android
- flutter build apk

For iOS:
- flutter build ios

## Features
- User Authentication (Sign Up, Sign In, Sign Out)
- Real-time Chat
- User Profiles
- Dark Mode Support
- Pull-to-Refresh for Chat List


## Folder Structure
Here’s a brief overview of the folder structure:

- lib/
    - common/ - Common widgets and utilities
    - constants/ - Constant values and styles
    - models/ - Data models
    - providers/ - State management providers
    - services/ - Firebase and other service integrations
    - views/ - Application views/screens
    - widgets/ - Reusable widgets
- assets/ - Asset files such as images
- android/ - Android platform-specific code
- ios/ - iOS platform-specific code


## License
This project is licensed under the MIT License






