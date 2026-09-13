import 'package:credora/features/level_up/presentation/views/group_of_participants_view.dart';
import 'package:credora/features/level_up/presentation/views/participants_view.dart';
import 'package:flutter/material.dart';

class Monthly extends StatelessWidget {
  final Widget header;

  Monthly({super.key, required this.header});

  final List<Participants> participants = [
    Participants(name: "gogo", numberofpoints: 200, prize: 100),
    Participants(name: "flo", numberofpoints: 400, prize: 100),
    Participants(name: "wewew", numberofpoints: 200, prize: 100),
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
