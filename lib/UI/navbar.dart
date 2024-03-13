import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:convert';


class AppTheme extends ChangeNotifier {
  Color _appBarColor = Colors.deepPurple;
  final String _fileName = 'theme_data.json';

  AppTheme() {
    _loadThemeColor();
  }

  Color get appBarColor => _appBarColor;

  set appBarColor(Color newColor) {
    _appBarColor = newColor;
    _saveThemeColor(newColor);
    notifyListeners();
  }

  Future<void> _loadThemeColor() async {
    try {
      if (kIsWeb) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int? colorValue = prefs.getInt('appBarColor');
        if (colorValue != null) {
          _appBarColor = Color(colorValue);
          notifyListeners();
        }
      } else {
        File file = await _getLocalFile();
        if (await file.exists()) {
          String content = await file.readAsString();
          Map<String, dynamic> data = jsonDecode(content);
          if (data.containsKey('appBarColor')) {
            _appBarColor = Color(data['appBarColor']);
            notifyListeners();
          }
        }
      }
    } catch (e) {
      print('Error loading theme color: $e');
    }
  }

  Future<void> _saveThemeColor(Color color) async {
    try {
      if (kIsWeb) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('appBarColor', color.value);
      } else {
        File file = await _getLocalFile();
        Map<String, dynamic> data = {'appBarColor': color.value};
        String jsonString = jsonEncode(data);
        await file.writeAsString(jsonString);
      }
    } catch (e) {
      print('Error saving theme color: $e');
    }
  }

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
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
      MaterialPageRoute(builder: (context) => const HomeDrawer()),
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


class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});


  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final List<String> imageUrls = [
    'https://media.istockphoto.com/id/1494104649/photo/ai-chatbot-artificial-intelligence-digital-concept.jpg?s=2048x2048&w=is&k=20&c=AwtJ4gMG5S2ryVd6pYeiWm2lD10-Lr593yhZDtrK4fs=',
    'https://live.staticflickr.com/2864/33474116474_3feb580e0c_c.jpg',
    'https://media.istockphoto.com/id/1467350162/photo/business-performance-checklist-concept-businessman-using-laptop-doing-online-checklist-survey.jpg?s=2048x2048&w=is&k=20&c=calAin-_yCPVSUGM9z22uBIrVjYMjEkPbhgZ56opXqY=',
  ];

  late PageController _pageController;
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < imageUrls.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Provider.of<AppTheme>(context).appBarColor,
        title: const Text('Home Page'),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0 && _currentIndex > 0) {
            setState(() {
              _currentIndex--;
              _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            });
          } else if (details.primaryVelocity! < 0 && _currentIndex < imageUrls.length - 1) {
            setState(() {
              _currentIndex++;
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            });
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: imageUrls.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: imageUrls[index],
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }
}

//Settings

class SettingsThemes extends StatefulWidget {
  const SettingsThemes({super.key});

  @override
  State<SettingsThemes> createState() => SettingsThemesState();
}

class SettingsThemesState extends State<SettingsThemes> {
  final Map<Color, String> _colorNames = {
    Colors.red: 'Red',
    Colors.blue: 'Blue',
    Colors.orange: 'Orange',
    Colors.green: 'Green',
    Colors.pink: 'Pink',
    Colors.purpleAccent: 'Purple',
    Colors.cyan: 'Cyan',
    Colors.indigoAccent: 'Indigo',
    Colors.yellow: 'Yellow',
    Colors.brown: 'Brown',
    Colors.grey :'grey',
  };



  Widget _buildColorButton(Color color) {
    String name = _colorNames[color] ?? "Unknown"; // Get the color name from the map
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: () {
          setState(() {
            Provider.of<AppTheme>(context, listen: false).appBarColor = color;
          });
        },
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView(
                children: _colorNames.keys
                    .map((color) => _buildColorButton(color))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}