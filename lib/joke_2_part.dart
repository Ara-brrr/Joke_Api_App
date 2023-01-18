import 'package:flutter/material.dart';

class Joke2 extends StatelessWidget {
  const Joke2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Gå tilbake"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
