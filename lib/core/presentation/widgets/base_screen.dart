// [Developer: مهند هشام اللحجة / 2026]
// Refactored Basescreen featuring a clean, elegant layout, modern custom drawer opening style, polished header aesthetics, and smooth ZoomDrawer integration.

import 'package:credora/features/activity/presentation/views/points_history_view.dart';
import 'package:credora/core/presentation/widgets/bottom_bar.dart';
import 'package:credora/core/presentation/widgets/app_menu.dart';
import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Basescreen extends StatefulWidget {
  final Widget screen;
  final Color backGround;
  const Basescreen({
    super.key,
    required this.screen,
    this.backGround = AppColors.background,
  });

  @override
  State<Basescreen> createState() => _BasescreenState();
}

class _BasescreenState extends State<Basescreen>
    with SingleTickerProviderStateMixin {
  final ZoomDrawerController _zoomDrawerController = ZoomDrawerController();
  String menus = "lib/images/menus.png";

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _zoomDrawerController.stateNotifier?.addListener(() {
        if (!mounted) return;
        final state = _zoomDrawerController.stateNotifier!.value;
        if (state == DrawerState.open) {
          setState(() {
            menus = "lib/images/cross.png";
          });
        } else if (state == DrawerState.closed) {
          setState(() {
            menus = "lib/images/menus.png";
          });
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final drawerWidth = (screenWidth * 0.78).clamp(250.0, 320.0).toDouble();

    return Scaffold(
      backgroundColor: widget.backGround,
      body: ZoomDrawer(
        controller: _zoomDrawerController,
        // Changed to styleDefault for a cleaner, modern sliding motion without heavy screen distortion or tilting
        style: DrawerStyle.style1,
        menuScreen: Menu(),
        slideWidth: drawerWidth,
        borderRadius: 32.0,
        showShadow: true,
        angle: 0.0, // Removed awkward rotation angle for a professional feel
        openCurve: Curves.easeOutCubic,
        closeCurve: Curves.easeInOutCubic,
        mainScreenTapClose: true,
        menuBackgroundColor: AppColors.surface,
        mainScreen: Scaffold(
          backgroundColor: widget.backGround,
          appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.transparent,
            leadingWidth: 64,
            leading: Center(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    _zoomDrawerController.toggle?.call();
                  },
                  child: Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.12),
                        width: 1,
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Image.asset(
                        menus,
                        key: ValueKey(menus),
                        width: 18,
                        height: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: AppColors.surface,
            titleSpacing: 4,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback:
                      (bounds) => LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                  child: const Text(
                    "credora",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Earn more every day",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.push(
                          context,
                          AppMotion.page(PointsHistory()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.monetization_on_rounded,
                              color: AppColors.primary,
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Points",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: false,
            toolbarHeight: 70,
          ),
          body: Column(
            children: [Expanded(child: widget.screen), const BottomBar()],
          ),
        ),
      ),
    );
  }
}
