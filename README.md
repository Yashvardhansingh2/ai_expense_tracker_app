# 💸 AI Expense Tracker

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev)
[![Flask](https://img.shields.io/badge/Flask-Backend-000000?logo=flask)](https://flask.palletsprojects.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

An intelligent, cross-platform expense tracking application that leverages **Machine Learning** to automatically categorize expenses, detect spending anomalies, and forecast future budgets. Built with **Flutter** for a seamless user experience and **Flask** for powerful AI-driven backend analytics.

---

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Architecture](#-architecture)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Running the App](#running-the-app)
- [Backend Integration](#-backend-integration)
- [Project Structure](#-project-structure)
- [Usage Guide](#-usage-guide)
- [Testing](#-testing)
- [Platform Support](#-platform-support)
- [API Documentation](#-api-documentation)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

### 🤖 AI-Powered Intelligence
- **Automatic Categorization**: Uses NLP and keyword mapping to predict expense categories (Food & Dining, Transportation, Entertainment, etc.)
- **Anomaly Detection**: Identifies unusual spending patterns using Isolation Forest algorithm
- **Budget Forecasting**: Predicts next month's expenses using Linear Regression
- **Smart Summaries**: Generates AI-powered monthly expense breakdowns and insights

### 📊 Data Visualization
- **Interactive Pie Charts**: Category-wise expense distribution
- **Trend Analysis**: Line charts showing spending patterns over time
- **Real-time Dashboard**: Live updates with monthly summaries and budget progress

### 💾 Offline-First Architecture
- **Local Storage**: Uses Hive NoSQL database for fast, offline-capable data persistence
- **Sync Ready**: Seamlessly integrates with backend APIs when online
- **Zero Latency**: Instant UI updates without network dependency

### 🎨 Modern UI/UX
- **Material 3 Design**: Latest Flutter design system with dynamic theming
- **Gradient Backgrounds**: Beautiful blue → purple → pink gradients throughout
- **Dark/Light Themes**: Automatic theme switching based on system preferences
- **Responsive Layout**: Adapts to all screen sizes and orientations

### 🌍 Cross-Platform Support
- ✅ Android
- ✅ iOS
- ✅ macOS
- ✅ Linux
- ✅ Windows
- ✅ Web (PWA-ready)

---

## 🧠 Tech Stack

### Frontend
| Technology | Purpose |
|------------|---------|
| **Flutter 3.9.2** | Cross-platform UI framework |
| **Dart 3.9.2** | Programming language |
| **Hive 2.2.3** | Local NoSQL database |
| **fl_chart 1.1.1** | Data visualization library |
| **HTTP 1.1.0** | REST API client |
| **Material 3** | Design system |

### Backend (AI/ML)
| Technology | Purpose |
|------------|---------|
| **Flask** | Python web framework |
| **Pandas** | Data manipulation and analysis |
| **Scikit-Learn** | Machine learning algorithms |
| **Isolation Forest** | Anomaly detection |
| **Linear Regression** | Budget forecasting |
| **Joblib** | Model serialization |

### Deployment
| Platform | Service |
|----------|---------|
| **Backend API** | Render Cloud |
| **Frontend** | Native apps + Web |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────┐
│         Flutter Application (Dart)          │
│  ┌────────────────────────────────────────┐ │
│  │  Screens                               │ │
│  │  • Main Screen (Add Expenses)          │ │
│  │  • Dashboard (Monthly Summary)         │ │
│  │  • Charts (Visualizations)             │ │
│  │  • Insights (AI Analytics)             │ │
│  └────────────────────────────────────────┘ │
│  ┌────────────────────────────────────────┐ │
│  │  Models                                │ │
│  │  • Expense (HiveObject)                │ │
│  │  • Budget (HiveObject)                 │ │
│  └────────────────────────────────────────┘ │
│  ┌────────────────────────────────────────┐ │
│  │  Local Storage (Hive)                  │ │
│  │  • expenses.hive                       │ │
│  │  • budgets.hive                        │ │
│  └────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
                    ↓↑ HTTPS/JSON
┌─────────────────────────────────────────────┐
│     Flask Backend (Render Cloud)            │
│  ┌────────────────────────────────────────┐ │
│  │  ML Endpoints                          │ │
│  │  • /predict - Category prediction      │ │
│  │  • /summarize - Monthly summary        │ │
│  │  • /detect_anomalies - Outlier detect  │ │
│  │  • /forecast - Budget prediction       │ │
│  └────────────────────────────────────────┘ │
└─────────────────────────────────────────────┘
```

---

## 🚀 Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** `>= 3.9.2` - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** `>= 3.9.2` (included with Flutter)
- **Git** - [Install Git](https://git-scm.com/downloads)
- **IDE** (choose one):
  - [Visual Studio Code](https://code.visualstudio.com/) with Flutter extension
  - [Android Studio](https://developer.android.com/studio) with Flutter plugin
  - [IntelliJ IDEA](https://www.jetbrains.com/idea/) with Flutter plugin

**Platform-Specific Requirements:**
- **Android**: Android Studio, Android SDK, Android Emulator
- **iOS/macOS**: Xcode 14+ (macOS only)
- **Web**: Chrome browser
- **Linux**: GTK development libraries
- **Windows**: Visual Studio 2022 with C++ desktop development

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Yashvardhansingh2/ai_expense_tracker_app.git
   cd ai_expense_tracker_app
   ```

2. **Initialize backend submodule** (optional, for local backend development)
   ```bash
   git submodule update --init --recursive
   ```

3. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

4. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Verify Flutter installation**
   ```bash
   flutter doctor
   ```
   Fix any issues reported by Flutter Doctor before proceeding.

### Running the App

#### Quick Start (Default Platform)
```bash
flutter run
```

#### Platform-Specific Commands

**Android**
```bash
# List available devices
flutter devices

# Run on connected device/emulator
flutter run -d <device-id>

# Build APK
flutter build apk --release
```

**iOS** (macOS only)
```bash
# Run on simulator
flutter run -d "iPhone 15 Pro"

# Run on physical device
flutter run -d <device-id>

# Build IPA
flutter build ios --release
```

**macOS**
```bash
flutter run -d macos
flutter build macos --release
```

**Web**
```bash
flutter run -d chrome
flutter build web --release
```

**Linux**
```bash
flutter run -d linux
flutter build linux --release
```

**Windows**
```bash
flutter run -d windows
flutter build windows --release
```

---

## 🔗 Backend Integration

The app connects to a Flask-based ML backend hosted on Render:

**Backend URL:** `https://ai-expense-tracker-backend-xms7.onrender.com`

**Backend Repository:** [ai_expense_tracker_backend](https://github.com/Yashvardhansingh2/ai_expense_tracker_backend)

### Backend Features
- Real-time expense category prediction
- Monthly expense summarization with percentages
- Anomaly detection using Isolation Forest
- Budget forecasting using Linear Regression

**Note:** The backend is configured as a Git submodule. For local development of the backend, see the [backend repository documentation](https://github.com/Yashvardhansingh2/ai_expense_tracker_backend).

---

## 📁 Project Structure

```
ai_expense_tracker_app/
├── lib/
│   ├── main.dart                    # App entry point & main expense screen
│   ├── theme.dart                   # Color palette and theme constants
│   ├── ai_summary_helper.dart       # AI summary generation utilities
│   ├── dashboard_screen.dart        # Monthly summary & budget management
│   ├── charts_screen.dart           # Expense visualization (pie charts)
│   ├── models/
│   │   ├── expense_model.dart       # Expense data model (Hive)
│   │   ├── expense_model.g.dart     # Generated Hive adapter
│   │   ├── budget_model.dart        # Budget data model (Hive)
│   │   └── budget_model.g.dart      # Generated Hive adapter
│   └── screens/
│       └── insights_screen.dart     # AI insights & analytics
├── assets/
│   ├── icon.png                     # App icon
│   └── overlay.png                  # UI texture overlay
├── android/                         # Android-specific files
├── ios/                             # iOS-specific files
├── macos/                           # macOS-specific files
├── linux/                           # Linux-specific files
├── windows/                         # Windows-specific files
├── web/                             # Web-specific files
├── test/
│   └── widget_test.dart             # Widget tests
├── backend/                         # Backend submodule (Flask API)
├── pubspec.yaml                     # Flutter dependencies
├── analysis_options.yaml            # Linter configuration
└── README.md                        # This file
```

---

## 📖 Usage Guide

### 1. Adding an Expense

1. Launch the app
2. Enter expense description (e.g., "Lunch at restaurant")
3. Enter amount (e.g., "500")
4. Tap **"Predict Category"** to use AI categorization
5. Review the predicted category
6. Tap **"Save Expense"** to store locally

### 2. Viewing Dashboard

1. Navigate to **Dashboard** tab from bottom navigation
2. View monthly total and category-wise breakdown
3. Monitor budget progress with color-coded indicators:
   - 🟢 Green: Under 70% of budget
   - 🟠 Orange: 70-100% of budget
   - 🔴 Red: Over budget
4. Tap **AI Summary** (📊) to generate monthly insights

### 3. Setting Budgets

1. Go to **Dashboard** screen
2. Tap the **"+ Add Budget"** button
3. Enter category name
4. Set budget limit
5. Save to start tracking

### 4. Viewing Charts

1. Navigate to **Charts** tab
2. View interactive pie chart of expense distribution
3. Scroll through full expense list
4. Swipe to delete individual expenses

### 5. AI Insights

1. Navigate to **Insights** tab
2. Choose from three AI features:
   - **Summarize My Month**: Get AI-generated breakdown
   - **Detect Anomalies**: Find unusual spending patterns
   - **Forecast Next Month**: Predict future expenses
3. View results with visualizations

---

## 🧪 Testing

### Running Tests

**Run all tests:**
```bash
flutter test
```

**Run with coverage:**
```bash
flutter test --coverage
```

**Run specific test file:**
```bash
flutter test test/widget_test.dart
```

### Test Structure

The project includes basic widget tests in `/test/widget_test.dart`:
- App initialization test
- Widget rendering verification
- Hive adapter registration tests

**Note:** Test coverage is currently minimal. Contributions for additional tests are welcome!

---

## 🖥️ Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| Android | ✅ Fully Supported | Min SDK 21+ |
| iOS | ✅ Fully Supported | iOS 11+ |
| macOS | ✅ Fully Supported | macOS 10.14+ |
| Linux | ✅ Fully Supported | GTK 3.0+ |
| Windows | ✅ Fully Supported | Windows 10+ |
| Web | ✅ Fully Supported | PWA-ready |

### Platform-Specific Setup

**Android:**
- No additional setup required
- Default debug signing used (configure release signing for production)

**iOS/macOS:**
- Requires Xcode 14+ and macOS development environment
- CocoaPods automatically managed by Flutter

**Web:**
- Responsive design optimized for desktop and mobile browsers
- PWA manifest included for installable web app

**Linux:**
- Install GTK development libraries:
  ```bash
  sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
  ```

**Windows:**
- Requires Visual Studio 2022 with "Desktop development with C++"

---

## 📡 API Documentation

### Base URL
```
https://ai-expense-tracker-backend-xms7.onrender.com
```

### Endpoints

#### 1. Predict Category
```http
POST /predict
Content-Type: application/json

{
  "text": "Coffee at Starbucks"
}

Response:
{
  "category": "Food & Dining"
}
```

#### 2. Summarize Expenses
```http
POST /summarize
Content-Type: application/json

{
  "expenses": [
    {"category": "Food & Dining", "amount": 500},
    {"category": "Transportation", "amount": 300}
  ]
}

Response:
{
  "summary": "You spent ₹800 this month...",
  "percentages": {
    "Food & Dining": 62.5,
    "Transportation": 37.5
  }
}
```

#### 3. Detect Anomalies
```http
POST /detect_anomalies
Content-Type: application/json

{
  "expenses": [
    {"category": "Shopping", "amount": 5000},
    {"category": "Shopping", "amount": 200}
  ]
}

Response:
{
  "anomalies": [
    {"category": "Shopping", "amount": 5000}
  ]
}
```

#### 4. Forecast Budget
```http
POST /forecast
Content-Type: application/json

{
  "expenses": [
    {"category": "Food & Dining", "amount": 500},
    {"category": "Transportation", "amount": 300}
  ]
}

Response:
{
  "forecast": 8500.0
}
```

---

## 🐛 Troubleshooting

### Common Issues

#### Issue: "Hive box not found"
**Solution:** Run the code generator:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### Issue: "Backend connection failed"
**Solution:**
- Check internet connectivity
- Verify backend is running: Visit https://ai-expense-tracker-backend-xms7.onrender.com
- Render free tier may spin down after inactivity (first request takes longer)

#### Issue: "Flutter doctor shows issues"
**Solution:** Follow Flutter doctor recommendations:
```bash
flutter doctor -v
```

#### Issue: "Build fails on iOS"
**Solution:**
```bash
cd ios
pod install
cd ..
flutter clean
flutter pub get
flutter build ios
```

#### Issue: "Web build can't find assets"
**Solution:**
```bash
flutter clean
flutter pub get
flutter build web --release
```

### Debug Mode

Run in verbose mode to see detailed logs:
```bash
flutter run -v
```

Enable additional logging in code by adding:
```dart
debugPrint("Your debug message");
```

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

### Reporting Issues
1. Check existing [issues](https://github.com/Yashvardhansingh2/ai_expense_tracker_app/issues)
2. Create a new issue with:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots (if applicable)
   - Environment details (OS, Flutter version)

### Pull Requests
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Run tests: `flutter test`
5. Lint your code: `flutter analyze`
6. Commit: `git commit -m "Add: your feature description"`
7. Push: `git push origin feature/your-feature`
8. Open a Pull Request

### Development Guidelines
- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed
- Keep PRs focused and atomic

### Areas for Contribution
- [ ] Expand test coverage (unit, widget, integration tests)
- [ ] Add expense editing functionality
- [ ] Implement category filtering
- [ ] Add CSV/PDF export feature
- [ ] Create data backup/restore
- [ ] Improve error handling and user feedback
- [ ] Add notifications for budget limits
- [ ] Implement recurring expenses
- [ ] Add multi-currency support
- [ ] Improve accessibility (a11y)

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

```
MIT License

Copyright (c) 2024 Yashvardhan Singh

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

## 🙏 Acknowledgments

- [Flutter Team](https://flutter.dev) for the amazing framework
- [Scikit-Learn](https://scikit-learn.org/) for ML algorithms
- [Hive](https://docs.hivedb.dev/) for local database
- [fl_chart](https://github.com/imaNNeo/fl_chart) for beautiful charts
- [Render](https://render.com) for backend hosting

---

## 📞 Contact & Support

**Developer:** Yashvardhan Singh

**Repository:** [github.com/Yashvardhansingh2/ai_expense_tracker_app](https://github.com/Yashvardhansingh2/ai_expense_tracker_app)

**Backend Repository:** [github.com/Yashvardhansingh2/ai_expense_tracker_backend](https://github.com/Yashvardhansingh2/ai_expense_tracker_backend)

For questions, issues, or suggestions, please [open an issue](https://github.com/Yashvardhansingh2/ai_expense_tracker_app/issues) on GitHub.

---

<div align="center">

**Made with ❤️ using Flutter and AI**

⭐ Star this repo if you find it helpful!

</div>
