import 'package:flutter/material.dart';
import 'joke_api.dart';
import 'dart:async';

//list for the dropdown menu
List<String> list = <String>['One Part', 'Two Part'];
List<String> list2 = <String>['Programming', 'Miscellaneous', 'Dark', 'Pun', 'Spooky', 'Christmas'];
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
  String cat = 'null';
  String type = 'null';
  String lang = 'en';
  String flag = 'nsfw,religious,political,racist,sexist';
  late Future<Joke> futureJoke;

  @override
  void initState() {
    super.initState();
    futureJoke = fetchJoke(type, cat, lang, flag);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top:20, left: 20, right: 20),
        children: [
          JokeBuilder(
            futureJoke: futureJoke,
          ),
          DropdownButtonFormField<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Joke Type',
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

          DropdownButtonFormField(
            value: cat,
            icon: const Icon(Icons.arrow_downward),
            decoration: const InputDecoration(
              labelText: 'Category',
            ),
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            onChanged: (String? newValue) {
              setState(() {
                cat = newValue!;
              });
            },
            items: list2.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList()
            ),

          //get new joke button that now checks
          //the value of the dropdown menu and displays the correct joke type
          //alhamdulillah
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (dropdownValue == 'One Part') {
                      type = 'single';
                    } else {
                      type = 'twopart';
                    }
                    futureJoke = fetchJoke(type, cat, lang, flag);
                  });
                },
                child: const Text('Generate Joke'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
