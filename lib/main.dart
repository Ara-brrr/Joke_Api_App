import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'joke_2_part.dart';
import 'joke_api.dart';
import 'dart:async';
import 'dart:convert';

// Makes API call and parses the JSON to a Joke object if the call is successful.

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

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
  String dropdownValue = list.first;
//added by aron
  String cat = 'Programming';
  String type = 'twopart';

  late Future<Joke> futureJoke;

//added by aron


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
        padding: const 
        EdgeInsets.only(left: 20, right: 20),
        children: [
          JokeBuilder(futureJoke: futureJoke,),
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
          
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),),
      
      TextButton(
        child: const Text('Get New Joke'),
        onPressed: () {setState(() {
          futureJoke = fetchJoke(type, cat);
        });    
      }),
          
        ],
      ),
    );
  }
}
