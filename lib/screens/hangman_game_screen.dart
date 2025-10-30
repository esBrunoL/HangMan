/*
 * HANGMAN GAME SCREEN - MAIN GAME INTERFACE
 * 
 * This file contains the main game screen that displays the complete Hangman game interface.
 * It orchestrates all the game components and handles the overall layout and user experience.
 * 
 * Key responsibilities:
 * - Compose all game widgets into a cohesive interface
 * - Handle responsive layout for different screen sizes
 * - Manage game controls (new game, play again buttons)
 * - Provide consistent styling and spacing
 * 
 * Layout Structure:
 * - App bar with game title
 * - Game status card (win/lose messages)
 * - Wrong guess counter display
 * - Word display with progress
 * - Alphabet grid for letter selection
 * - Game control buttons
 * 
 * The screen uses Consumer widget to listen for GameState changes and
 * rebuild the UI reactively when the game state updates.
 */

// Flutter framework imports
import 'package:flutter/material.dart';

// State management import
import 'package:provider/provider.dart';

// Application imports
import '../models/game_state.dart';           // Game logic and state
import '../widgets/alphabet_grid.dart';       // Letter selection component
import '../widgets/word_display.dart';        // Word progress display
import '../widgets/game_status_card.dart';    // Win/lose status messages
import '../widgets/wrong_guess_counter.dart'; // Guess tracking display

/// Main game screen widget that presents the complete Hangman game interface
/// This is a stateless widget as all state is managed by the GameState class
/// Uses Consumer pattern to reactively update UI when game state changes
class HangmanGameScreen extends StatelessWidget {
  /// Constructor with optional key parameter for widget identification
  const HangmanGameScreen({super.key});

  /// Builds the main game screen layout with all game components
  /// Returns a Scaffold containing the app bar and game content
  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic material design layout structure
    return Scaffold(
      // Deep blue background color for modern, professional appearance
      backgroundColor: const Color(0xFF1E3A8A),
      
      // App bar with game title and consistent styling
      appBar: AppBar(
        title: const Text(
          'Hangman Game',
          style: TextStyle(
            fontSize: 24,           // Large, readable title
            fontWeight: FontWeight.bold,
            color: Colors.white,    // High contrast for accessibility
          ),
        ),
        // Slightly lighter blue for visual hierarchy
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,              // Flat design, no shadow
        centerTitle: true,         // Center alignment for balance
      ),
      // Body contains all game content with reactive state management
      body: Consumer<GameState>(
        // Consumer rebuilds this widget whenever GameState changes
        // This provides reactive UI updates when game state is modified
        builder: (context, gameState, child) {
          // SingleChildScrollView ensures content is accessible on smaller screens
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Top spacing for visual breathing room
                const SizedBox(height: 20),
                
                // Game Status Card - Only shown when game is won or lost
                // Conditional rendering based on game state
                if (gameState.gameStatus != GameStatus.playing)
                  const GameStatusCard(),
                
                const SizedBox(height: 20),
                
                // Wrong Guess Counter - Shows current wrong guesses and remaining attempts
                // Always visible to keep player informed of their progress
                const WrongGuessCounter(),
                
                const SizedBox(height: 30),
                
                // Word Display - Shows current word progress with guessed letters
                // Core component that displays the main game objective
                const WordDisplay(),
                
                const SizedBox(height: 40),
                
                // Alphabet Grid - Interactive letter selection interface
                // Main input mechanism for player guesses
                const AlphabetGrid(),
                
                const SizedBox(height: 30),
                
                // Play Again Button - Only shown when game ends (win or loss)
                // Prominent call-to-action for continuing gameplay
                if (gameState.gameStatus != GameStatus.playing)
                  _buildPlayAgainButton(context, gameState),
                
                const SizedBox(height: 20),
                
                // New Game Button - Always available for fresh start
                // Secondary action that allows restarting at any time
                _buildNewGameButton(context, gameState),
              ],
            ),
          );
        },
      ),
    );
  }

  // ==================== PRIVATE UI BUILDER METHODS ====================
  
  /// Builds the primary "Play Again" button shown after game completion
  /// This button is prominently styled to encourage continued gameplay
  /// Only appears when the game has ended (win or loss state)
  /// 
  /// Parameters:
  ///   [context] - Build context for accessing theme and navigation
  ///   [gameState] - Current game state for triggering new game
  /// 
  /// Returns: Styled ElevatedButton widget for playing again
  Widget _buildPlayAgainButton(BuildContext context, GameState gameState) {
    return Container(
      width: double.infinity,  // Full width for prominence
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        // Trigger new game when pressed
        onPressed: () => gameState.startNewGame(),
        
        // Primary button styling with green color for positive action
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF10B981), // Success green color
          foregroundColor: Colors.white,            // High contrast text
          padding: const EdgeInsets.symmetric(vertical: 16), // Comfortable touch target
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Modern rounded corners
          ),
          elevation: 4,  // Subtle shadow for depth and emphasis
        ),
        
        child: const Text(
          'Play Again',
          style: TextStyle(
            fontSize: 18,              // Large, readable text
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Builds the secondary "New Game" button available at all times
  /// This button provides a way to restart the game during any state
  /// Styled as an outlined button to be less prominent than "Play Again"
  /// 
  /// Parameters:
  ///   [context] - Build context for accessing theme and navigation
  ///   [gameState] - Current game state for triggering new game
  /// 
  /// Returns: Styled OutlinedButton widget for starting new game
  Widget _buildNewGameButton(BuildContext context, GameState gameState) {
    return Container(
      width: double.infinity,  // Full width for consistency
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: OutlinedButton(
        // Trigger new game when pressed (same action as Play Again)
        onPressed: () => gameState.startNewGame(),
        
        // Secondary button styling with outlined appearance
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,           // White text for contrast
          side: const BorderSide(               // White border for definition
            color: Colors.white, 
            width: 2
          ),
          padding: const EdgeInsets.symmetric(vertical: 16), // Consistent padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Matching border radius
          ),
        ),
        
        child: const Text(
          'New Game',
          style: TextStyle(
            fontSize: 16,              // Slightly smaller than primary button
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}