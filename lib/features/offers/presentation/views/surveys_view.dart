// تحديث وتعديل صفحتي Surveys و Playgames لتتوافق بالكامل مع الهيكل التصميمي المحدث وتوحيد المقاسات.
import 'package:credora/core/presentation/widgets/base_screen.dart';
import 'package:credora/core/presentation/widgets/bottom_bar.dart';
import 'package:credora/features/offers/domain/entities/offer_entities.dart';
import 'package:credora/features/offers/presentation/views/offers_view.dart';
import 'package:credora/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class Surveys extends StatefulWidget {
  const Surveys({super.key});

  @override
  State<Surveys> createState() => _SurveysState();
}

class _SurveysState extends State<Surveys> {
  int pagenumber = 1;

  final List<dynamic> myoffer = [
    SpecialOfferData(
      imageUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=500&auto=format&fit=crop',
      offername: 'special',
      typeoffer: 'typeoffer',
      AndroidDevice: true,
      ComputerDevice: false,
    ),
    OfferData(
      AndroidDevice: true,
      ComputerDevice: true,
      deviceType: "Android",
      imageUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=500&auto=format&fit=crop',
      offername: "Noname",
      typeoffer: "notype",
      numberofpoints: 300,
    ),
    OfferData(
      AndroidDevice: true,
      ComputerDevice: true,
      deviceType: "Android",
      imageUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=500&auto=format&fit=crop',
      offername: "Noname",
      typeoffer: "notype",
      numberofpoints: 300,
    ),
    OfferData(
      AndroidDevice: true,
      ComputerDevice: true,
      deviceType: "Android",
      imageUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=500&auto=format&fit=crop',
      offername: "Noname",
      typeoffer: "notype",
      numberofpoints: 300,
    ),
  ];

  final List<OfferWallData> offerwalls = [
    OfferWallData(
      imageUrl:
          'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=500&auto=format&fit=crop',
    ),
  ];

  final List<ActivityBarData> activites = [
    ActivityBarData(txt1: "Creat Survy", txt2: "choline", number: 50),
    ActivityBarData(txt1: "Created Survy", txt2: "choline", number: 50),
    ActivityBarData(txt1: "Created Survy", txt2: "choline", number: 50),
    ActivityBarData(txt1: "Created Survy", txt2: "choline", number: 50),
  ];

  @override
  void initState() {
    BottomBar.CurrentPage = pagenumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Basescreen(
      screen: OffersScreen(
        offers: myoffer,
        offerwalls: offerwalls,
        activityBar: activites,
        Type_Offers: 'Participate in Surveys ',
        numCompletedTasks: 1,
      ),
    );
  }
}
