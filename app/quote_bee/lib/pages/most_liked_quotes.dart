import 'package:flutter/material.dart';
import 'package:quote_bee/constants.dart';
import 'package:quote_bee/pages/quote.dart';
import 'package:quote_bee/pages/show_all_quotes.dart';
import 'package:quote_bee/provider/quote_provider.dart';
import 'package:provider/provider.dart';

import 'most_retweeted_quotes.dart';

class ShowMostLikedQuotes extends StatelessWidget {
  const ShowMostLikedQuotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final Shader linearGradient = const LinearGradient(
      colors: <Color>[Color(0xFFEA8CCD), Color(0xFF6573A9)],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    List<String> navbarItems = [
      "All",
      "Most Liked",
      "Most Retweeted",
      "Favourites"
    ];

    return Scaffold(
      backgroundColor: darkBlue,
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
      body: FutureBuilder(
        future:
            Provider.of<QuoteProvider>(context, listen: false).selectData(1),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return Consumer<QuoteProvider>(
                builder: (context, quoteProvider, child) {
              return quoteProvider.quoteItems.isNotEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: height * 0.15,
                          width: width,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: navbarItems.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ShowAllQuotes()),
                                        (Route<dynamic> route) => false);
                                  } else if (index == 1) {
                                  } else {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ShowMostRetweetedQuotes()),
                                        (Route<dynamic> route) => false);
                                  }
                                },
                                child: Container(
                                    height: height * 0.05,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05,
                                      vertical: height * 0.05,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: width * 0.03,
                                    ),
                                    child: Text(
                                      navbarItems[index],
                                      style: TextStyle(
                                        fontSize: 22,
                                        color:
                                            index == 1 ? Colors.white70 : grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              height: height * 0.75,
                              width: width * 0.9,
                              child: Quotes(
                                height: height,
                                width: width,
                                quotes: quoteProvider.quoteItems,
                              )),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                      "No Quote in database",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ));
            });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
