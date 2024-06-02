import 'package:flutter/material.dart';
import 'package:lesson43/utils/app_constants.dart';
import 'package:lesson43/views/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final sharedPreference = await SharedPreferences.getInstance();
    setState(() {
      AppConstants.imagepath = sharedPreference.getString("image") ?? "assets/images/loading.gif";
      AppConstants.lenguage = sharedPreference.getString("lenguage") ?? "uz";
      AppConstants.password = sharedPreference.getString("password");
      AppConstants.themeMode = sharedPreference.getBool("theme") == true ? ThemeMode.light : ThemeMode.dark;
      print("get");
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      _savePreferences();
    }
  }

  Future<void> _savePreferences() async {
    final sharedPreference = await SharedPreferences.getInstance();
    bool theme = AppConstants.themeMode == ThemeMode.light;
    await sharedPreference.setBool("theme", theme);
    await sharedPreference.setString("image", AppConstants.imagepath);
    await sharedPreference.setString("lenguage", AppConstants.lenguage);
    await sharedPreference.setString("password", AppConstants.password ?? "");
    print("save");
  }

  void toggleThemeMode(bool value) {
    setState(() {
      AppConstants.themeMode = value ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void setMaterialApp(String image) {
    setState(() {
      AppConstants.imagepath = image;
    });
  }

  void changelenguage(String lenguage) {
    setState(() {
      AppConstants.lenguage = lenguage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.amber,
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: AppConstants.themeMode,
      home: HomeScreen(
        changelenguage: changelenguage,
        setMAterialApp: setMaterialApp,
        onThemeChanged: toggleThemeMode,
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
