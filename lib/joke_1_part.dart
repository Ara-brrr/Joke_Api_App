import 'package:flutter/material.dart';
// ignore: unused_import, implementation_imports
import 'package:flutter/src/widgets/container.dart';
// ignore: implementation_imports, unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
import 'package:jokes_api/joke_api.dart';

class Joke1 extends StatefulWidget {
  final String category;
  const Joke1({required this.category, super.key});

  @override
  State<Joke1> createState() => _Joke1State();
}

class _Joke1State extends State<Joke1> {
  late Future<Joke> futureJoke;
  @override
  void initState() {
    fetchJoke1("onepart", widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Joke>(
      future: futureJoke,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data!.setup} \n ${snapshot.data!.delivery}');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    ));
  }
}
