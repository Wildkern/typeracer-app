import 'package:flutter/material.dart';
import 'package:type_racer/widgets/customButtom.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create a room to play ',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Custombuttom(
                    text: 'Create',
                    onTap: () => Navigator.pushNamed(context, '/create-room'),
                    isHome: true,
                  ),
                  Custombuttom(
                    text: 'Join',
                    onTap: () => Navigator.pushNamed(context, '/join-room'),
                    isHome: true,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
