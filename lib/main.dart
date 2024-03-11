import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/UI/navbar.dart';

void main() => runApp(
      ChangeNotifierProvider(
          create: (_) => AppTheme(),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Home(),
          ),
      ),
    );


class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          backgroundColor: Provider.of<AppTheme>(context).appBarColor,
          title: const Text('App-Bar'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'Main page',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
