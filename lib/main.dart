/*
 * HANGMAN GAME - MAIN APPLICATION ENTRY POINT
 * 
 * This file serves as the entry point for the Flutter Hangman game application.
 * It sets up the app structure, state management, theming, and navigation.
 * 
 * Key responsibilities:
 * - Initialize the Flutter application
 * - Set up Provider state management for game logic
 * - Configure app-wide theming and styling
 * - Define the main navigation structure
 * 
 * Architecture:
 * - Uses Provider pattern for state management
 * - Single-screen app with the main game interface
 * - Material Design components for consistent UI
 */

// Flutter framework imports
import 'package:flutter/material.dart';

// State management import - Provider pattern for reactive UI updates
import 'package:provider/provider.dart';

// Application-specific imports
import 'models/game_state.dart';           // Core game logic and state management
import 'screens/hangman_game_screen.dart'; // Main game interface screen

/// Application entry point - called when the app starts
/// This function initializes and runs the Flutter application
void main() {
  // Launch the Hangman game application
  runApp(const HangmanApp());
}

/// Root application widget that sets up the overall app structure
/// This is a stateless widget as the app structure doesn't change during runtime
/// Handles app-level configuration including state management and theming
class HangmanApp extends StatelessWidget {
  /// Constructor with optional key parameter for widget identification
  const HangmanApp({super.key});

  /// Builds the root widget tree for the entire application
  /// Sets up state management, theming, and navigation structure
  @override
  Widget build(BuildContext context) {
    // Wrap the entire app in a ChangeNotifierProvider to make GameState
    // available throughout the widget tree via the Provider pattern
    return ChangeNotifierProvider(
      // Create a new GameState instance that will be shared across the app
      // This instance will persist for the lifetime of the application
      create: (context) => GameState(),
      
      // MaterialApp provides the base structure for a Material Design app
      child: MaterialApp(
        // App title shown in the app switcher and browser tab
        title: 'Hangman Game',
        
        // App-wide theme configuration for consistent styling
        theme: ThemeData(
          // Primary color scheme based on blue color palette
          primarySwatch: Colors.blue,
          
          // Default font family for all text in the app
          fontFamily: 'Arial',
          
          // Adaptive visual density for different platforms and accessibility
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        
        // The initial screen that users see when the app launches
        home: const HangmanGameScreen(),
        
        // Remove the debug banner in the top-right corner for cleaner UI
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}