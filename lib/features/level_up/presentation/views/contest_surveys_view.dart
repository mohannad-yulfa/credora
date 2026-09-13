import 'package:credora/features/level_up/presentation/views/group_of_participants_view.dart';
import 'package:credora/features/level_up/presentation/views/participants_view.dart';
import 'package:flutter/material.dart';

class ContestsSurveys extends StatelessWidget {
  final Widget header;

  ContestsSurveys({super.key, required this.header});

  final List<Participants> participants = [
    Participants(name: "mohannad", numberofpoints: 200, prize: 100),
    Participants(name: "khaled", numberofpoints: 400, prize: 100),
    Participants(name: "saeed", numberofpoints: 200, prize: 100),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 60),
      children: [
        header,
        const SizedBox(height: 22),
        Groupofparticipants(participants: participants),
        const SizedBox(height: 40),
      ],
    );
  }
}
