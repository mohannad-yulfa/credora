import 'package:credora/features/level_up/presentation/views/active_view.dart';
import 'package:credora/features/level_up/presentation/views/expired_gifts_view.dart';
import 'package:credora/core/presentation/widgets/base_screen.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Giveaways extends StatefulWidget {
  const Giveaways({super.key});

  @override
  State<Giveaways> createState() => _GiveawaysState();
}

class _GiveawaysState extends State<Giveaways>
    with SingleTickerProviderStateMixin {
  int pageIndex = 0;

  Widget activeExpiredGiftsPage = Active();

  late AnimationController _headerController;
  late Animation<double> _headerFade;
  late Animation<Offset> _headerSlide;

  final List<String> labels = ["ACTIVE", "RECENTLY ENDED"];

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

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _headerFade = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    );

    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.12),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOutCubic),
    );

    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  // ===============================================================
  // CHANGE PAGE
  // ===============================================================

  void _gotoPage(int index) {
    if (index == pageIndex) return;

    setState(() {
      pageIndex = index;

      if (index == 0) {
        activeExpiredGiftsPage = Active();
      } else {
        activeExpiredGiftsPage = ExpiredGiftsPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Basescreen(
      screen: Column(
        children: [
          // =========================================================
          // FIXED TOP NAVIGATION
          // =========================================================
          _buildTopNavigationBar(),

          // =========================================================
          // CONTENT
          // =========================================================
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              reverseDuration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                final slideAnimation = Tween<Offset>(
                  begin: const Offset(0.06, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                );

                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey(pageIndex),
                child: _buildPageContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // TOP NAVIGATION BAR
  // نفس فكرة شريط Redeem / Contests
  // ===============================================================

  Widget _buildTopNavigationBar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _size(16, 12),
        vertical: _size(12, 9),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(labels.length, (index) {
          final selected = pageIndex == index;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: _size(4, 2)),
              child: GestureDetector(
                onTap: () => _gotoPage(index),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(
                    horizontal: _size(10, 6),
                    vertical: _size(9, 7),
                  ),
                  decoration: BoxDecoration(
                    color:
                        selected
                            ? AppColors.primary.withOpacity(0.12)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected ? AppColors.primary : Colors.transparent,
                      width: selected ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0
                            ? Icons.local_fire_department_rounded
                            : Icons.history_rounded,
                        size: _size(18, 15),
                        color:
                            selected ? AppColors.primary : AppColors.textMuted,
                      ),

                      SizedBox(width: _size(6, 4)),

                      Flexible(
                        child: Text(
                          labels[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                selected
                                    ? AppColors.primary
                                    : AppColors.textMuted,
                            fontSize: _size(12, 9),
                            fontWeight:
                                selected ? FontWeight.w800 : FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ===============================================================
  // PAGE CONTENT
  // ===============================================================

  Widget _buildPageContent() {
    return ListView(
      key: ValueKey('content_$pageIndex'),
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        _size(16, 12),
        _size(16, 12),
        _size(16, 12),
        _size(35, 25),
      ),
      children: [
        // =========================================================
        // HERO HEADER
        // =========================================================
        FadeTransition(
          opacity: _headerFade,
          child: SlideTransition(
            position: _headerSlide,
            child: _buildHeroHeader(),
          ),
        ),

        SizedBox(height: _size(25, 18)),

        // =========================================================
        // CURRENT PAGE INDICATOR
        // =========================================================
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Row(
            key: ValueKey(pageIndex),
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: _size(7, 6),
                height: _size(7, 6),
                decoration: BoxDecoration(
                  color:
                      pageIndex == 0 ? AppColors.primary : AppColors.textMuted,
                  shape: BoxShape.circle,
                ),
              ),

              SizedBox(width: _size(8, 6)),

              Expanded(
                child: Text(
                  pageIndex == 0
                      ? "Giveaways available now"
                      : "Recently completed giveaways",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: _size(12, 10),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: _size(15, 11)),

        // =========================================================
        // ACTIVE / EXPIRED CONTENT
        // =========================================================
        activeExpiredGiftsPage,

        SizedBox(height: _size(50, 35)),
      ],
    );
  }

  // ===============================================================
  // HERO HEADER
  // ===============================================================

  Widget _buildHeroHeader() {
    return Container(
      height: _size(175, 145),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_size(28, 22)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.darkTeal, AppColors.primaryStrong],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          // =========================================================
          // DECORATIVE CIRCLE
          // =========================================================
          Positioned(
            right: -35,
            top: -40,
            child: Container(
              width: _size(145, 120),
              height: _size(145, 120),
              decoration: BoxDecoration(
                color: AppColors.giftAccent.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            right: 30,
            bottom: -55,
            child: Container(
              width: _size(110, 90),
              height: _size(110, 90),
              decoration: BoxDecoration(
                color: AppColors.onPrimary.withOpacity(0.04),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // =========================================================
          // HEADER CONTENT
          // =========================================================
          Padding(
            padding: EdgeInsets.all(_size(21, 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: _size(52, 43),
                      height: _size(52, 43),
                      decoration: BoxDecoration(
                        color: AppColors.giftAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(_size(17, 13)),
                        border: Border.all(
                          color: AppColors.giftAccent.withOpacity(0.2),
                        ),
                      ),
                      child: Icon(
                        Icons.card_giftcard_rounded,
                        color: AppColors.giftAccent,
                        size: _size(28, 23),
                      ),
                    ),

                    SizedBox(width: _size(13, 9)),

                    Expanded(
                      child: Text(
                        "FREE GIVEAWAYS",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.giftAccent,
                          fontSize: _size(11, 9),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Text(
                  "Win more.\nSpend nothing.",
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: _size(25, 21),
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                SizedBox(height: _size(7, 5)),

                Text(
                  "Enter exciting giveaways and get a chance to win rewards.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onPrimary.withOpacity(0.72),
                    fontSize: _size(11, 9),
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
