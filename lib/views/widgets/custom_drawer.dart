import 'package:flutter/material.dart';
import 'package:lesson43/utils/app_constants.dart';
import 'package:lesson43/views/screens/home_screen.dart';
import 'package:lesson43/views/screens/password_screen.dart';
import 'package:lesson43/views/screens/settings_screen.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  ValueChanged<String> setMaterialApp;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> changelenguage;

  CustomDrawer({super.key, required this.changelenguage, required this.setMaterialApp, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Mehmonxonalar"),
                Text("MENYU"),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return HomeScreen(
                      changelenguage: changelenguage,
                      setMAterialApp: setMaterialApp,
                      onThemeChanged: onThemeChanged,
                    );
                  },
                ),
              );
            },
            title: const Text("Bosh sahifa"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return SettingsScreen(
                      changedlenguage: changelenguage,
                      setMaterialApp: setMaterialApp,
                      onThemeChanged: onThemeChanged,
                    );
                  },
                ),
              );
            },
            title: const Text("Sozlamalar"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          IconButton(
              onPressed: () {
                if (AppConstants.password != null && AppConstants.password!.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Parol mavjud emas "),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.lock)),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppConstants.imagepath),
              ),
            ),
          )
        ],
      ),
    );
  }
}
