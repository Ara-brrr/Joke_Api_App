import 'package:flutter/material.dart';


//might just rewrite this page

//need to amke the two part joke show up on the screen
//and then to have a button to fetch a new two part joke
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
