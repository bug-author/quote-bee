import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import '../constants.dart';

Widget quote_card(Size size) {
  return Swipable(
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.06, vertical: size.width * 0.03),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.01, horizontal: size.width * 0.05),
        height: size.height * 0.45,
        // color: Colors.white,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              child: Text(
                "A large string ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkerBlue,
                  fontFamily: "SourceSansPro",
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    elevation: 1,
                    primary: Colors.redAccent,
                    // onPrimary: Colors.redAccent,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: Text("235"),
                  icon: FaIcon(
                    FontAwesomeIcons.heart,
                  ),
                ),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  label: Text("25"),
                  icon: FaIcon(
                    FontAwesomeIcons.retweet,
                  ),
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
