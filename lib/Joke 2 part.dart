import 'package:flutter/material.dart';

class NySide extends StatelessWidget {
  const NySide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(child: const Text("Gå tilbake"),
      onPressed: () {
        Navigator.pop(context);
      },),),
      );
  }
}