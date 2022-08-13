import 'package:flutter/material.dart';
import 'package:quote_bee/pages/quote.dart';
import 'package:quote_bee/provider/quote_provider.dart';
import 'package:provider/provider.dart';
import 'package:quote_bee/widget/change_theme_widget.dart';
import 'package:quote_bee/widget/horizontal_categories_widget.dart';

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
                        HorizontalCategories(
                            height: height, width: width, category: category),
                        Expanded(
                          child: SizedBox(
                            height: height * 0.75,
                            width: width * 0.95,
                            child: Quotes(
                              height: height,
                              width: width,
                              quotes: quoteProvider.quoteItems,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        HorizontalCategories(
                            height: height, width: width, category: category),
                        const Spacer(),
                        const Text(
                          "No tweets in database",
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                        const Spacer()
                      ],
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
