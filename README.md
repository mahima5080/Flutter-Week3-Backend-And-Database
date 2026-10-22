# Flutter & Dart — Week 3: Backend Integration & Database

## 📌 Topics Covered
* REST API integration using the `http` package[cite: 30]
* JSON parsing and displaying API responses dynamically[cite: 30]
* Local state and loading handling (`FutureBuilder`, `CircularProgressIndicator`)[cite: 30, 31]
* Firebase Auth UI flow implementation[cite: 30, 31]

---

## 📁 Repository Contents
1. `public_api_fetch.dart`: Fetches and parses sample post data from JSONPlaceholder API[cite: 30, 31].
2. `firebase_login.dart`: User interface demonstration for Firebase Email/Password login[cite: 30, 31].
3. `main.dart`: **Mini Project** — Live Weather Forecast App connecting to OpenWeather API with temperature, humidity, and location search[cite: 31].

---

## 🚀 How to Run in VS Code

```bash
# 1. Run Mini Project Weather Forecast App
flutter run -d chrome

# 2. Run Public API Assignment
flutter run -t lib/public_api_fetch.dart -d chrome

# 3. Run Firebase Login Assignment
flutter run -t lib/firebase_login.dart -d chrome

# week_3

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
