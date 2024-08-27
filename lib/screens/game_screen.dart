import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:type_racer/providers/client_state_provider.dart';
import 'package:type_racer/providers/game_state_provider.dart';
import 'package:type_racer/utils/socket_methods.dart';
import 'package:type_racer/widgets/game_text_field.dart';
import 'package:type_racer/widgets/sentence_game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  // State variable to hold the game ID
  String? gameId;

  @override
  void initState() {
    super.initState();
    _socketMethods.updateTimer(context);
    _socketMethods.updateGame(context);
    _socketMethods.gameFinishedListener();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    final clientStateProvider = Provider.of<ClientStateProvider>(context);

    // Fetch the game ID from the game state
    gameId = game.gameState['id'];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust to fit content
              children: [
                Chip(
                  label: Text(
                    clientStateProvider.clientState['timer']['msg'].toString(),
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Chip(
                  label: Text(
                    clientStateProvider.clientState['timer']['countDown']
                        .toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SentenceGame(),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                    maxHeight: 200, // Constrain the height of ListView
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: game.gameState['players'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Chip(
                              label: Text(
                                game.gameState['players'][index]['nickname'],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Slider(
                              value: (game.gameState['players'][index]
                                      ['currentWordIndex'] /
                                  game.gameState['words'].length),
                              onChanged: (val) {},
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                game.gameState['isJoin']
                    ? Column(
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 600,
                            ),
                            child: TextField(
                              readOnly: true,
                              onTap: () {
                                Clipboard.setData(ClipboardData(
                                  text: gameId ??
                                      '', // Use gameId or empty string
                                )).then((_) {
                                  // Show a SnackBar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Game Code Copied to clipboard!'),
                                    ),
                                  );
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                fillColor: const Color(
                                  0xffF5F5FA,
                                ),
                                hintText: 'Click to copy game code',
                                hintStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          // Display the game ID below the text field
                          if (gameId != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Game ID: $gameId',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        child: const GameTextField(),
      ),
    );
  }
}
