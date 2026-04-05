<h1 align="center">💸 AI Expense Tracker</h1>

<p align="center">
  <em>Track smarter. Spend wiser. Powered by AI.</em>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-brightgreen?logo=android&logoColor=white" alt="Platform">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License MIT">
  <img src="https://img.shields.io/badge/PRs-Welcome-brightgreen.svg" alt="PRs Welcome">
</p>

---

## 📱 App Screenshots

> 📸 Screenshots coming soon

---

## ✨ Features

- 🤖 **AI Expense Categorization** — Automatically predicts expense categories (Food & Dining, Transportation, Shopping, and more) from a natural-language description using a Flask/ML backend.
- 📊 **Visual Charts** — Interactive pie and bar charts powered by `fl_chart` for a clear breakdown of spending by category.
- ✏️ **Add / Edit / Delete Expenses** — Full CRUD support with local persistence via Hive (works fully offline).
- 🔄 **Real-time Sync with Backend** — Sends expense descriptions to the deployed Flask API for instant AI-powered category predictions.
- 💡 **Smart Insights** — Monthly expense summaries, budget forecasting (Linear Regression), and anomaly detection (Isolation Forest).
- 🌗 **Light & Dark Theme** — Material 3 design with system-adaptive theming.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **Framework** | Flutter (Dart) |
| **Language** | Dart 3.x |
| **HTTP Client** | `http ^1.1.0` |
| **Local Storage** | Hive + hive_flutter |
| **Charts** | fl_chart |
| **State Management** | `ValueListenableBuilder` + `setState` |
| **Backend** | Flask (Python) — hosted on Render |
| **ML Libraries** | Scikit-Learn, Pandas, Joblib |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart SDK `^3.9.2`)
- Android Studio / Xcode (for device/emulator)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/Yashvardhansingh2/ai_expense_tracker_app.git
cd ai_expense_tracker_app

# 2. Install dependencies
flutter pub get

# 3. Generate Hive adapters (required after any model change)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Connecting to the Backend

The app is pre-configured to use the deployed Flask backend:

```
https://ai-expense-tracker-backend-xms7.onrender.com
```

| Endpoint | Purpose |
|---|---|
| `POST /predict` | Predict expense category from text |
| `POST /summarize` | AI-generated monthly expense summary |
| `POST /detect_anomalies` | Detect unusual spending patterns |
| `POST /forecast` | Budget forecast using Linear Regression |

To point the app at a **local** backend instead, update the `backendUrl` constant in `lib/main.dart`:

```dart
final String backendUrl = 'http://10.0.2.2:5000/predict'; // Android emulator
// or
final String backendUrl = 'http://localhost:5000/predict'; // iOS simulator
```

---

## 📁 Folder Structure

```
ai_expense_tracker_app/
├── lib/
│   ├── main.dart                  # App entry point, home screen & AI prediction
│   ├── dashboard_screen.dart      # Expense dashboard with summaries
│   ├── charts_screen.dart         # Visual charts (pie/bar)
│   ├── ai_summary_helper.dart     # Helper for AI summary calls
│   ├── theme.dart                 # App theme configuration
│   ├── models/
│   │   ├── expense_model.dart     # Hive Expense model (typeId: 0)
│   │   ├── expense_model.g.dart   # Generated Hive adapter
│   │   ├── budget_model.dart      # Hive Budget model (typeId: 1)
│   │   └── budget_model.g.dart    # Generated Hive adapter
│   └── screens/
│       └── insights_screen.dart   # AI insights, anomaly detection & forecasting
├── assets/
│   ├── icon.png                   # App launcher icon
│   └── overlay.png                # Splash screen overlay
├── backend/                       # Flask backend source code
├── pubspec.yaml
└── README.md
```

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/your-feature`
3. **Commit** your changes: `git commit -m "feat: add your feature"`
4. **Push** to the branch: `git push origin feature/your-feature`
5. **Open** a Pull Request

Please make sure your code follows the existing style and that all existing tests pass (`flutter test`).

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<p align="center">Made with ❤️ by <a href="https://github.com/Yashvardhansingh2">Yashvardhan Singh</a></p>
