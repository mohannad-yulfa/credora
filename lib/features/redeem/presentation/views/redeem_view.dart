// [2025-12-26] Updated Redeem screen with a fixed top modern segmented tab bar navigation and responsive scaling for smaller screens.
import 'package:credora/features/activity/presentation/views/points_history_view.dart';
import 'package:credora/features/redeem/presentation/views/crypto_view.dart';
import 'package:credora/features/redeem/presentation/views/gift_cards_view.dart';
import 'package:credora/features/redeem/presentation/views/paypal_view.dart';
import 'package:credora/core/presentation/widgets/base_screen.dart';
import 'package:credora/core/presentation/widgets/bottom_bar.dart';
import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Redeem extends StatefulWidget {
  const Redeem({super.key});

  @override
  State<Redeem> createState() => _RedeemState();
}

class _RedeemState extends State<Redeem> {
  int pagenumber = 4;

  @override
  void initState() {
    BottomBar.CurrentPage = pagenumber;
    super.initState();
  }

  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  void _gotoPage(int index) {
    setState(() {
      currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
    );
  }

  final List<String> label = ["CRYPTO", "PAYPAL", "GIFT CARDS"];
  final List<IconData> tabIcons = [
    Icons.currency_bitcoin_rounded,
    Icons.paypal_rounded,
    Icons.card_giftcard_rounded,
  ];

  double getResponsiveSize(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 360) {
      return baseSize * (screenWidth / 360);
    }
    return baseSize;
  }

  // شريط التنقل العلوي الثابت الجديد (Different Modern Top Navigation Bar)
  Widget topNavigationBar(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(3, (index) {
          final bool isSelected = currentIndex == index;
          return GestureDetector(
            onTap: () => _gotoPage(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: getResponsiveSize(context, 16),
                vertical: getResponsiveSize(context, 10),
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
                  Icon(
                    tabIcons[index],
                    size: getResponsiveSize(context, 18),
                    color: isSelected ? AppColors.primary : AppColors.textMuted,
                  ),
                  SizedBox(width: getResponsiveSize(context, 6)),
                  Text(
                    label[index],
                    style: TextStyle(
                      fontSize: getResponsiveSize(context, 12),
                      fontWeight: FontWeight.w900,
                      color:
                          isSelected ? AppColors.primary : AppColors.textMuted,
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

  Widget header(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(getResponsiveSize(context, 22)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.darkTeal, AppColors.primaryStrong],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.15),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(getResponsiveSize(context, 12)),
                decoration: BoxDecoration(
                  color: AppColors.onPrimary.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColors.giftAccent,
                  size: getResponsiveSize(context, 32),
                ),
              ),
              SizedBox(width: getResponsiveSize(context, 16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Redeem Rewards',
                      style: TextStyle(
                        color: AppColors.onPrimary,
                        fontSize: getResponsiveSize(context, 22),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Convert your points instantly & securely.',
                      style: TextStyle(
                        color: AppColors.onPrimary.withOpacity(0.85),
                        fontSize: getResponsiveSize(context, 13),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget Mybalance(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(getResponsiveSize(context, 20)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.transparentBlack08,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Available Balance",
                style: TextStyle(
                  fontSize: getResponsiveSize(context, 16),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PointsHistory()),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "History",
                        style: TextStyle(
                          fontSize: getResponsiveSize(context, 13),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: getResponsiveSize(context, 12),
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: getResponsiveSize(context, 16)),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: getResponsiveSize(context, 14),
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "10",
                  style: TextStyle(
                    fontSize: getResponsiveSize(context, 28),
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(width: getResponsiveSize(context, 8)),
                Text(
                  "Points",
                  style: TextStyle(
                    fontSize: getResponsiveSize(context, 16),
                    color: AppColors.primary.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getResponsiveSize(context, 14)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: getResponsiveSize(context, 14),
                color: AppColors.textMuted,
              ),
              SizedBox(width: getResponsiveSize(context, 6)),
              Text(
                "1,000 points = \$1.00 USD",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: getResponsiveSize(context, 13),
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Basescreen(
      screen: Column(
        children: [
          // شريط التنقل الثابت في الأعلى تماماً تحت الـ App bar العادي
          topNavigationBar(context),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Crypto(head: header(context), mybalance: Mybalance(context)),
                Paypal(head: header(context), mybalance: Mybalance(context)),
                GiftCards(head: header(context), mybalance: Mybalance(context)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
