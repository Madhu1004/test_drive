import 'package:flutter/material.dart';

void main()=> runApp(const MaterialApp(
  home: Home())
);


class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Testing the bar'),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),

        body: const Center(
          child: Text('Hello',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.grey,
              //fontFamily: 'Schuyler',
            ),
          ),
        ),
        // floatingActionButton:FloatingActionButton(
        //   onPressed: () { },
        //   backgroundColor: Colors.greenAccent,
        //   child: const Text('click'),
        //
        // ),
      );

  }
}

