# My Vocabulary – LingoBreeze

A complete implementation of the **My Vocabulary** feature for the **LingoBreeze** language-learning app. This project demonstrates a production-ready vocabulary management system built with Clean Architecture principles, Firebase integration, and a scalable Node.js backend.

---

## Features

* Add new vocabulary words and phrases
* Edit and update saved vocabulary entries
* Delete vocabulary items
* Search and filter vocabulary efficiently
* Organize personal vocabulary collections
* Track vocabulary learning progress
* Secure user authentication with Firebase Authentication
* Real-time cloud synchronization using Firebase Firestore
* RESTful API integration with Node.js backend
* Clean and responsive Flutter UI

---

## Tech Stack

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Node.js
* Express.js
* Clean Architecture

---

## Screenshots

<table>
  <tr>
    <td><img src="assets/screenshots/1.png" width="250"></td>
    <td><img src="assets/screenshots/2.png" width="250"></td>
  </tr>
  <tr>
    <td><img src="assets/screenshots/3.png" width="250"></td>
    <td><img src="assets/screenshots/4.png" width="250"></td>
  </tr>
</table>

---

## Architecture Highlights

* Feature-based project structure
* Separation of Presentation, Domain, and Data layers
* Repository Pattern implementation
* Dependency Injection
* Error handling and validation
* Scalable backend API design
* Firebase-powered authentication and storage

---
## Project Structure

```text
lib/
 ├── models/
 │    └── journal_entry.dart
 ├── screens/
 │    ├── addentry_screen.dart
 │    ├── editentry_screen.dart
 │    ├── home_screen.dart
 │    └── login_screen.dart
 ├── services/
 │    ├── auth_services.dart
 │    └── firestore_services.dart
 ├── widgets/
 │    ├── custom_input_decoration.dart
 │    └── journal_card.dart
 ├── const.dart
 └── main.dart

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/my-vocabulary-lingobreeze.git
```

### 2. Navigate to the project

```bash
cd my-vocabulary-lingobreeze
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Run the application

```bash
flutter run
```

---

## Backend Setup

### Install backend dependencies

```bash
cd backend
npm install
```

### Start the backend server

```bash
npm start
```

---

## Firebase Setup

Before running the project:

1. Create a Firebase project
2. Enable Firebase Authentication
3. Enable Cloud Firestore
4. Configure Firebase for Flutter
5. Add `google-services.json` (Android)
6. Add `GoogleService-Info.plist` (iOS)
7. Update Firebase configuration files

---

## Project Purpose

This project was developed to demonstrate a real-world vocabulary management feature for language-learning applications while following modern software engineering best practices.

Key learning areas include:

* Flutter application development
* Clean Architecture implementation
* Firebase Authentication integration
* Cloud Firestore database management
* REST API development with Node.js
* State management and scalable app structure

---

## Future Enhancements

* Vocabulary categories and tags
* Spaced repetition learning system
* Word pronunciation support
* Example sentences and translations
* Offline mode with local caching
* Learning analytics and progress tracking
* Vocabulary import/export functionality

---

## Author

**Shiyas Cholayil**

GitHub: https://github.com/shiyascholayil



