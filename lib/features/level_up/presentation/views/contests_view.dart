import 'package:credora/features/level_up/presentation/views/contest_surveys_view.dart';
import 'package:credora/features/level_up/presentation/views/monthly_contest_view.dart';
import 'package:credora/features/level_up/presentation/views/weekly_contest_view.dart';
import 'package:credora/core/presentation/widgets/base_screen.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Contests extends StatefulWidget {
  const Contests({super.key});

  @override
  State<Contests> createState() => _ContestsState();
}

class _ContestsState extends State<Contests>
    with SingleTickerProviderStateMixin {
  int currentIndex = 1;

  late AnimationController _headerAnimationController;
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;

  final List<String> label = ["WEEKLY", "MONTHLY", "SURVEYS"];

  final List<IconData> tabIcons = [
    Icons.calendar_view_week_rounded,
    Icons.calendar_month_rounded,
    Icons.assignment_rounded,
  ];

  double getResponsiveSize(BuildContext context, double normal, double small) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 360) {
      return small;
    }

    return normal;
  }

  @override
  void initState() {
    super.initState();

    _headerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    _headerFadeAnimation = CurvedAnimation(
      parent: _headerAnimationController,
      curve: Curves.easeOutCubic,
    );

    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _headerAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _headerAnimationController.forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    super.dispose();
  }

  void _gotoPage(int index) {
    if (currentIndex == index) {
      return;
    }

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Basescreen(
      backGround: AppColors.background,
      screen: Column(
        children: [
          _buildTopNavigationBar(context),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildTopNavigationBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: getResponsiveSize(context, 16, 10),
        vertical: getResponsiveSize(context, 10, 7),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(label.length, (index) {
          final bool isSelected = currentIndex == index;

          return GestureDetector(
            onTap: () => _gotoPage(index),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: getResponsiveSize(context, 16, 9),
                vertical: getResponsiveSize(context, 10, 7),
              ),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? AppColors.primary.withOpacity(0.12)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: isSelected ? 1.0 : 0.92,
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutBack,
                    child: Icon(
                      tabIcons[index],
                      size: getResponsiveSize(context, 18, 15),
                      color:
                          isSelected ? AppColors.primary : AppColors.textMuted,
                    ),
                  ),
                  SizedBox(width: getResponsiveSize(context, 6, 4)),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    style: TextStyle(
                      fontSize: getResponsiveSize(context, 12, 9),
                      fontWeight: FontWeight.w900,
                      color:
                          isSelected ? AppColors.primary : AppColors.textMuted,
                    ),
                    child: Text(
                      label[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      reverseDuration: const Duration(milliseconds: 250),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation) {
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.025, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: slideAnimation, child: child),
        );
      },
      child: _buildSelectedPage(),
    );
  }

  Widget _buildSelectedPage() {
    switch (currentIndex) {
      case 0:
        return Weekly(key: const ValueKey("weekly"), header: _buildHeader());

      case 1:
        return Monthly(key: const ValueKey("monthly"), header: _buildHeader());

      case 2:
        return ContestsSurveys(
          key: const ValueKey("surveys"),
          header: _buildHeader(),
        );

      default:
        return Monthly(key: const ValueKey("monthly"), header: _buildHeader());
    }
  }

  Widget _buildHeader() {
    return FadeTransition(
      opacity: _headerFadeAnimation,
      child: SlideTransition(
        position: _headerSlideAnimation,
        child: _buildHeroCard(),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      height: getResponsiveSize(context, 190, 158),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getResponsiveSize(context, 27, 21)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.darkTeal, AppColors.primaryStrong],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 24,
            offset: const Offset(0, 11),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -45,
            top: -55,
            child: Container(
              width: getResponsiveSize(context, 175, 140),
              height: getResponsiveSize(context, 175, 140),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.giftAccent.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            right: -20,
            bottom: -65,
            child: Container(
              width: getResponsiveSize(context, 145, 115),
              height: getResponsiveSize(context, 145, 115),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onPrimary.withOpacity(0.045),
              ),
            ),
          ),
          Positioned(
            left: -35,
            bottom: -75,
            child: Container(
              width: getResponsiveSize(context, 130, 105),
              height: getResponsiveSize(context, 130, 105),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.giftAccent.withOpacity(0.045),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(getResponsiveSize(context, 20, 15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: getResponsiveSize(context, 55, 44),
                      height: getResponsiveSize(context, 55, 44),
                      decoration: BoxDecoration(
                        color: AppColors.giftAccent.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(
                          getResponsiveSize(context, 18, 14),
                        ),
                        border: Border.all(
                          color: AppColors.giftAccent.withOpacity(0.22),
                        ),
                      ),
                      child: Icon(
                        Icons.emoji_events_rounded,
                        color: AppColors.giftAccent,
                        size: getResponsiveSize(context, 30, 24),
                      ),
                    ),
                    SizedBox(width: getResponsiveSize(context, 13, 9)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CREDORA CONTESTS",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.giftAccent,
                              fontSize: getResponsiveSize(context, 10, 8),
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.1,
                            ),
                          ),
                          SizedBox(height: getResponsiveSize(context, 4, 2)),
                          Text(
                            "Compete & Win",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.onPrimary,
                              fontSize: getResponsiveSize(context, 19, 16),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "Challenge yourself.\nEarn more points.",
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: getResponsiveSize(context, 25, 21),
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: getResponsiveSize(context, 7, 5)),
                Text(
                  "Join contests, answer surveys and climb the leaderboard.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onPrimary.withOpacity(0.72),
                    fontSize: getResponsiveSize(context, 11, 9),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
