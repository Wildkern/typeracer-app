import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:type_racer/providers/game_state_provider.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: game.gameState['players'].length,
      itemBuilder: (context, index) {
        var playerData = game.gameState['players'][index];
        return ListTile(
          title: Text(
            playerData['nickname'],
          ),
          trailing: Text(
            '${playerData['WPM']} WPM', // Display WPM with label
            style: const TextStyle(
              fontSize: 16, // You can adjust the font size
              fontWeight: FontWeight.bold,
              color: Colors.black, // Customize color as needed
            ),
          ),
        );
      },
    );
  }
}
