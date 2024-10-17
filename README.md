# Flutter To-Do App

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Folder Structure](#folder-structure)
- [Localization](#localization)
- [Theming](#theming)
- [Contributors](#contributors)

## Overview
This is a Flutter-based To-Do application that helps users efficiently manage daily tasks. The app supports multi-language localization and theming, allowing users to toggle between light and dark modes. It is cross-platform and works on both Android and iOS devices.

## Features
- **Task Management**: Add, edit, delete, and mark tasks as completed.
- **Task Prioritization**: Set task priorities (High, Medium, Low).
- **Reminders**: Notifications for upcoming tasks.
- **Categories**: Organize tasks by categories.
- **Localization**: Multi-language support for global accessibility.
- **Theming**: Switch between light and dark modes.

## Screenshots
Include your app screenshots here.

## Getting Started

### Prerequisites
Ensure you have the following installed before running this project:
- Flutter SDK
- Dart SDK
- Android Studio or VS Code

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter_todo_app.git
# Flutter Task Management App

A task management app built with Flutter that supports multiple languages, custom themes, and a structured directory layout for scalability and maintainability.

## Getting Started

To get the project dependencies and run the app on your device or emulator, use the following commands:

```bash
# Fetch project dependencies
flutter pub get

# Run the app
flutter run
```

## Folder Structure

The project follows a structured directory layout to ensure maintainability and scalability:

```bash
lib/
  ├── main.dart                # Entry point of the app
  ├── screens/                 # App screens (Home, AddTask, etc.)
  ├── widgets/                 # Custom widgets (TaskItem, CategoryWidget)
  ├── models/                  # Data models (Task, Category)
  ├── localization/            # Localization resources
  ├── theme/                   # Light and dark theme files
  └── utils/                   # Utility functions (e.g., date formatting)
```

## Localization

This app supports multiple languages. To add support for a new language, follow these steps:

1. Create a JSON file for the new language in `lib/localization/` (e.g., `es.json` for Spanish).
2. Add the new locale in the `supportedLocales` array in `main.dart`:

```dart
supportedLocales: [
  const Locale('en', 'US'),
  const Locale('es', 'ES'), // Add new language here
],
```

## Theming

The app supports both light and dark themes. You can customize the themes by editing the `light_theme.dart` and `dark_theme.dart` files located in the `lib/theme/` directory.

## Contributors

- **Abdelrahman Wael** - [GitHub Profile](https://github.com/chessjoker27)
