import 'package:flutter/material.dart';
import 'package:lesson43/utils/app_constants.dart';
import 'package:lesson43/views/widgets/custom_drawer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> setMAterialApp;
  final ValueChanged<String> changelenguage;

  const HomeScreen({
    super.key,
    required this.changelenguage,
    required this.setMAterialApp,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Bosh Sahifa"), Text(AppConstants.lenguage)],
        ),
      ),
      drawer: CustomDrawer(
        changelenguage: widget.changelenguage,
        setMaterialApp: widget.setMAterialApp,
        onThemeChanged: widget.onThemeChanged,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConstants.imagepath),
          ),
        ),
      ),
    );
  }
}
