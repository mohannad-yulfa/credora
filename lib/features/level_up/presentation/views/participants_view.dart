import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Participants extends StatefulWidget {
  final String name;
  final int numberofpoints;
  final int prize;

  const Participants({
    super.key,
    required this.name,
    required this.numberofpoints,
    required this.prize,
  });

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
      duration: const Duration(milliseconds: 550),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.08, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(const Duration(milliseconds: 80), () {
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
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: GestureDetector(
          onTapDown: (_) {
            setState(() {
              _pressed = true;
            });
          },
          onTapCancel: () {
            setState(() {
              _pressed = false;
            });
          },
          onTapUp: (_) {
            setState(() {
              _pressed = false;
            });
          },
          child: AnimatedScale(
            scale: _pressed ? 0.985 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: _buildParticipantCard(),
          ),
        ),
      ),
    );
  }

  Widget _buildParticipantCard() {
    return Container(
      width: double.infinity,
      height: _size(76, 64),
      margin: EdgeInsets.only(bottom: _size(9, 7)),
      padding: EdgeInsets.symmetric(
        horizontal: _size(12, 9),
        vertical: _size(8, 6),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_size(18, 14)),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildAvatar(),
          SizedBox(width: _size(11, 8)),
          Expanded(child: _buildPlayerInfo()),
          SizedBox(width: _size(8, 5)),
          _buildPointsSection(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: _size(45, 37),
      height: _size(45, 37),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.16),
            AppColors.primary.withOpacity(0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(_size(14, 11)),
        border: Border.all(color: AppColors.primary.withOpacity(0.15)),
      ),
      child: Icon(
        Icons.person_rounded,
        color: AppColors.primary,
        size: _size(24, 20),
      ),
    );
  }

  Widget _buildPlayerInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.text,
            fontSize: _size(13, 10),
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: _size(4, 3)),
        Row(
          children: [
            Icon(
              Icons.workspace_premium_outlined,
              color: AppColors.textMuted,
              size: _size(13, 11),
            ),
            SizedBox(width: _size(4, 3)),
            Flexible(
              child: Text(
                "Prize: ${widget.prize} points",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: _size(9, 7),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPointsSection() {
    return Container(
      constraints: BoxConstraints(minWidth: _size(78, 63)),
      padding: EdgeInsets.symmetric(
        horizontal: _size(9, 7),
        vertical: _size(7, 5),
      ),
      decoration: BoxDecoration(
        color: AppColors.success.withOpacity(0.09),
        borderRadius: BorderRadius.circular(_size(13, 10)),
        border: Border.all(color: AppColors.success.withOpacity(0.13)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.numberofpoints.toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.success,
              fontSize: _size(14, 11),
              fontWeight: FontWeight.w900,
              height: 1,
            ),
          ),
          SizedBox(height: _size(3, 2)),
          Text(
            "POINTS",
            style: TextStyle(
              color: AppColors.success.withOpacity(0.75),
              fontSize: _size(7, 6),
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
