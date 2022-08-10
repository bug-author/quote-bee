import 'package:flutter/material.dart';
import 'package:quote_bee/constants.dart';
import 'package:quote_bee/pages/quote.dart';
import 'package:quote_bee/provider/quote_provider.dart';
import 'package:provider/provider.dart';

class QuotePage extends StatelessWidget {
  final int category;
  const QuotePage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: darkBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Quote Bee',
          style: TextStyle(
              fontSize: 35,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              foreground: Paint()..shader = linearGradient),
        ),
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: Provider.of<QuoteProvider>(context, listen: false)
            .selectData(category),
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
                                  if (index != category) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => QuotePage(
                                                  category: index,
                                                )),
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
                                      color: index == 0 ? Colors.white70 : grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
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
                      "No tweets in database",
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
