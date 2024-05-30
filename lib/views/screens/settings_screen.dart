import 'package:flutter/material.dart';
import 'package:lesson43/utils/app_constants.dart';
import 'package:lesson43/views/widgets/custom_drawer.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> setMaterialApp;
  final ValueChanged<String> changedlenguage;
  const SettingsScreen({
    super.key,
    required this.changedlenguage,
    required this.setMaterialApp,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController imagecontroller = TextEditingController();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();

  String? lenguage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [const Text("Sozlamalar"), Text(AppConstants.lenguage)],
        ),
      ),
      drawer: CustomDrawer(
        setMaterialApp: widget.setMaterialApp,
        onThemeChanged: widget.onThemeChanged,
        changelenguage: widget.changedlenguage,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppConstants.imagepath,
            ),
          ),
        ),
        child: ListView(
          children: [
            SwitchListTile(
              value: AppConstants.themeMode == ThemeMode.dark,
              onChanged: widget.onThemeChanged,
              title: const Text("Tungi holat"),
            ),
            TextField(
              controller: imagecontroller,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "imagepath"),
            ),
            ElevatedButton(
                onPressed: () {
                  if (imagecontroller.text.isNotEmpty || imagecontroller.text != null) {
                    String s = "assets/images/${imagecontroller.text}.png";
                    widget.setMaterialApp(s);
                  }
                  imagecontroller.clear();
                },
                child: const Text("Submit")),
            DropdownButton(
              value: lenguage,
              items: const [
                DropdownMenuItem(
                  value: "uz",
                  child: Text("uz"),
                ),
                DropdownMenuItem(
                  value: "ru",
                  child: Text("ru"),
                ),
                DropdownMenuItem(
                  value: "eng",
                  child: Text("eng"),
                ),
              ],
              onChanged: (value) {
                value ??= "uz";
                lenguage = value;
                widget.changedlenguage(value);
                setState(() {});
              },
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: oldpassword,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "oldpasword if is exsis"),
            ),
            const SizedBox(
              height: 25,
            ),
            TextField(
              controller: newpassword,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "new password"),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  // ignore: unrelated_type_equality_checks
                  if (oldpassword.text == AppConstants.password || AppConstants.password == null) {
                    AppConstants.password = newpassword.text.trim();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Yangi parol qo'yildi"),
                      ),
                    );
                    oldpassword.clear();
                    newpassword.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("eski parol mos kelmadim nimadur xato"),
                      ),
                    );
                  }
                },
                child: const Text("sumbit new passwor"))
          ],
        ),
      ),
    );
  }
}
