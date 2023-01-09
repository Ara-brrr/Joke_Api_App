import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Joke 2 part.dart';
import 'dart:async';
import 'dart:convert';

// Makes API call and parses the JSON to a Joke object if the call is successful.
Future<Joke> fetchJoke(type, lang) async {
  final response = await http.get(Uri.parse('https://v2.jokeapi.dev/joke/Programming,Miscellaneous,Dark,Pun?type=twopart'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Joke.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        children: [
        FutureBuilder<Joke>(
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
),

      
      TextButton(
        child: const Text('Get New Joke'),
        onPressed: () {setState(() {
          futureJoke = fetchJoke();
        });    
      }),


          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 20),
              ),
         const Text(
            "Overskrift",
         style: TextStyle(fontSize: 36)
         ),
         Image.asset('assets/neon.jpg'),
  
          Container(
            
            margin: const EdgeInsets.only(top: 30),
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green,),
              child: Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              
            
 
            
              children: [
                const Text("mer tekst her")
                ,Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Container(width: 50, height: 50, color: Colors.white,),
                  Container(width: 50, height: 50, color: Colors.white,),
                  Container(width: 50, height: 50, color: Colors.white,)
                ],)
                ,Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SizedBox(width: 50, child: Text("Hei les mere tekst her")),
                    SizedBox(width: 50, child: Text("Hei les mere tekst her")),
                    SizedBox(width: 50, child: Text("Hei les mere tekst her"))

                  ],

                )
              ],)
            
            
            

          )
],        

      ), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NySide()));
        },
        tooltip: 'new page',
        child: const Icon(Icons.arrow_forward),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
