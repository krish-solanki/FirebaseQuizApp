# 📚 Firebase Quiz App

Firebase Quiz App is a Flutter application that allows users to test their knowledge through multiple-choice quizzes. The app uses Firebase Authentication for secure login and Cloud Firestore to store quiz questions, user scores, and quiz history.

---

## ✨ Features

- 🔐 User Authentication with Firebase
- 📝 Multiple Choice Questions (MCQs)
- ⏱️ Quiz Timer
- 📊 Instant Score Calculation
- ☁️ Cloud Firestore Integration
- 📈 View Quiz Results
- 📱 Clean and Responsive UI
- 🔄 Real-time Data Fetching
- 🎯 Randomized Questions

---

## 🛠️ Tech Stack

- Flutter
- Dart
- Firebase Authentication
- Cloud Firestore
- Provider
- Git & GitHub

---

## 📂 Project Structure

```
lib/
├── controller/
├── model/
├── service/
├── utils/
├── view/
│   ├── auth/
│   ├── home/
│   ├── quiz/
│   ├── result/
│   └── splash/
├── widget/
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

Make sure you have installed:

- Flutter SDK
- Dart SDK
- Android Studio or VS Code
- Git
- Firebase Project

---

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/krish-solanki/FirebaseQuizApp.git
```

### 2. Navigate to the project

```bash
cd FirebaseQuizApp
```

### 3. Install dependencies

```bash
flutter pub get
```

### 4. Configure Firebase

- Create a Firebase project.
- Enable Firebase Authentication.
- Enable Cloud Firestore.
- Download the `google-services.json` file and place it inside the `android/app` folder.

### 5. Run the application

```bash
flutter run
```

---

## 📦 Packages Used

- firebase_core
- firebase_auth
- cloud_firestore
- provider
- flutter_screenutil

---

## 📱 App Screens

- Splash Screen
- Login
- Register
- Home
- Quiz Screen
- Result Screen
- Profile

---

## 🔥 Firebase Features

- User Authentication
- Cloud Firestore Database
- Store Quiz Questions
- Store User Scores
- Quiz History

---

## 🎯 How It Works

1. User signs in using Firebase Authentication.
2. Quiz questions are fetched from Cloud Firestore.
3. User answers multiple-choice questions.
4. Score is calculated automatically.
5. Results are displayed at the end of the quiz.
6. User scores are saved to Firestore.

---

## 🚀 Future Improvements

- Leaderboard
- Category-wise quizzes
- Difficulty levels
- Daily challenge
- Dark mode
- Review incorrect answers
- Timer customization
- Offline quiz support

---

## 🤝 Contributing

Contributions are welcome.

1. Fork the repository.
2. Create a new branch.

```bash
git checkout -b feature-name
```

3. Commit your changes.

```bash
git commit -m "Add new feature"
```

4. Push the branch.

```bash
git push origin feature-name
```

5. Open a Pull Request.

---

## 📄 License

This project was developed for learning and portfolio purposes.

---

## 👨‍💻 Author

**Krish Solanki**

Flutter Developer

GitHub: https://github.com/krish-solanki

---

## ⭐ Support

If you found this project helpful, please give it a ⭐ on GitHub.
