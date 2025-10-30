/*
 * WRONG GUESS COUNTER WIDGET - GAME PROGRESS TRACKING COMPONENT
 * 
 * This widget displays the player's progress toward the loss condition by
 * showing both the current number of wrong guesses and the remaining attempts.
 * It provides crucial feedback for players to understand their game state.
 * 
 * Key features:
 * - Dual counter display (wrong guesses made / guesses remaining)
 * - Color-coded icons for visual clarity (red=bad, green=good)
 * - Real-time updates as guesses are made
 * - Clean, card-based design matching app aesthetic
 * - Clear labeling for accessibility
 * - Symmetric layout with visual separator
 * 
 * Display format:
 * - Left side: Wrong guesses count (0-6) with red X icon
 * - Right side: Remaining guesses (6-0) with green heart icon
 * - Visual separator between the two counters
 * - Professional typography and spacing
 * 
 * This component helps players understand their progress and creates
 * appropriate tension as the remaining guesses decrease.
 */

// Flutter framework imports
import 'package:flutter/material.dart';

// State management import
import 'package:provider/provider.dart';

// Application imports
import '../models/game_state.dart'; // Game logic and state management

/// Widget that displays wrong guess counter and remaining attempts
/// Provides dual perspective on game progress with color-coded visual feedback  
/// Helps players understand their current position relative to losing condition
class WrongGuessCounter extends StatelessWidget {
  /// Constructor with optional key parameter for widget identification
  const WrongGuessCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildCounter(
                'Wrong Guesses',
                '${gameState.wrongGuesses}',
                const Color(0xFFEF4444),
                Icons.close,
              ),
              Container(
                height: 40,
                width: 1,
                color: const Color(0xFFE5E7EB),
              ),
              _buildCounter(
                'Guesses Left',
                '${gameState.wrongGuessesLeft}',
                const Color(0xFF10B981),
                Icons.favorite,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCounter(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}