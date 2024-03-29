import 'package:flutter/material.dart';

const darkBlue = Color(0xFF313B4E);
const darkerBlue = Color(0xFF273243);
const grey = Color(0xFF79829C);

final Shader linearGradientDark = const LinearGradient(
  colors: <Color>[
    Color(0xFFEA8CCD),
    Color(0xFF6573A9),
  ],
).createShader(
  const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);

final Shader linearGradientLight = const LinearGradient(
  colors: <Color>[
    Color(0xFF2193B0),
    Color(0xFF6DD5ED),
  ],
).createShader(
  const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);

List<String> navbarItems = [
  "Random",
  "Most Liked",
  "Most Retweeted",
  "Favourites"
];
