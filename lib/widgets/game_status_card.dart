/*
 * GAME STATUS CARD WIDGET - WIN/LOSE MESSAGE DISPLAY COMPONENT
 * 
 * This widget displays celebratory or consolation messages when the game ends.
 * It provides clear visual feedback about the game outcome and shows the
 * correct word when the player loses.
 * 
 * Key features:
 * - Animated appearance with bounce effect for engagement
 * - Color-coded styling (green for wins, red for losses)  
 * - Emoji integration for emotional connection
 * - Correct word reveal on loss for learning
 * - Consistent card styling matching app design
 * - Only appears when game is complete (won or lost)
 * 
 * Visual design:
 * - Win state: Green background with celebration emojis
 * - Loss state: Red background with game over messaging
 * - Prominent typography for clear communication
 * - Shadow and border effects for visual emphasis
 * - Responsive layout for all screen sizes
 * 
 * This component enhances the emotional payoff of the game by providing
 * satisfying feedback for both successful and unsuccessful attempts.
 */

// Flutter framework imports
import 'package:flutter/material.dart';

// State management import
import 'package:provider/provider.dart';

// Application imports  
import '../models/game_state.dart'; // Game logic and state management

/// Widget that displays win/lose messages with appropriate styling and animation
/// Only visible when the game has ended, provides emotional feedback to player
/// Shows correct word on loss and celebration message on win
class GameStatusCard extends StatelessWidget {
  /// Constructor with optional key parameter for widget identification
  const GameStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        if (gameState.gameStatus == GameStatus.playing) {
          return const SizedBox.shrink();
        }

        final isWinner = gameState.gameStatus == GameStatus.won;
        final title = isWinner ? '🎉 You Won! 🎉' : '💀 Game Over 💀';
        final message = isWinner 
          ? 'Congratulations! You guessed the word correctly!'
          : 'Better luck next time! The word was: ${gameState.currentWord}';
        final color = isWinner ? const Color(0xFF10B981) : const Color(0xFFEF4444);
        final backgroundColor = isWinner ? const Color(0xFFD1FAE5) : const Color(0xFFFEE2E2);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceOut,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: color.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
              if (!isWinner) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: color),
                  ),
                  child: Text(
                    gameState.currentWord,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                      letterSpacing: 2,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}