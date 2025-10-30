// Required imports for Flutter state management and random number generation
import 'package:flutter/foundation.dart';
import 'dart:math';

/// Enumeration representing the current state of the Hangman game
/// - playing: Game is active and player can make guesses
/// - won: Player successfully guessed all letters
/// - lost: Player exceeded the maximum number of wrong guesses
enum GameStatus { playing, won, lost }

/// GameState class manages all game logic and state for the Hangman game
/// Uses ChangeNotifier to provide reactive updates to the UI when state changes
/// This is the core business logic class that handles:
/// - Word selection and management
/// - Letter guessing and validation
/// - Game progression and win/lose conditions
/// - Score tracking and game statistics
class GameState extends ChangeNotifier {
  
  /// Static word bank containing 50+ programming and technology-related terms
  /// These words are used for the Hangman game and provide varying difficulty levels
  /// Words are stored in uppercase for consistent processing
  /// Future enhancement: Could be loaded from external file or API
  static const List<String> _wordBank = [
    'FLUTTER', 'PROGRAMMING', 'COMPUTER', 'SCIENCE', 'TECHNOLOGY', 'DEVELOPER',
    'SOFTWARE', 'MOBILE', 'APPLICATION', 'DESIGN', 'CREATIVE', 'ALGORITHM',
    'DATABASE', 'NETWORK', 'INTERNET', 'WEBSITE', 'FRAMEWORK', 'LIBRARY',
    'FUNCTION', 'VARIABLE', 'OBJECT', 'CLASS', 'METHOD', 'INTERFACE',
    'PATTERN', 'SECURITY', 'TESTING', 'DEBUGGING', 'DEPLOYMENT', 'VERSION',
    'REPOSITORY', 'BRANCH', 'COMMIT', 'MERGE', 'PULL', 'PUSH',
    'JAVASCRIPT', 'PYTHON', 'KOTLIN', 'SWIFT', 'REACT', 'ANGULAR',
    'BACKEND', 'FRONTEND', 'FULLSTACK', 'API', 'REST', 'JSON',
    'HTML', 'CSS', 'RESPONSIVE', 'BOOTSTRAP', 'JQUERY', 'NODEJS'
  ];

  // ==================== PRIVATE STATE VARIABLES ====================
  
  /// The current word that the player needs to guess (stored in uppercase)
  /// This is randomly selected from the word bank when a new game starts
  String _currentWord = '';
  
  /// Set of letters that the player has already guessed (stored in uppercase)
  /// Using a Set ensures no duplicate letters and provides O(1) lookup performance
  /// Made final to prevent reassignment while allowing modifications to the set itself
  final Set<String> _guessedLetters = {};
  
  /// Current status of the game (playing, won, or lost)
  /// This determines which UI elements are shown and what actions are allowed
  GameStatus _gameStatus = GameStatus.playing;
  
  /// Counter for the number of incorrect letter guesses made by the player
  /// When this reaches _maxWrongGuesses, the player loses the game
  int _wrongGuesses = 0;
  
  /// Maximum number of wrong guesses allowed before the player loses
  /// Set to 6 as per traditional Hangman rules (though we don't draw the hangman)
  static const int _maxWrongGuesses = 6;
  
  /// Random number generator used for selecting words from the word bank
  /// Initialized once and reused for performance efficiency
  final Random _random = Random();

  // ==================== PUBLIC GETTERS ====================
  
  /// Returns the current word that needs to be guessed
  /// Used primarily for displaying the correct word when the game ends
  String get currentWord => _currentWord;
  
  /// Returns a copy of the guessed letters set to prevent external modification
  /// This ensures encapsulation while allowing UI to display guessed letters
  Set<String> get guessedLetters => Set.from(_guessedLetters);
  
  /// Returns the current game status (playing, won, lost)
  /// Used by UI to determine which components to show/hide
  GameStatus get gameStatus => _gameStatus;
  
  /// Returns the current count of wrong guesses (0 to 6)
  /// Displayed in the UI to show player progress toward losing
  int get wrongGuesses => _wrongGuesses;
  
  /// Returns how many wrong guesses the player has remaining (6 to 0)
  /// Calculated dynamically to show remaining "lives"
  int get wrongGuessesLeft => _maxWrongGuesses - _wrongGuesses;
  
  /// Returns the maximum number of wrong guesses allowed
  /// Used for UI display and game logic calculations
  int get maxWrongGuesses => _maxWrongGuesses;

  /// Returns the word with guessed letters revealed and unknown letters as underscores
  /// Example: If word is "FLUTTER" and "F", "L" are guessed, returns "F L _ _ _ _ _"
  /// This is the main display shown to the player during gameplay
  String get displayWord {
    return _currentWord.split('').map((letter) {
      // If the letter has been guessed, show it; otherwise show underscore
      if (_guessedLetters.contains(letter)) {
        return letter;
      } else {
        return '_';
      }
    }).join(' '); // Join with spaces for better readability
  }

