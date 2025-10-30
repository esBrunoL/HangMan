/*
 * ALPHABET GRID WIDGET - INTERACTIVE LETTER SELECTION COMPONENT
 * 
 * This widget provides the main interaction interface for the Hangman game.
 * It displays all 26 letters of the alphabet in a grid layout, allowing
 * players to select letters to guess the hidden word.
 * 
 * Key features:
 * - 7-column responsive grid layout for optimal spacing
 * - Dynamic button states (available, correct, wrong, disabled)
 * - Color-coded visual feedback for different guess outcomes
 * - Touch-friendly button sizing for mobile devices
 * - Animated transitions for enhanced user experience
 * 
 * Button States:
 * - Blue: Available letter (can be guessed)
 * - Green: Correct guess (letter is in the word)  
 * - Red: Wrong guess (letter is not in the word)
 * - Disabled: Game over or letter already guessed
 * 
 * The component uses Consumer to listen for GameState changes and
 * reactively update button appearances based on game progress.
 */

// Flutter framework imports
import 'package:flutter/material.dart';

// State management import
import 'package:provider/provider.dart';

// Application imports
import '../models/game_state.dart'; // Game logic and state management

/// Interactive alphabet grid widget for letter selection in Hangman game
/// Displays all 26 letters with color-coded feedback and touch interaction
/// Automatically disables letters after they've been guessed or when game ends
class AlphabetGrid extends StatelessWidget {
  /// Constructor with optional key parameter for widget identification
  const AlphabetGrid({super.key});

  /// Complete English alphabet arranged for optimal 7-column grid display
  /// Letters are ordered to create visually balanced rows in the grid layout
  static const List<String> _alphabet = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G',    // Row 1: 7 letters
    'H', 'I', 'J', 'K', 'L', 'M', 'N',    // Row 2: 7 letters  
    'O', 'P', 'Q', 'R', 'S', 'T', 'U',    // Row 3: 7 letters
    'V', 'W', 'X', 'Y', 'Z'               // Row 4: 5 letters (centered)
  ];

  /// Builds the interactive alphabet grid with responsive layout and styling
  /// Uses Consumer pattern to reactively update button states based on game progress
  @override
  Widget build(BuildContext context) {
    // Consumer listens to GameState changes and rebuilds when state updates
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        // Container provides the white card background with elegant styling
        return Container(
          padding: const EdgeInsets.all(20),  // Internal spacing for grid content
          margin: const EdgeInsets.symmetric(horizontal: 10), // External margins
          
          // Card-style decoration with rounded corners and shadow
          decoration: BoxDecoration(
            color: Colors.white,              // Clean white background
            borderRadius: BorderRadius.circular(16), // Modern rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Subtle shadow
                blurRadius: 8,                // Soft shadow blur
                offset: const Offset(0, 4),   // Slight downward offset
              ),
            ],
          ),
          child: Column(
            children: [
              // Header text providing clear instruction to users
              const Text(
                'Select a Letter',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),  // Professional gray color
                ),
              ),
              const SizedBox(height: 16),  // Spacing between header and grid
              
              // Grid layout for alphabet letters with 7-column responsive design
              GridView.builder(
                shrinkWrap: true,  // Only take needed space, don't expand
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling
                
                // Grid configuration for optimal letter display
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,        // 7 letters per row for phone screens
                  crossAxisSpacing: 8,      // Horizontal space between buttons
                  mainAxisSpacing: 8,       // Vertical space between buttons  
                  childAspectRatio: 1,      // Square buttons (1:1 ratio)
                ),
                
                itemCount: _alphabet.length, // Build all 26 letters
                
                // Build individual letter button with state-based styling
                itemBuilder: (context, index) {
                  final letter = _alphabet[index];
                  
                  // Determine button state based on game progress
                  final isGuessed = gameState.isLetterGuessed(letter);
                  final isCorrect = gameState.isLetterCorrect(letter);
                  final isWrong = gameState.isLetterWrong(letter);
                  final isGameOver = gameState.gameStatus != GameStatus.playing;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: ElevatedButton(
                      onPressed: (isGuessed || isGameOver) 
                        ? null 
                        : () => gameState.guessLetter(letter),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _getButtonColor(isGuessed, isCorrect, isWrong),
                        foregroundColor: _getTextColor(isGuessed, isCorrect, isWrong),
                        disabledBackgroundColor: _getButtonColor(isGuessed, isCorrect, isWrong),
                        disabledForegroundColor: _getTextColor(isGuessed, isCorrect, isWrong),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: isGuessed ? 0 : 2,
                      ),
                      child: Text(
                        letter,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getButtonColor(bool isGuessed, bool isCorrect, bool isWrong) {
    if (!isGuessed) return const Color(0xFF3B82F6); // Blue for unguessed
    if (isCorrect) return const Color(0xFF10B981); // Green for correct
    if (isWrong) return const Color(0xFFEF4444); // Red for wrong
    return const Color(0xFF6B7280); // Gray fallback
  }

  Color _getTextColor(bool isGuessed, bool isCorrect, bool isWrong) {
    return Colors.white; // All text is white for good contrast
  }
}