// [Developer: مهند هشام اللحجة / 2026]
// Refactored Earn screen featuring optimized state handling, structured mock lists, and clean integration with the modern Basescreen wrapper.

import 'package:credora/core/presentation/widgets/base_screen.dart';
import 'package:credora/core/presentation/widgets/bottom_bar.dart';
import 'package:credora/features/offers/domain/entities/offer_entities.dart';
import 'package:credora/features/offers/presentation/views/offers_view.dart';
import 'package:credora/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class Earn extends StatefulWidget {
  const Earn({super.key});

  @override
  State<Earn> createState() => _EarnState();
}

class _EarnState extends State<Earn> {
  final int pagenumber = 0;

  final List<dynamic> myoffer = [
    SpecialOfferData(
      imageUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=500&auto=format&fit=crop',
      offername: 'Elite Rewards Boost',
      typeoffer: 'Featured',
      AndroidDevice: true,
      ComputerDevice: false,
    ),
    OfferData(
      AndroidDevice: true,
      ComputerDevice: true,
      deviceType: "Android & Web",
      imageUrl:
          'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?q=80&w=500&auto=format&fit=crop',
      offername: "Cyber Security Survey",
      typeoffer: "Survey",
      numberofpoints: 300,
    ),
    SpecialOfferData(
      imageUrl:
          'https://images.unsplash.com/photo-1639762681485-074b7f938ba0?q=80&w=500&auto=format&fit=crop',
      offername: 'Crypto Vault Task',
      typeoffer: 'Exclusive',
      AndroidDevice: true,
      ComputerDevice: false,
    ),
    OfferData(
      AndroidDevice: true,
      ComputerDevice: true,
      deviceType: "Android",
      imageUrl:
          'https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=500&auto=format&fit=crop',
      offername: "Gaming Quest Level 5",
      typeoffer: "Game",
      numberofpoints: 450,
    ),
    OfferData(
      AndroidDevice: true,
      ComputerDevice: true,
      deviceType: "Multi-Platform",
      imageUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=500&auto=format&fit=crop',
      offername: "App Feedback Pro",
      typeoffer: "Review",
      numberofpoints: 150,
    ),
  ];

  final List<OfferWallData> offerwalls = [
    OfferWallData(
      imageUrl:
          'https://images.unsplash.com/photo-1563986768609-322da13575f3?q=80&w=500&auto=format&fit=crop',
    ),
    OfferWallData(
      imageUrl:
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?q=80&w=500&auto=format&fit=crop',
    ),
  ];

  final List<ActivityBarData> activites = [
    ActivityBarData(txt1: "Completed Survey", txt2: "Verified", number: 50),
    ActivityBarData(txt1: "Daily Check-in", txt2: "Bonus", number: 10),
    ActivityBarData(txt1: "App Trial Quest", txt2: "In Progress", number: 120),
    ActivityBarData(txt1: "Referral Reward", txt2: "Credited", number: 200),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BottomBar.CurrentPage = pagenumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Basescreen(
      screen: OffersScreen(
        offers: myoffer,
        offerwalls: offerwalls,
        activityBar: activites,
        Type_Offers: 'Featured Offers',
        numCompletedTasks: 3,
      ),
    );
  }
}
