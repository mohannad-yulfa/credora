import 'package:credora/features/level_up/presentation/widgets/giveaway.dart';
import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ExpiredGiftsPage extends StatelessWidget {
  ExpiredGiftsPage({super.key});

  List<Giveaway> giveaways = [
    Giveaway(
      typeGiveaway: "simple",
      name: "1 Winner: 50,000 Points Weekly",
      numberOfpoints: 1,
      TimePeriod: "11:52 PM ,ARP 19 .2025",
      ViewButton: "ENTRY FREE 100 points",
    ),
  ];
  List<Giveaway> giveawayspecial = [
    Giveaway(
      typeGiveaway: "special",
      name: "1 Winner: 50,000 Points Weekly",
      numberOfpoints: 1,
      ViewButton: "Free",
      status: "sorry you didn't win",
    ),
  ];
  List<String> label = ["ACTIVE", "RECENTLY ENDED"];
  List<Color> colors = [AppColors.offerBlue, AppColors.black];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 2),
          child: Row(
            children: [
              const Icon(Icons.history, color: AppColors.textMuted),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Past opportunities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.surfaceElevated,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'ENDED',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: List.generate(giveawayspecial.length, (index) {
            return Padding(
              padding: SizeConfig.symmetricPadding(vertical: 10),
              child: giveawayspecial[index],
            );
          }),
        ),
        SizedBox(height: 30),
        Padding(
          padding: SizeConfig.symmetricPadding(horizontal: 12),
          child: Text(
            "Points Entry Giveaway",
            style: TextStyle(
              fontSize: SizeConfig.fontSize(25),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 30),
        Column(
          children: List.generate(giveaways.length, (index) {
            return Padding(
              padding: SizeConfig.symmetricPadding(vertical: 10),
              child: giveaways[index],
            );
          }),
        ),
        SizedBox(height: 20),
        Center(
          child: Padding(
            padding: SizeConfig.symmetricPadding(horizontal: 16),
            child: Text(
              "some informations",
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.fontSize(14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
