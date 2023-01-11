import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokes_api/joke_api.dart';
import 'Joke 2 part.dart';
import 'joke 1 part.dart';
import 'dart:async';
import 'dart:convert';

// Makes API call and parses the JSON to a Joke object if the call is successful.




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    late Future<Joke> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = fetchJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      


      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: [
          JokeBuilder(futureJoke: futureJoke,),

      
      TextButton(
        child: const Text('Get New Joke'),
        onPressed: () {setState(() {
          futureJoke = fetchJoke();
        });    
      }),


          
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const Joke2()));
        },
        tooltip: 'new page',
        child: const Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
