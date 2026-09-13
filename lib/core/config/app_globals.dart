import 'package:credora/features/redeem/presentation/views/redeem_view.dart';
import 'package:credora/features/offers/presentation/views/earn_view.dart';
import 'package:credora/features/offers/presentation/views/surveys_view.dart';
import 'package:credora/features/offers/presentation/views/play_games_view.dart';
import 'package:flutter/material.dart';

class GlobalsVar {
  static List<Widget> pages = [
    Earn(),
    Surveys(),
    Playgames(),
    SizedBox(),
    Redeem(),
  ];
  static List<String> icons = [
    "lib/images/save-money.png",
    "lib/images/shopping-list.png",
    "lib/images/game-pad.png",
    "lib/images/level.png",
    "lib/images/high-price.png",
  ];

  static List<String> labels = [
    "Earn",
    "Surveys",
    "Play Games",
    "LevelUP+",
    "Redeem",
  ];
}
