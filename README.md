# 💸 AI Expense Tracker

<div align="center">

**An intelligent expense tracking application powered by Machine Learning**

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?style=flat&logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2+-0175C2?style=flat&logo=dart)](https://dart.dev)
[![Flask](https://img.shields.io/badge/Flask-Python-000000?style=flat&logo=flask)](https://flask.palletsprojects.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Architecture](#-architecture)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Usage](#-usage)
- [API Documentation](#-api-documentation)
- [Testing](#-testing)
- [Contributing](#-contributing)

---

## 🎯 Overview

**AI Expense Tracker** is a cross-platform mobile and web application that revolutionizes personal finance management through artificial intelligence. The application automatically categorizes expenses, detects anomalous spending patterns, and provides predictive analytics to help users make informed financial decisions.

### Key Highlights

- 🤖 **AI-Powered Categorization**: Automatically classifies expenses using NLP-based keyword matching
- 📊 **Visual Analytics**: Interactive charts and dashboards for comprehensive spending analysis
- 🔮 **Predictive Insights**: Machine learning models for budget forecasting and anomaly detection
- 💾 **Offline-First Architecture**: Local data persistence with Hive for seamless offline functionality
- 🎨 **Modern UI/UX**: Material Design 3 with gradient themes and smooth animations
- 🌐 **Cross-Platform**: Supports Android, iOS, macOS, Windows, Linux, and Web

---

## ✨ Features

### 🎯 Core Functionality

#### **AI-Based Expense Categorization**
- Intelligent category prediction using NLP and keyword mapping
- 10 predefined spending categories:
  - 🍔 Food & Dining
  - 🚗 Transportation
  - 🎬 Entertainment
  - 💪 Health & Fitness
  - 🏠 Housing & Utilities
  - 🛍️ Shopping
  - 📚 Education
  - ✈️ Travel
  - 💰 Financial
  - 📦 Uncategorized
- Dynamic category color-coding for visual clarity

#### **Interactive Dashboard**
- Real-time expense tracking with monthly summaries
- Category-wise spending breakdown
- Budget limit management with visual progress indicators
- Spending trend analysis with line charts
- Smart financial tips based on spending patterns
- Top spending category identification

#### **Advanced Analytics & Insights**
- **AI Summarization**: Natural language summaries of spending patterns
- **Anomaly Detection**: Isolation Forest algorithm identifies unusual transactions
- **Budget Forecasting**: Linear Regression predicts future monthly spending
- **Visual Reports**: Pie charts showing expense distribution by category

#### **Data Management**
- Local-first architecture with Hive database
- Offline functionality - no internet required for basic operations
- Real-time data synchronization
- Expense editing and deletion capabilities

### 🎨 User Interface

- **Material Design 3** with light and dark theme support
- **Gradient Backgrounds**: Beautiful blue → purple → pink gradients
- **Smooth Animations**: Animated containers and transitions
- **Responsive Design**: Optimized for all screen sizes
- **Custom App Icon**: Professional branding with splash screen

---

## 🏗️ Architecture

### System Design

```
┌─────────────────────────────────────────────────────────────┐
│                     Flutter Frontend                         │
│  ┌───────────┐  ┌────────────┐  ┌──────────────┐           │
│  │   Home    │  │ Dashboard  │  │   Insights   │           │
│  │  Screen   │  │   Screen   │  │    Screen    │           │
│  └─────┬─────┘  └─────┬──────┘  └──────┬───────┘           │
│        │              │                 │                    │
│        └──────────────┼─────────────────┘                    │
│                       │                                      │
│              ┌────────▼─────────┐                           │
│              │   Hive Database  │                           │
│              │  (Local Storage) │                           │
│              └────────┬─────────┘                           │
│                       │                                      │
│                       │ HTTP/REST API                        │
└───────────────────────┼──────────────────────────────────────┘
                        │
                        ▼
┌─────────────────────────────────────────────────────────────┐
│                   Flask Backend (Python)                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  /predict    │  │ /summarize   │  │  /forecast   │     │
│  │   Endpoint   │  │   Endpoint   │  │   Endpoint   │     │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘     │
│         │                  │                  │              │
│         └──────────────────┼──────────────────┘              │
│                            │                                 │
│              ┌─────────────▼──────────────┐                 │
│              │  Machine Learning Models   │                 │
│              │  • NLP Categorization      │                 │
│              │  • Isolation Forest        │                 │
│              │  • Linear Regression       │                 │
│              └────────────────────────────┘                 │
│                                                              │
│              Hosted on Render.com                           │
└─────────────────────────────────────────────────────────────┘
```

### Data Models

#### Expense Model
```dart
class Expense {
  String description;    // User-entered expense description
  double amount;         // Transaction amount (₹)
  String category;       // AI-predicted category
  DateTime date;         // Transaction timestamp
}
```

#### Budget Model
```dart
class Budget {
  String category;       // Budget category
  double limit;          // Monthly spending limit (₹)
}
```

---

## 🛠️ Tech Stack

### Frontend

| Technology | Version | Purpose |
|------------|---------|---------|
| **Flutter** | 3.9.2+ | Cross-platform UI framework |
| **Dart** | 3.9.2+ | Programming language |
| **Hive** | 2.2.3 | Local NoSQL database |
| **Hive Flutter** | 1.1.0 | Flutter integration for Hive |
| **HTTP** | 1.1.0 | REST API communication |
| **FL Chart** | 1.1.1 | Data visualization (charts) |
| **Material Design 3** | - | UI design system |

### Backend

| Technology | Version | Purpose |
|------------|---------|---------|
| **Flask** | Latest | Python web framework |
| **Scikit-Learn** | Latest | Machine learning library |
| **Pandas** | Latest | Data manipulation |
| **Joblib** | Latest | Model serialization |
| **Isolation Forest** | - | Anomaly detection algorithm |
| **Linear Regression** | - | Budget forecasting model |

### Infrastructure

- **Hosting**: Render.com (Flask backend)
- **API Endpoint**: `https://ai-expense-tracker-backend-xms7.onrender.com`
- **Storage**: Local device storage via Hive
- **Platforms**: Android, iOS, macOS, Windows, Linux, Web

---

## 📁 Project Structure

```
ai_expense_tracker_app/
├── lib/                          # Main Dart source code
│   ├── main.dart                 # App entry point & home screen
│   ├── theme.dart                # Color and theming constants
│   ├── ai_summary_helper.dart    # Local expense summarization
│   ├── dashboard_screen.dart     # Monthly summary & budget tracking
│   ├── charts_screen.dart        # Pie chart visualization
│   ├── models/
│   │   ├── expense_model.dart    # Hive-based Expense data model
│   │   ├── expense_model.g.dart  # Generated adapter (Hive)
│   │   ├── budget_model.dart     # Hive-based Budget data model
│   │   └── budget_model.g.dart   # Generated adapter (Hive)
│   └── screens/
│       └── insights_screen.dart  # AI-powered insights page
├── test/
│   └── widget_test.dart          # Widget and integration tests
├── assets/                       # App assets
│   ├── icon.png                  # App icon
│   └── overlay.png               # Gradient overlay texture
├── android/                      # Android-specific configuration
├── ios/                          # iOS-specific configuration
├── macos/                        # macOS-specific configuration
├── linux/                        # Linux-specific configuration
├── web/                          # Web-specific configuration
├── windows/                      # Windows-specific configuration
├── pubspec.yaml                  # Dart dependencies & project config
├── analysis_options.yaml         # Linting rules
└── README.md                     # Project documentation
```

---

## 📥 Installation

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.9.2 or higher) - [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (3.9.2 or higher) - Comes with Flutter
- **Git** - For cloning the repository
- **IDE** (VS Code, Android Studio, or IntelliJ IDEA)
- **Xcode** (for macOS/iOS development) - macOS only
- **Android Studio** (for Android development)

### Step 1: Clone the Repository

```bash
git clone https://github.com/Yashvardhansingh2/ai_expense_tracker_app.git
cd ai_expense_tracker_app
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Generate Hive Adapters

The app uses Hive for local storage and requires generated adapter files:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 4: Verify Installation

Check if Flutter is properly configured:

```bash
flutter doctor
```

Ensure all required components are installed and configured correctly.

---

## ⚙️ Configuration

### Backend API Configuration

The app communicates with a Flask backend for AI-powered features. The backend URL is configured in `lib/main.dart`:

```dart
final String backendUrl = 'https://ai-expense-tracker-backend-xms7.onrender.com/predict';
```

To use a custom backend:

1. Update the `backendUrl` in `lib/main.dart`
2. Ensure the backend implements the required API endpoints (see [API Documentation](#-api-documentation))

### App Icon & Splash Screen

The app uses custom icons and splash screens configured in `pubspec.yaml`:

```yaml
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon.png"

flutter_native_splash:
  color: "#6D83F2"
  image: assets/icon.png
```

To regenerate icons and splash screens after changes:

```bash
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

---

## 🚀 Usage

### Running the Application

#### Desktop (macOS, Windows, Linux)

```bash
# macOS
flutter run -d macos

# Windows
flutter run -d windows

# Linux
flutter run -d linux
```

#### Mobile (Android, iOS)

```bash
# Android (device or emulator)
flutter run -d android

# iOS (simulator or device)
flutter run -d ios
```

#### Web

```bash
flutter run -d chrome
```

### Building for Production

#### Android APK

```bash
flutter build apk --release
```

#### iOS App

```bash
flutter build ios --release
```

#### macOS App

```bash
flutter build macos --release
```

#### Web

```bash
flutter build web --release
```

---

## 📱 Application Screens

### 1. Home Screen
- **Purpose**: Primary expense entry and tracking
- **Features**:
  - Add new expenses with description and amount
  - AI-powered category prediction
  - Real-time expense list with color-coded categories
  - Navigation to Dashboard, Charts, and Insights

### 2. Dashboard Screen
- **Purpose**: Monthly expense overview and budget management
- **Features**:
  - Total monthly spending display
  - Category-wise breakdown
  - Budget limit tracking with progress bars
  - Spending trends with line charts
  - Add/edit budget limits per category
  - AI-generated financial tips

### 3. Charts Screen
- **Purpose**: Visual expense analysis
- **Features**:
  - Interactive pie chart showing expense distribution
  - Detailed expense list with amounts
  - Delete expenses functionality
  - Category-to-color mapping

### 4. Insights Screen
- **Purpose**: AI-powered analytics and predictions
- **Features**:
  - **Summarize**: Get AI-generated spending summaries
  - **Detect Anomalies**: Identify unusual spending patterns
  - **Forecast**: Predict next month's budget based on historical data

---

## 📡 API Documentation

The app integrates with a Flask backend that provides ML-powered features.

### Base URL
```
https://ai-expense-tracker-backend-xms7.onrender.com
```

### Endpoints

#### 1. Predict Category

**POST** `/predict`

Predicts the category of an expense based on its description.

**Request Body:**
```json
{
  "text": "Pizza dinner at restaurant"
}
```

**Response:**
```json
{
  "category": "Food & Dining"
}
```

#### 2. Summarize Expenses

**POST** `/summarize`

Generates an AI summary of expenses with category percentages.

**Request Body:**
```json
{
  "expenses": [
    {"category": "Food & Dining", "amount": 500},
    {"category": "Transportation", "amount": 200},
    {"category": "Entertainment", "amount": 300}
  ]
}
```

**Response:**
```json
{
  "summary": "Your spending is distributed across 3 categories with Food & Dining being the highest at 50%.",
  "percentages": {
    "Food & Dining": 50.0,
    "Transportation": 20.0,
    "Entertainment": 30.0
  }
}
```

#### 3. Detect Anomalies

**POST** `/detect_anomalies`

Identifies unusual spending patterns using Isolation Forest algorithm.

**Request Body:**
```json
{
  "expenses": [
    {"category": "Food & Dining", "amount": 500},
    {"category": "Shopping", "amount": 5000},
    {"category": "Transportation", "amount": 200}
  ]
}
```

**Response:**
```json
{
  "anomalies": [
    {"category": "Shopping", "amount": 5000}
  ]
}
```

#### 4. Forecast Budget

**POST** `/forecast`

Predicts next month's budget using Linear Regression.

**Request Body:**
```json
{
  "expenses": [
    {"category": "Food & Dining", "amount": 500},
    {"category": "Transportation", "amount": 200},
    {"category": "Entertainment", "amount": 300}
  ]
}
```

**Response:**
```json
{
  "forecast": 1000.0
}
```

---

## 🧪 Testing

### Running Tests

The project includes widget and integration tests:

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Test Files

- `test/widget_test.dart` - Basic widget tests for app initialization and home screen

### Manual Testing Checklist

- [ ] Add a new expense and verify AI categorization
- [ ] Check offline functionality (disable internet)
- [ ] Navigate between all screens (Home, Dashboard, Charts, Insights)
- [ ] Add budget limits and verify progress indicators
- [ ] Test expense deletion
- [ ] Verify data persistence after app restart
- [ ] Test dark mode and light mode themes
- [ ] Try AI summarization, anomaly detection, and forecasting

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

### How to Contribute

1. **Fork the Repository**
   ```bash
   git clone https://github.com/Yashvardhansingh2/ai_expense_tracker_app.git
   cd ai_expense_tracker_app
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Write clean, documented code
   - Follow Dart style guidelines
   - Add tests for new features
   - Update documentation as needed

4. **Run Tests and Linter**
   ```bash
   flutter test
   flutter analyze
   ```

5. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

6. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Describe your changes in detail

### Code Style

- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused

### Reporting Issues

Found a bug or have a feature request?

1. Check if the issue already exists
2. Create a new issue with:
   - Clear title and description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Screenshots (if applicable)
   - Device/platform information

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- **Flutter Team** - For the amazing cross-platform framework
- **Hive** - For fast and efficient local storage
- **FL Chart** - For beautiful data visualizations
- **Scikit-Learn** - For powerful machine learning tools
- **Render** - For hosting the backend infrastructure

---

## 📞 Contact

**Developer**: Yashvardhan Singh

**Repository**: [https://github.com/Yashvardhansingh2/ai_expense_tracker_app](https://github.com/Yashvardhansingh2/ai_expense_tracker_app)

---

<div align="center">

**Made with ❤️ using Flutter and Machine Learning**

⭐ Star this repository if you find it helpful!

</div>
