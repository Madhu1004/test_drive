import 'package:flutter/material.dart';
import 'package:test_drive/navbar.dart';

void main()=> runApp(const MaterialApp(
    debugShowCheckedModeBanner:false,
  home: Home())
);


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('App-Bar'),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),

      body: Center(
        child: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.lightGreenAccent, Colors.lightBlueAccent],
      ),
      ),
      ),
      ),
    );
  }
}




