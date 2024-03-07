import 'package:flutter/material.dart';
import 'package:test_drive/navbar.dart';

void main()=> runApp(const MaterialApp(
    debugShowCheckedModeBanner:false,
  home: Home())
);


class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        drawer: NavBar(),
        appBar: AppBar(
          title: const Text('App-Bar'),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
        ),

        body: const Center(
          child: Image
            (image: NetworkImage('https://images.unsplash.com/photo-1535887610942-4f0c4f8cb997?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fG1vYmlsZSUyMHBob25lJTIwd2FsbHBhcGVyc3xlbnwwfHwwfHx8MA%3D%3D'),
            ),
          // Text('Hello',
          //   style: TextStyle(
          //     fontSize: 22.0,
          //     fontWeight: FontWeight.bold,
          //     letterSpacing: 2.0,
          //     color: Colors.grey,
          //     //fontFamily: 'Schuyler',
          //   ),
          // ),
        ),
      );

  }
}

