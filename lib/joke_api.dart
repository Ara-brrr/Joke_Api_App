import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//fetching the one part joke from the api and returning it as a Joke object
Future<Joke> fetchJoke(type, cat, String lang, String flag) async {
  String baseUrl = 'https://v2.jokeapi.dev/joke/';
  if (cat != null) {
    baseUrl += cat;
  }
  if (type != null) {
    baseUrl += "?type=$type";
  }
  final response = await http.get(Uri.parse(baseUrl));
    
  // If the server did return a 200 OK response,
  // then parse the JSON.
  if (response.statusCode == 200) {
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Joke');
  }
}
//fetching the two part joke from the api and returning it as a Joke object
Future<Joke1> fetchJoke1(type, cat) async {
  String baseUrl = 'https://v2.jokeapi.dev/joke/';
  if (cat != null) {
    baseUrl += cat;
  }
  if (type != null) {
    baseUrl += "?type=$type";
  }

  final response = await http.get(Uri.parse(baseUrl));
    
    //look at line 17 and 18
  if (response.statusCode == 200) {
    return Joke1.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Joke');
  }
}

  //this is the two part joke
  class Joke {
  final String setup;
  final String delivery;

  const Joke({
    required this.setup,
    required this.delivery,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'],
      delivery: json['delivery'],
    );
  }
}


//this is the one part joke
//not working cuz i cant do shit with out major errors
class Joke1 {
  final String joke;
  const Joke1({required this.joke});
  factory Joke1.fromJson(Map<String, dynamic> json) {
    return Joke1(
      joke: json['joke'],
    );
  }
}

//this thing builds the joke
class JokeBuilder extends StatefulWidget {
  final Future<Joke> futureJoke;
  const JokeBuilder({required this.futureJoke, super.key});

  @override
  State<JokeBuilder> createState() => _JokeBuilderState();
}

class _JokeBuilderState extends State<JokeBuilder> {
  String cat = 'Programming';
  String type = 'twopart';
  late Future<Joke> futureJoke;

//this is the function that is called when the "Get New Joke" button is pressed.
//it uses the values of the dropdown menu to set the values for the api call when the button is pressed
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Joke>(
      future: widget.futureJoke,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data!.setup} \n ${snapshot.data!.delivery}');
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        //loading spinner boi
        return const CircularProgressIndicator();
      },
    );
  }
}