  /// Checks if all letters in the current word have been successfully guessed
  /// This determines the win condition - when true, the player has won
  /// Uses the 'every' method for efficient checking of all letters
  bool get isWordComplete {
    return _currentWord.split('').every((letter) => _guessedLetters.contains(letter));
  }

  /// Returns set of letters that have been guessed and are present in the word
  /// These are the "correct" guesses that help reveal the word
  /// Used for UI display to show successful guesses in green
  Set<String> get correctGuesses {
    return _guessedLetters.where((letter) => _currentWord.contains(letter)).toSet();
  }

  /// Returns set of letters that have been guessed but are NOT in the word
  /// These are the "wrong" guesses that count toward the loss condition
  /// Used for UI display to show failed guesses in red
  Set<String> get wrongLetters {
    return _guessedLetters.where((letter) => !_currentWord.contains(letter)).toSet();
  }

  // ==================== PUBLIC METHODS ====================
  
  /// Initializes a new game with a fresh word and reset state
  /// This method is called when the app starts and when the player chooses to play again
  /// Ensures each game has a different randomly selected word from the word bank
  void startNewGame() {
    // Select a random word from the word bank
    _currentWord = _wordBank[_random.nextInt(_wordBank.length)];
    
    // Reset all game state to initial values
    _guessedLetters.clear();           // Clear all previous guesses
    _wrongGuesses = 0;                 // Reset wrong guess counter
    _gameStatus = GameStatus.playing;  // Set game to active state
    
    // Notify all listening widgets that the state has changed
    notifyListeners();
  }

  /// Processes a player's letter guess and updates the game state accordingly
  /// This is the core gameplay method called when a player selects a letter
  /// Handles validation, scoring, and win/loss condition checking
  /// 
  /// Parameters:
  ///   [letter] - The letter the player wants to guess (case insensitive)
  void guessLetter(String letter) {
    // Guard clauses: prevent invalid guesses
    if (_gameStatus != GameStatus.playing) return; // Game must be active
    if (_guessedLetters.contains(letter)) return;  // No duplicate guesses
    
    // Normalize input to uppercase for consistent processing
    letter = letter.toUpperCase();
    
    // Add the letter to the set of guessed letters
    _guessedLetters.add(letter);
    
    // Check if the guess was incorrect and increment wrong guess counter
    if (!_currentWord.contains(letter)) {
      _wrongGuesses++;
    }
    
    // Update the game status based on current state (win/loss check)
    _updateGameStatus();
    
    // Notify all listening widgets that the state has changed
    notifyListeners();
  }

  // ==================== PRIVATE HELPER METHODS ====================
  
  /// Internal method to evaluate and update the game status after each guess
  /// Checks for both win and lose conditions and updates the game status accordingly
  /// This method is called after every letter guess to maintain game state integrity
  void _updateGameStatus() {
    // Check lose condition first: too many wrong guesses
    if (_wrongGuesses >= _maxWrongGuesses) {
      _gameStatus = GameStatus.lost;
    } 
    // Check win condition: all letters have been guessed correctly
    else if (isWordComplete) {
      _gameStatus = GameStatus.won;
    }
    // If neither condition is met, game continues (status remains 'playing')
  }

  // ==================== UTILITY METHODS FOR UI ====================
  
  /// Checks if a specific letter has already been guessed by the player
  /// Used by the UI to determine button states (enabled/disabled)
  /// 
  /// Parameters:
  ///   [letter] - The letter to check (case insensitive)
  /// Returns: true if the letter has been guessed, false otherwise
  bool isLetterGuessed(String letter) {
    return _guessedLetters.contains(letter.toUpperCase());
  }

  /// Checks if a letter has been guessed AND is present in the current word
  /// Used by the UI to apply correct styling (green color) to guessed letters
  /// 
  /// Parameters:
  ///   [letter] - The letter to check (case insensitive)  
  /// Returns: true if letter was guessed and is in the word, false otherwise
  bool isLetterCorrect(String letter) {
    letter = letter.toUpperCase();
    return _guessedLetters.contains(letter) && _currentWord.contains(letter);
  }

  /// Checks if a letter has been guessed BUT is NOT present in the current word
  /// Used by the UI to apply wrong styling (red color) to incorrect guesses
  /// 
  /// Parameters:
  ///   [letter] - The letter to check (case insensitive)
  /// Returns: true if letter was guessed but not in word, false otherwise
  bool isLetterWrong(String letter) {
    letter = letter.toUpperCase();
    return _guessedLetters.contains(letter) && !_currentWord.contains(letter);
  }

  // ==================== CONSTRUCTOR ====================
  
  /// Constructor automatically initializes the game when the state object is created
  /// This ensures that a game is ready to play as soon as the app starts
  GameState() {
    startNewGame();
  }
}