# Flutter To-Do App

## Overview

This is a Flutter To-Do application that helps users manage daily tasks efficiently. It includes multi-language localization and theming support, allowing users to toggle between light and dark modes. The app is built using Flutter and Dart, ensuring cross-platform compatibility for Android and iOS.

## Features

- **Task Management**: Add, edit, delete, and mark tasks as completed.
- **Localization**: Multi-language support for global usage.
- **Theming**: Light and dark themes available.
- **Task Prioritization**: Set high, medium, or low priorities for tasks.
- **Reminders**: Receive notifications for upcoming tasks.
- **Categories**: Organize tasks under different categories.

## Screenshots

Add your app screenshots here.

## Getting Started

### Prerequisites

Before running this project, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/flutter_todo_app.git
Navigate to the project directory:

bash
Copy code
cd flutter_todo_app
Fetch the dependencies:

bash
Copy code
flutter pub get
Run the app:

bash
Copy code
flutter run
Folder Structure
bash
Copy code
lib/
  ├── main.dart                # Entry point of the app
  ├── screens/                 # App screens (Home, AddTask, etc.)
  ├── widgets/                 # Custom widgets (TaskItem, CategoryWidget)
  ├── models/                  # Data models (Task, Category)
  ├── localization/            # Localization resources
  ├── theme/                   # Light and dark theme files
  └── utils/                   # Utility functions (e.g., date formatting)
Localization
To add more languages, follow these steps:

Create a new language file in lib/localization/ (e.g., en.json for English).
Add language support in the app by updating the supportedLocales in main.dart.
Theming
The app supports light and dark themes. You can modify the themes in lib/theme/ by editing the light_theme.dart and dark_theme.dart files.
