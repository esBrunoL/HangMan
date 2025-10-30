/*
 * WORD DISPLAY WIDGET - GAME PROGRESS AND LETTER TRACKING COMPONENT
 * 
 * This widget shows the current state of the word being guessed, displaying
 * correctly guessed letters in their proper positions and underscores for
 * unknown letters. It also provides a visual history of all guessed letters
 * with color-coded feedback.
 * 
 * Key features:
 * - Word progress display with proper letter spacing
 * - Real-time updates as letters are guessed correctly
 * - Complete history of all guessed letters
 * - Color-coded letter tags (green=correct, red=wrong)
 * - Monospace font for consistent letter alignment
 * - Responsive layout that works on all screen sizes
 * 
 * Visual feedback system:
 * - Underscores (_) represent unguessed letters
 * - Actual letters appear when guessed correctly
 * - Green tags show correct letter guesses
 * - Red tags show incorrect letter guesses
 * 
 * This component is central to the game experience as it shows both
 * the player's progress toward winning and their guess history.
 */

// Flutter framework imports
import 'package:flutter/material.dart';

// State management import  
import 'package:provider/provider.dart';

// Application imports
import '../models/game_state.dart'; // Game logic and state management

/// Widget that displays the current word progress and guessed letter history
/// Shows underscores for unknown letters and reveals correct letters as guessed
/// Provides visual feedback for all player guesses with color-coded tags
class WordDisplay extends StatelessWidget {
  /// Constructor with optional key parameter for widget identification
  const WordDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                'Guess the Word',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                gameState.displayWord,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: Color(0xFF1F2937),
                  fontFamily: 'monospace',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              if (gameState.guessedLetters.isNotEmpty) ...[
                const Text(
                  'Guessed Letters:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: gameState.guessedLetters.map((letter) {
                    final isCorrect = gameState.isLetterCorrect(letter);
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isCorrect 
                          ? const Color(0xFFDCFCE7) 
                          : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isCorrect 
                            ? const Color(0xFF10B981) 
                            : const Color(0xFFEF4444),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isCorrect 
                            ? const Color(0xFF065F46) 
                            : const Color(0xFF991B1B),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}