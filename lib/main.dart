import 'package:flutter/material.dart';
import 'joke_api.dart';
import 'dart:async';

//list for the length dropdown menu and the category dropdown menu
List<String> list = <String>['One Part', 'Two Part'];
List<String> list2 = <String>['Programming', 'Miscellaneous', 'Dark', 'Pun', 'Spooky', 'Christmas'];
List<String> list3 = <String>['en', 'es', 'fr', 'pt', 'de', 'it', 'ru', 'sv', 'pl', 'tr', 'ja', 'zh', 'nl', 'pt', 'id', 'ar', 'hi', 'th', 'cs', 'da', 'fa', 'fi', 'he', 'hu', 'no', 'ro', 'sk', 'sr', 'sv', 'ta', 'vi'];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
//also wanted to add a color box behind the text but didnt have time.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//used to set values for the dropdown menu and makes
//the get new joke button react to the value of the dropdown menu
//curently not working for one part jokes
class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = list.first;
  String cat = 'Programming';
  String type = 'twopart';
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
        padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
        children: [
          JokeBuilder(
            futureJoke: futureJoke,
          ),
          //dropdown form field makes the dropdown menu look better and have the icons to the right instead of the left. (Also it destroyd my life and mental health :-)
          DropdownButtonFormField<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward, color: Colors.blue),
            elevation: 16,
            style: const TextStyle(color: Colors.white),
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
          //same thing but for the category dropdown menu
          DropdownButtonFormField(
            value: cat,
            icon: const Icon(Icons.arrow_downward, color: Colors.blue),
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

            DropdownButtonFormField(
            value: lang,
            icon: const Icon(Icons.arrow_downward, color: Colors.blue),
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            onChanged: (String? newValue) {
              setState(() {
                lang = newValue!;
              });
            },
            items: list3.map<DropdownMenuItem<String>>((String value) {
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