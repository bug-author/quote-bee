import 'package:flutter/material.dart';
import 'package:quote_bee/constants.dart';
import 'package:quote_bee/pages/quote.dart';
import 'package:quote_bee/provider/quote_provider.dart';
import 'package:provider/provider.dart';
import 'package:quote_bee/widget/change_theme_widget.dart';

import '../provider/theme_provider.dart';

class QuotePage extends StatelessWidget {
  final int category;
  const QuotePage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Quote Bee',
          style: TextStyle(
            fontSize: 35,
          ),
        ),
        actions: const [
          ChangeThemeButtonWidget(),
          SizedBox(
            width: 20,
          ),
        ],
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
                                      color: index == category
                                          ? Provider.of<ThemeProvider>(context)
                                                      .themeMode ==
                                                  ThemeMode.dark
                                              ? Colors.white
                                              : Colors.black87
                                          : grey,
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
                              width: width * 0.95,
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
