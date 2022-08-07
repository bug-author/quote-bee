import 'package:flutter/material.dart';
import 'package:quote_bee/constants.dart';
import 'package:quote_bee/pages/quote_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> navbarItems = [
    "All",
    "Most Liked",
    "Most Retweeted",
    "Favourites"
  ];

  int bottomBarIdx = 0;

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/51686868/gradient-text-in-flutter
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Color(0xFFEA8CCD), Color(0xFF6573A9)],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Quote Bee',
            style: TextStyle(
                fontSize: 35,
                fontFamily: 'LibreFranklin',
                fontWeight: FontWeight.bold,
                foreground: Paint()..shader = linearGradient),
          ),
          backgroundColor: darkBlue,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: const Icon(Icons.nightlight_round, size: 21),
              onPressed: () {},
            ),
          ]),
      body: Container(
        color: darkBlue,
        height: size.height,
        child: Column(
          children: [
            Container(
              height: size.height * 0.15,
              width: size.width,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: navbarItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print(navbarItems[index]);
                    },
                    child: Container(
                        height: size.height * 0.05,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.05,
                            vertical: size.height * 0.05),
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        // decoration: BoxDecoration(color: darkBlue,),
                        child: Text(
                          navbarItems[index],
                          style: const TextStyle(
                            fontSize: 22,
                            color: grey,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.6,
              child: Stack(
                children: [
                  quote_card(size),
                  quote_card(size),
                  quote_card(size),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
