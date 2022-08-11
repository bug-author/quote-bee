import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/quote_model.dart';

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
                  ),
                ),
                Spacer(),
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
                    Text(
                      '🔁 ${rts}',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontFamily: "Lato",
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    )
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
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red[300],
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width * 0.05,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 1,
                            ),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share,
                              color: Colors.blueAccent,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
