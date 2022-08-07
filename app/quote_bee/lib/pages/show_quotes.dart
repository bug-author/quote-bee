import 'package:flutter/material.dart';
import 'package:quote_bee/constants.dart';
import 'package:quote_bee/provider/quote_provider.dart';
import 'package:provider/provider.dart';

import '../model/quote_model.dart';

class ShowQuotes extends StatelessWidget {
  const ShowQuotes({Key? key}) : super(key: key);

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
        future: Provider.of<QuoteProvider>(context, listen: false).selectData(),
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
                                  // print(navbarItems[index]);
                                },
                                child: Container(
                                    height: height * 0.05,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.05,
                                        vertical: height * 0.05),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: width * 0.03),
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
                        Expanded(
                          child: SizedBox(
                            height: height * 0.75,
                            width: width * 0.9,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: quoteProvider.quoteItems.length,
                              itemBuilder: (context, index) {
                                final quote = quoteProvider.quoteItems[index];
                                return ListViewCards(
                                  currentQuote: quote,
                                  width: width,
                                  height: height,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text("EMPTY"),
                    );
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

class ListViewCards extends StatelessWidget {
  const ListViewCards(
      {Key? key,
      required this.currentQuote,
      required this.width,
      required this.height})
      : super(key: key);

  final QuoteModel currentQuote;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(width * 0.05)),
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        horizontal: width * 0.03,
        vertical: height * 0.01,
      ),
      elevation: 2,
      child: ListTile(
        style: ListTileStyle.drawer,
        title: Text(currentQuote.tweet),
        subtitle: Text(
          currentQuote.date,
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Text(
          currentQuote.likeCount.toString(),
          style: TextStyle(color: Colors.grey[600]),
        ),
      ),
    );
  }
}
