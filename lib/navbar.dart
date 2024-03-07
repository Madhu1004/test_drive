import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
      children: const [ UserAccountsDrawerHeader(
          accountName: Text('My profile'),
          accountEmail: Text('myprofile@gmail.com'),
          currentAccountPicture: ClipOval(child: Image(image: NetworkImage('https://static.vecteezy.com/system/resources/previews/021/688/192/original/close-up-portrait-of-muslim-male-character-wearing-keffiyeh-kufiya-round-circle-avatar-icon-for-social-media-user-profile-website-app-line-cartoon-style-illustration-vector.jpg')
          ),
          ),
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
      ),

        ListTile(
          leading: Icon(Icons.person),
          title: Text('My Profile'),
          // onTap: () {
          //   Navigator.push(context,MaterialPageRoute(builder: (context) => const MyProfile()),
          // },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        Divider(),
      ],
    ));
  }
}
