import 'package:flutter/material.dart';
import 'joke_api.dart';
import 'dart:async';

//list for the dropdown menu
List<String> list = <String>['One Part', 'Two Part'];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Funny app',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'The funny app'),
    );
  }
}

//Main page containing the dropdown menu and the JokeBuilder widget.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = list.first;
  String cat = 'Programming';
  String type = 'twopart';
  late Future<Joke> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = fetchJoke(type, cat);
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
          JokeBuilder(
            futureJoke: futureJoke,
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            //Dropdown menu  and the get new joke button
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextButton(
              child: const Text('Get New Joke'),
              onPressed: () {
                setState(() {
                  futureJoke = fetchJoke(type, cat);
              }
             );
            }
          ),
        ],
      ),
    );
  }
}
