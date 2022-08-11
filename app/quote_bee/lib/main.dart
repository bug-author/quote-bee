import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_bee/pages/quote_page.dart';
import 'package:quote_bee/provider/quote_provider.dart';
import 'package:quote_bee/provider/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => QuoteProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
        ],
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Quote Bee',
              themeMode: Provider.of<ThemeProvider>(context).themeMode,
              theme: Themes.lightTheme,
              darkTheme: Themes.darkTheme,
              home: const QuotePage(
                category: 0,
              ),
            ));
  }
}
