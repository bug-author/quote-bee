import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quote_bee/constants.dart';
import 'package:quote_bee/provider/quote_provider.dart';
import '../model/quote_model.dart';
import 'package:share_plus/share_plus.dart';

import '../provider/theme_provider.dart';

class Quotes extends StatelessWidget {
  const Quotes(
      {Key? key,
      required this.width,
      required this.height,
      required this.quotes})
      : super(key: key);

  final double width;
  final double height;
  final List<QuoteModel> quotes;

  @override
  Widget build(BuildContext context) {
    final quoteProvider = Provider.of<QuoteProvider>(context, listen: false);

    return PageView.builder(
      itemCount: quotes.length,
      itemBuilder: (context, int index) {
        var likes = NumberFormat.compactCurrency(
          decimalDigits: 2,
          symbol: '',
        ).format(quotes[index].likeCount);

        var rts = NumberFormat.compactCurrency(
          decimalDigits: 2,
          symbol: '',
        ).format(quotes[index].retweetCount);

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                quotes[index].tweet,
                style: TextStyle(
                  fontSize: width * 0.05,
                  fontFamily: "Lato",
                  fontWeight: FontWeight.w500,
                  color: Provider.of<ThemeProvider>(context).themeMode ==
                          ThemeMode.dark
                      ? Colors.white
                      : darkerBlue,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    DateFormat.yMMMd()
                        .format(DateTime.parse(quotes[index].date)),
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Lato",
                    ),
                  ),
                  Text(
                    '❤️ $likes',
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.bold,
                      color: Colors.red[400],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.repeat_rounded,
                        color: Colors.blueAccent,
                      ),
                      Text(
                        rts,
                        style: TextStyle(
                          fontSize: width * 0.04,
                          fontFamily: "Lato",
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // add to favourites in db
                          quoteProvider.insertFav(
                              quotes[index].url, quotes[index].favourite);

                          String msg = "";
                          if (quotes[index].favourite == 0) {
                            msg = "Adding to Favourites";
                          } else {
                            msg = "Removed from Favourites";
                          }
                          Fluttertoast.showToast(
                            msg: msg,
                            toastLength: Toast.LENGTH_SHORT,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        },
                        icon: const Icon(
                          Icons.favorite_outline_rounded,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.05,
                      ),
                      IconButton(
                        onPressed: () async {
                          final text = quotes[index].tweet;
                          final url = quotes[index].url;
                          await Share.share('$text\n\n$url');
                        },
                        icon: const Icon(
                          Icons.ios_share_outlined,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
