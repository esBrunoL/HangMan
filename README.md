# 🎮 Flutter Hangman Game

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Live Demo](https://img.shields.io/badge/Live_Demo-🎮_Play_Now-brightgreen.svg?style=for-the-badge)](https://esBrunoL.github.io/HangMan/)

A beautifully designed, professional-quality Hangman word guessing game built with Flutter and Provider state management. Features modern UI design, smooth animations, and an engaging user experience.

## 🌐 Live Demo

**🎮 [Play the game online now!](https://esBrunoL.github.io/HangMan/)**

Experience the full Flutter Hangman game directly in your browser - no installation required!

## 🎯 Game Features

### 🎪 **Gameplay**
- 🔤 **Interactive Letter Selection**: Touch-friendly alphabet grid with instant feedback
- 🎯 **Word Guessing**: 50+ programming and technology-related words
- 📊 **Progress Tracking**: Real-time display of wrong guesses (0-6) and remaining attempts (6-0)
- 🏆 **Win/Lose States**: Clear victory celebrations and game over messages
- 🔄 **Endless Replay**: Play again with different words each time
- 📝 **Guess History**: Complete letter history with color-coded feedback

### 🎨 **Visual Design**
- 🌊 **Modern UI**: Professional Material Design with deep blue gradient theme
- 🃏 **Card Layout**: Clean white cards with elegant shadows and rounded corners
- 🎵 **Smooth Animations**: Engaging transitions and interactive button states
- 🌈 **Color-Coded Feedback**: 
  - 🔵 **Blue**: Available letters
  - 🟢 **Green**: Correct guesses
  - 🔴 **Red**: Wrong guesses
- 📱 **Responsive Design**: Optimized for all screen sizes and devices

## 🎮 Game Rules

1. **Objective**: Guess the hidden word by selecting letters
2. **Lives System**: You have 6 wrong guesses before losing
3. **Letter Reveal**: Correct letters appear in all their positions immediately
4. **Progress Display**: Track your guesses and remaining attempts in real-time
5. **Victory Condition**: Reveal all letters before running out of guesses
6. **New Games**: Each game features a different randomly selected word

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (>=3.0.0)
- [Dart SDK](https://dart.dev/get-dart) (>=3.0.0)
- IDE: [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/esBrunoL/HangMan.git
   cd HangMan
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For mobile/desktop
   flutter run
   
   # For web
   flutter run -d chrome
   
   # For web server
   flutter run -d web-server --web-port 8080
   ```

### Building for Production

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS and Xcode)
flutter build ios --release

# Web
flutter build web --release

# Windows (requires Windows)
flutter build windows --release

# macOS (requires macOS)
flutter build macos --release
```

## 🏗️ Technical Architecture

### 📁 **Project Structure**
```
lib/
├── main.dart                     # 🚀 Application entry point
├── models/
│   └── game_state.dart          # 🧠 Core game logic & state management
├── screens/
│   └── hangman_game_screen.dart # 🖥️ Main game interface
└── widgets/
    ├── alphabet_grid.dart       # 🔤 Interactive letter selection
    ├── word_display.dart        # 📝 Word progress & guess history
    ├── game_status_card.dart    # 🏆 Win/lose status messages
    └── wrong_guess_counter.dart # 📊 Guess tracking display
```

### 🔧 **Technology Stack**
- **Framework**: [Flutter](https://flutter.dev) - Google's UI toolkit for cross-platform development
- **Language**: [Dart](https://dart.dev) - Modern, efficient programming language
- **State Management**: [Provider](https://pub.dev/packages/provider) - Reactive state management pattern
- **Architecture**: Clean Architecture with separation of concerns
- **UI Components**: Material Design with custom styling

### 🎨 **Design Patterns**
- **Provider Pattern**: Reactive state management with ChangeNotifier
- **Consumer Pattern**: Efficient UI updates with targeted rebuilds
- **Composition**: Modular widget architecture for maintainability
- **Single Responsibility**: Each class has one clear purpose

## 📱 Platform Support

| Platform | Status | Notes |
|----------|--------|-------|
| 🤖 **Android** | ✅ Supported | Android 5.0+ (API 21+) |
| 🍎 **iOS** | ✅ Supported | iOS 11.0+ |
| 🌐 **Web** | ✅ Supported | Modern browsers |
| 🖥️ **Windows** | ✅ Supported | Windows 10+ |
| 🍎 **macOS** | ✅ Supported | macOS 10.14+ |
| 🐧 **Linux** | ✅ Supported | Ubuntu 18.04+ |

## 📦 Dependencies

```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.1      # State management
  cupertino_icons: ^1.0.2  # iOS-style icons

dev_dependencies:
  flutter_test: sdk
  flutter_lints: ^3.0.0    # Code analysis
```

## 🎯 Game Specifications

- **Word Bank**: 50+ carefully curated programming and technology terms
- **Difficulty**: Balanced mix of common and challenging words
- **Lives System**: Traditional 6-mistake maximum
- **Letter Handling**: Instant reveal of all matching letter positions
- **State Persistence**: Complete game state management throughout session
- **Performance**: Optimized for smooth 60fps gameplay

## 🌐 Deployment

### GitHub Pages
The game is automatically deployed to GitHub Pages using the `gh-pages` branch:
- **Live URL**: https://esBrunoL.github.io/HangMan/
- **Auto-deployment**: Optimized web build with correct base href
- **PWA Ready**: Includes manifest.json and service worker for offline play

## 🤝 Contributing

We welcome contributions! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### 💡 **Enhancement Ideas**
- 🔊 Sound effects and background music
- 🏆 Achievement system and score tracking
- 🌍 Multiple language support
- 🎨 Additional themes and customization
- 👥 Multiplayer functionality
- 📚 Custom word categories and difficulty levels

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🎮 Screenshots

> 🖼️ *Screenshots coming soon! The game features a beautiful modern interface with smooth animations and professional design.*

## 👨‍💻 Author

**Bruno** - *Initial work and development*

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Provider package maintainers for excellent state management
- Material Design guidelines for design inspiration
- The programming community for word inspiration

---

**⭐ Star this repository if you found it helpful!**

**🐛 Found a bug or have a suggestion? Please [open an issue](../../issues)!**