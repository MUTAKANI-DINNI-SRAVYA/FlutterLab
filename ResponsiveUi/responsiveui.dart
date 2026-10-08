
import 'package:flutter/material.dart';

void main() {

runApp(const MyApp());

}

class MyApp extends StatelessWidget {

const MyApp({super.key});

@override

Widget build(BuildContext context) {

return MaterialApp(

  debugShowCheckedModeBanner: false,

  home: const HomePage(),

);

}

}

class HomePage extends StatefulWidget {

const HomePage({super.key});

@override

State<HomePage>createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

// Text displayed on screen

String message = "Welcome";

@override

Widget build(BuildContext context) {

return Scaffold(

  // App Bar

  appBar: AppBar(

    title: const Text("Responsive UI"),



    // Three dots on right side

    actions: [

      PopupMenuButton<String>(

        onSelected: (value) {

          // Change the text

setState(() {

            message = value;

          });

        },

        itemBuilder: (context) {

          return const [

PopupMenuItem(

              value: "Welcome Home",

              child: Text("Home"),

            ),

PopupMenuItem(

              value: "welcome to services",

              child: Text("Services"),

            ),

PopupMenuItem(

              value: "Contact Us",

              child: Text("Contacts"),

            ),

PopupMenuItem(

              value: "Give Your Feedback",

              child: Text("Feedback"),

            ),

          ];

        },

      ),

    ],

  ),



  // Body

  body: Container(

    width: double.infinity,

    height: double.infinity,

    decoration: const BoxDecoration(

      image: DecorationImage(

        image: NetworkImage(

          "https://media.istockphoto.com/id/155356833/photo/pink-cherry-blossoms.jpg?s=612x612&w=0&k=20&c=p_Ph_0Uztb6XwW_BUD86gFWbDVUQdGWkbjcNVspW3mY=",

        ),

        fit: BoxFit.cover,

      ),

    ),

    child: Center(

      child: Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(

          color: Colors.black54,

          borderRadius: BorderRadius.circular(10),

        ),

        child: Text(

          message,

          style: const TextStyle(

            fontSize: 30,

            color: Colors.white,

            fontWeight: FontWeight.bold,

          ),

        ),

      ),

    ),

  ),

);

}

}



 
