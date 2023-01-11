import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

//ADD type, lang TO FETCHJOKE()
Future<Joke> fetchJoke(type, cat) async {
  const baseUrl = 'https://v2.jokeapi.dev/joke/';
  if cat {baseUrl += cat;}
  if type = twopart {baseurl += ?type=twopart} else {baseurl += ?type=single}

  final response = await http.get(Uri.parse(baseUrl));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Joke');
  }
}
// A Joke object that contains a setup and a delivery.
class Joke {
  final String setup;
  final String delivery;

  const Joke({
    required this.setup,
    required this.delivery,
  });

  // A function that converts a response body into a Joke object.
  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'],
      delivery: json['delivery'],
    );
  }
} 

class JokeBuilder extends StatefulWidget {
  final Future<Joke> futureJoke;
  const JokeBuilder({required this.futureJoke, super.key});

  @override
  State<JokeBuilder> createState() => _JokeBuilderState();
}

class _JokeBuilderState extends State<JokeBuilder> {
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

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
);
  }
}
        
   