import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_bee/pages/show_quotes.dart';
import 'package:quote_bee/provider/quote_provider.dart';
import './pages/home_page.dart';

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
        ],
        builder: (context, child) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Quote Bee',
              theme: ThemeData(
                fontFamily: 'SourceSansPro',
              ),
              home: const ShowQuotes(),
            ));
  }
}
