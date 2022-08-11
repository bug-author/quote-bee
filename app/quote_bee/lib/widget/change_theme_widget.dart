import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: () {
        bool isDark = themeProvider.themeMode == ThemeMode.dark;
        themeProvider.changeTheme(isDark);
      },
      child: Icon(
        themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
}
