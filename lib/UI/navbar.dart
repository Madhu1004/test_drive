
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppTheme extends ChangeNotifier {
  Color _appBarColor = Colors.deepPurple;
  final String _themeKey = 'selectedThemeColor';

  AppTheme() {
    _loadThemeColor(); // Ensure that theme color is loaded when AppTheme is initialized
  }

  Color get appBarColor => _appBarColor;

  set appBarColor(Color newColor) {
    _appBarColor = newColor;
    _saveThemeColor(newColor);
    notifyListeners();
  }

  Future<void> _loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
      print('Loading theme color...');
    if (prefs.containsKey(_themeKey)) {
      final colorValue = prefs.getInt(_themeKey);
      if (colorValue != null) {
          print('Theme color loaded: $colorValue');
        _appBarColor = Color(colorValue);
        notifyListeners();
      }
    } else {
        print('Theme color not found in SharedPreferences.');
    }
  }

  Future<void> _saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    print('Saving theme color: ${color.value}');
    prefs.setInt(_themeKey, color.value);
  }
}


class NavBar extends StatefulWidget {
  const NavBar({super.key});

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
      MaterialPageRoute(builder: (context) => const SettingsThemes()),
    );
  }



  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer<AppTheme>(builder: (context, appTheme,_) =>
         UserAccountsDrawerHeader(
            accountName: const Text('My profile'),
            accountEmail: const Text('myprofile@gmail.com'),
            currentAccountPicture: const ClipOval(
              child: Image(
                image: NetworkImage(
                  'https://static.vecteezy.com/system/resources/previews/021/688/192/original/close-up-portrait-of-muslim-male-character-wearing-keffiyeh-kufiya-round-circle-avatar-icon-for-social-media-user-profile-website-app-line-cartoon-style-illustration-vector.jpg',
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: appTheme.appBarColor,),
          ),
          ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Profile'),
            onTap: _navigateToProfile,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: _navigateToHome,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: _navigateToSettings,
          ),
          const Divider(),
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
        backgroundColor: Provider.of<AppTheme>(context).appBarColor,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop(); },
          icon: const Icon(Icons.arrow_back_ios_new), ),
        title: const Text('My profile'),
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
        backgroundColor: Provider.of<AppTheme>(context).appBarColor,
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop(); },
          icon: const Icon(Icons.arrow_back_ios_new), ),
        title: const Text('Home'),

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



//Settings
class SettingsThemes extends StatefulWidget {
  const SettingsThemes({super.key});

  @override
  State<SettingsThemes> createState() => SettingsThemesState();
}

class SettingsThemesState extends State<SettingsThemes> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Provider.of<AppTheme>(context).appBarColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
      title: const Text('Change Themes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.grey[200],
              ),
              padding: const EdgeInsets.all(16.0),
            child: ListView(
                children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  ),
                  ),
                  onPressed: () {
                  setState(() {
                    Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.red;
                  });
                  },
                  child: const Text(
                    'Red',
                    style: TextStyle(color: Colors.white),
                    ),
                    ),
              const SizedBox(height: 10),
                 ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      ),
                      ),
                      onPressed: () {
                      setState(() {
                        Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.blue;
                      });
                      },
                      child: const Text(
                      'Blue',
                      style: TextStyle(color: Colors.white),
                      ),
                      ),
            const SizedBox(height: 10),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      ),
                      ),
                      onPressed: () {
                      setState(() {
                        Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.orange;
                      });
                      },
                      child: const Text(
                      'Orange',
                      style: TextStyle(color: Colors.white),
                      ),
                      ),
            const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    ),
                    ),
                    onPressed: () {
                    setState(() {
                      Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.green;
                    });
                    },
                    child: const Text(
                    'Green',
                    style: TextStyle(color: Colors.white),
                    ),
                    ),
            const SizedBox(height: 10),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    ),
                    ),
                    onPressed: () {
                    setState(() {
                      Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.pink;
                    });
                    },
                    child: const Text(
                    'Pink',
                    style: TextStyle(color: Colors.white),
                    ),
                    ),
            const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.purpleAccent;
                    });
                  },
                  child: const Text(
                    'Purple',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
             const SizedBox(height: 10),
                 ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.cyan;
                      });
                    },
                    child: const Text(
                      'Cyan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            const SizedBox(height: 10),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.indigoAccent;
                      });
                    },
                    child: const Text(
                      'Indigo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.yellow;
                      });
                    },
                    child: const Text(
                      'Yellow',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        Provider.of<AppTheme>(context, listen: false).appBarColor = Colors.brown;
                      });
                    },
                    child: const Text(
                      'Brown',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
        ],
    ),
    ),
    ),
    );

  }
}

