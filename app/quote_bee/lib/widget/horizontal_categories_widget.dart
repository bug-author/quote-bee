import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quote_bee/constants.dart';
import 'package:quote_bee/pages/quote_page.dart';
import 'package:quote_bee/provider/theme_provider.dart';

class HorizontalCategories extends StatelessWidget {
  const HorizontalCategories({
    Key? key,
    required this.height,
    required this.width,
    required this.category,
  }) : super(key: key);

  final double height;
  final double width;
  final int category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                      ? Provider.of<ThemeProvider>(context).themeMode ==
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
    );
  }
}
