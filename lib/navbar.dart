import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  
  
  void _navigateToProfile() {
    // Define what you want to do when 'My Profile' is tapped
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyProfileRoute()),
    );
  }

  void _navigateToHome() {
    // Define what you want to do when 'Home' is tapped
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
    );
  }

  void _navigateToSettings() {
    // Define what you want to do when 'Settings' is tapped
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('My profile'),
            accountEmail: Text('myprofile@gmail.com'),
            currentAccountPicture: ClipOval(
              child: Image(
                image: NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/021/688/192/original/close-up-portrait-of-muslim-male-character-wearing-keffiyeh-kufiya-round-circle-avatar-icon-for-social-media-user-profile-website-app-line-cartoon-style-illustration-vector.jpg',
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Profile'),
            onTap: _navigateToProfile,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: _navigateToHome,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: _navigateToSettings,
          ),
          Divider(),
        ],
      ),
    );
  }
}

class MyProfileRoute extends StatefulWidget {
  const MyProfileRoute({super.key});

  @override
  State<MyProfileRoute> createState() => _MyProfileRouteState();
}

class _MyProfileRouteState extends State<MyProfileRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My profile'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('<----Back'),
        ),
      ),
    );
  }
}


class Home extends StatefulWidget {
  const Home({super.key});


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('<----Back'),
        ),
      ),
    );
  }
}


class SettingsRoute extends StatefulWidget {
  const SettingsRoute({super.key});

  @override
  State<SettingsRoute> createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back'),
        ),
      ),
    );
  }
}



