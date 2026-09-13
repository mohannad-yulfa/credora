import 'package:credora/features/level_up/presentation/views/participants_view.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Groupofparticipants extends StatefulWidget {
  final List<Participants> participants;

  const Groupofparticipants({super.key, required this.participants});

  @override
  State<Groupofparticipants> createState() => _GroupofparticipantsState();
}

class _GroupofparticipantsState extends State<Groupofparticipants>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _podiumController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _podiumAnimation;

  double _size(double normal, double small) {
    final width = MediaQuery.of(context).size.width;

    if (width < 360) {
      return small;
    }

    return normal;
  }

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _podiumController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _mainController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _mainController, curve: Curves.easeOutCubic),
    );

    _podiumAnimation = CurvedAnimation(
      parent: _podiumController,
      curve: Curves.elasticOut,
    );

    Future.delayed(const Duration(milliseconds: 80), () {
      if (mounted) {
        _mainController.forward();
      }
    });

    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted) {
        _podiumController.forward();
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _podiumController.dispose();
    super.dispose();
  }

  List<Participants> get _sortedParticipants {
    final list = [...widget.participants];

    list.sort((a, b) => b.numberofpoints.compareTo(a.numberofpoints));

    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.participants.isEmpty) {
      return _buildEmptyState();
    }

    final participants = _sortedParticipants;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            _buildPrizePool(),

            SizedBox(height: _size(24, 17)),

            _buildLeaderboardTitle(),

            SizedBox(height: _size(18, 13)),

            _buildPodium(participants),

            SizedBox(height: _size(24, 18)),

            if (participants.length > 3)
              _buildParticipantsList(participants.sublist(3)),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PRIZE POOL
  // ============================================================

  Widget _buildPrizePool() {
    final totalPrize = widget.participants.fold<int>(
      0,
      (sum, participant) => sum + participant.prize,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _size(20, 15),
        vertical: _size(18, 14),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_size(22, 18)),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.transparentBlack08,
            blurRadius: 15,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: _size(58, 48),
            height: _size(58, 48),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_rounded,
              color: AppColors.primary,
              size: _size(30, 25),
            ),
          ),

          SizedBox(width: _size(15, 11)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL PRIZE POOL',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: _size(11, 9),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '$totalPrize',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: _size(25, 21),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Text(
                      'PTS',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: _size(11, 9),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios_rounded,
            size: _size(15, 12),
            color: AppColors.textMuted,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LEADERBOARD TITLE
  // ============================================================

  Widget _buildLeaderboardTitle() {
    return Row(
      children: [
        Container(
          width: _size(4, 3),
          height: _size(25, 21),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),

        SizedBox(width: _size(10, 8)),

        Expanded(
          child: Text(
            'LEADERBOARD',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.text,
              fontSize: _size(18, 15),
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
          ),
        ),

        Icon(
          Icons.workspace_premium_rounded,
          color: AppColors.primary,
          size: _size(22, 19),
        ),
      ],
    );
  }

  // ============================================================
  // PODIUM
  // ============================================================

  Widget _buildPodium(List<Participants> participants) {
    final first = participants.isNotEmpty ? participants[0] : null;

    final second = participants.length > 1 ? participants[1] : null;

    final third = participants.length > 2 ? participants[2] : null;

    return AnimatedBuilder(
      animation: _podiumAnimation,
      builder: (context, child) {
        final value = _podiumAnimation.value.clamp(0.0, 1.0);

        return Transform.scale(
          scale: 0.94 + (value * 0.06),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: SizedBox(
        height: _size(285, 260),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildPodiumPlace(
                participant: second,
                position: 2,
                height: _size(115, 100),
              ),
            ),

            Expanded(
              child: _buildPodiumPlace(
                participant: first,
                position: 1,
                height: _size(145, 125),
                isWinner: true,
              ),
            ),

            Expanded(
              child: _buildPodiumPlace(
                participant: third,
                position: 3,
                height: _size(100, 90),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPodiumPlace({
    required Participants? participant,
    required int position,
    required double height,
    bool isWinner = false,
  }) {
    if (participant == null) {
      return const SizedBox();
    }

    final avatarSize = isWinner ? _size(62, 52) : _size(52, 45);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        // ========================================================
        // CROWN
        // ========================================================
        if (isWinner) ...[
          Icon(
            Icons.workspace_premium_rounded,
            color: AppColors.amber,
            size: _size(28, 24),
          ),

          SizedBox(height: _size(3, 2)),
        ],

        // ========================================================
        // AVATAR
        // ========================================================
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surfaceElevated,
            border: Border.all(
              color: isWinner ? AppColors.amber : AppColors.border,
              width: isWinner ? 2.5 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    isWinner
                        ? AppColors.amber.withOpacity(0.20)
                        : AppColors.transparentBlack08,
                blurRadius: isWinner ? 12 : 7,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              participant.name.isNotEmpty
                  ? participant.name[0].toUpperCase()
                  : '?',
              style: TextStyle(
                color: isWinner ? AppColors.amber : AppColors.primary,
                fontSize: _size(22, 18),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),

        SizedBox(height: _size(5, 4)),

        // ========================================================
        // NAME
        // ========================================================
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            participant.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontSize: _size(12, 10),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),

        const SizedBox(height: 3),

        // ========================================================
        // POINTS
        // ========================================================
        Text(
          '${participant.numberofpoints} pts',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: _size(10, 8),
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 7),

        // ========================================================
        // PODIUM BLOCK
        // ========================================================
        Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color:
                isWinner
                    ? AppColors.primary.withOpacity(0.16)
                    : AppColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(
              color:
                  isWinner
                      ? AppColors.primary.withOpacity(0.45)
                      : AppColors.border,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: _size(34, 29),
                height: _size(34, 29),
                decoration: BoxDecoration(
                  color:
                      isWinner
                          ? AppColors.amber.withOpacity(0.15)
                          : AppColors.surfaceElevated,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$position',
                    style: TextStyle(
                      color: isWinner ? AppColors.amber : AppColors.text,
                      fontSize: _size(17, 14),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              SizedBox(height: _size(8, 6)),

              Text(
                '${participant.prize}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: _size(15, 12),
                  fontWeight: FontWeight.w900,
                ),
              ),

              Text(
                'PRIZE',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: _size(8, 7),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // OTHER PARTICIPANTS
  // ============================================================

  Widget _buildParticipantsList(List<Participants> participants) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.groups_rounded,
              color: AppColors.textMuted,
              size: _size(20, 17),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                'OTHER PARTICIPANTS',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: _size(12, 10),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.8,
                ),
              ),
            ),

            Text(
              '${participants.length}',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: _size(12, 10),
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),

        SizedBox(height: _size(12, 9)),

        ...List.generate(participants.length, (index) {
          final participant = participants[index];

          return _AnimatedParticipantCard(
            key: ValueKey(
              '${participant.name}_${participant.numberofpoints}_$index',
            ),
            participant: participant,
            rank: index + 4,
            delay: index * 70,
          );
        }),
      ],
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _size(25, 18),
        vertical: _size(40, 30),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_size(20, 16)),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: _size(65, 55),
            height: _size(65, 55),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.emoji_events_outlined,
              color: AppColors.primary,
              size: _size(32, 27),
            ),
          ),

          const SizedBox(height: 14),

          Text(
            'NO PARTICIPANTS YET',
            style: TextStyle(
              color: AppColors.text,
              fontSize: _size(15, 13),
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            'The leaderboard will appear here once participants join.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: _size(11, 9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ANIMATED PARTICIPANT CARD
// ============================================================================

class _AnimatedParticipantCard extends StatefulWidget {
  final Participants participant;
  final int rank;
  final int delay;

  const _AnimatedParticipantCard({
    super.key,
    required this.participant,
    required this.rank,
    required this.delay,
  });

  @override
  State<_AnimatedParticipantCard> createState() =>
      _AnimatedParticipantCardState();
}

class _AnimatedParticipantCardState extends State<_AnimatedParticipantCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fade;
  late Animation<Offset> _slide;

  bool _pressed = false;

  double _size(double normal, double small) {
    final width = MediaQuery.of(context).size.width;

    if (width < 360) {
      return small;
    }

    return normal;
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _slide = Tween<Offset>(
      begin: const Offset(0.08, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: 250 + widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              _pressed = true;
            });
          },
          onTapUp: (_) {
            setState(() {
              _pressed = false;
            });
          },
          onTapCancel: () {
            setState(() {
              _pressed = false;
            });
          },
          child: AnimatedScale(
            scale: _pressed ? 0.98 : 1,
            duration: const Duration(milliseconds: 100),
            child: Container(
              width: double.infinity,
              height: _size(68, 58),
              margin: EdgeInsets.only(bottom: _size(8, 6)),
              padding: EdgeInsets.symmetric(horizontal: _size(12, 9)),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(_size(16, 13)),
                border: Border.all(color: AppColors.border),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.transparentBlack08,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // ==================================================
                  // RANK
                  // ==================================================
                  SizedBox(
                    width: _size(30, 25),
                    child: Center(
                      child: Text(
                        '${widget.rank}',
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: _size(13, 11),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: _size(7, 5)),

                  // ==================================================
                  // AVATAR
                  // ==================================================
                  Container(
                    width: _size(43, 37),
                    height: _size(43, 37),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.20),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        widget.participant.name.isNotEmpty
                            ? widget.participant.name[0].toUpperCase()
                            : '?',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: _size(16, 14),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: _size(10, 7)),

                  // ==================================================
                  // NAME + POINTS
                  // ==================================================
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.participant.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.text,
                            fontSize: _size(13, 11),
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            Icon(
                              Icons.stars_rounded,
                              color: AppColors.primary,
                              size: _size(14, 12),
                            ),

                            const SizedBox(width: 4),

                            Flexible(
                              child: Text(
                                '${widget.participant.numberofpoints} points',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: _size(10, 8),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: _size(7, 5)),

                  // ==================================================
                  // PRIZE
                  // ==================================================
                  Container(
                    constraints: BoxConstraints(minWidth: _size(60, 50)),
                    padding: EdgeInsets.symmetric(
                      horizontal: _size(8, 6),
                      vertical: _size(6, 5),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${widget.participant.prize}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: _size(13, 11),
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        Text(
                          'PRIZE',
                          style: TextStyle(
                            color: AppColors.textMuted,
                            fontSize: _size(7, 6),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
