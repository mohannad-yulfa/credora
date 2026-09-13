import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class GiftCards extends StatefulWidget {
  final Widget head;
  final Widget mybalance;

  const GiftCards({super.key, required this.head, required this.mybalance});

  @override
  State<GiftCards> createState() => _GiftCardsState();
}

class _GiftCardsState extends State<GiftCards> {
  String? selectedCard;

  final TextEditingController emailController = TextEditingController();

  double get screenWidth => MediaQuery.of(context).size.width;

  bool get isSmallScreen => screenWidth < 360;

  double size(double normal, double small) {
    return isSmallScreen ? small : normal;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size(16, 12)),
      children: [
        // ============================================================
        // HEADER
        // ============================================================
        widget.head,

        SizedBox(height: size(22, 17)),

        // ============================================================
        // TITLE
        // ============================================================
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size(2, 1)),
          child: Row(
            children: [
              Container(
                width: size(42, 36),
                height: size(42, 36),
                decoration: BoxDecoration(
                  color: AppColors.giftAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(size(13, 11)),
                ),
                child: Center(
                  child: Image.asset(
                    'lib/images/gift-card.png',
                    width: size(24, 20),
                    height: size(24, 20),
                  ),
                ),
              ),
              SizedBox(width: size(12, 9)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gift Cards',
                      style: TextStyle(
                        fontSize: size(20, 17),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: size(3, 2)),
                    Text(
                      'Turn your points into rewards',
                      style: TextStyle(
                        fontSize: size(11, 9),
                        color: AppColors.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: size(20, 15)),

        // ============================================================
        // AVAILABLE BALANCE
        // Same widget/style used by Crypto
        // ============================================================
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: size(18, 14),
            vertical: size(17, 14),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.surface, AppColors.surfaceElevated],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: size(40, 36),
                height: size(40, 36),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppColors.success,
                  size: size(21, 19),
                ),
              ),

              SizedBox(width: size(12, 9)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Available balance",
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: size(11, 10),
                      ),
                    ),

                    SizedBox(height: size(3, 2)),

                    widget.mybalance,
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: size(14, 12),
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),

        SizedBox(height: size(25, 19)),

        // ============================================================
        // GIFT CARD SECTION
        // ============================================================
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(size(18, 14)),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(size(22, 18)),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------------
              // SECTION HEADER
              // ------------------------------------------------------
              Row(
                children: [
                  Container(
                    width: size(36, 31),
                    height: size(36, 31),
                    decoration: BoxDecoration(
                      color: AppColors.giftAccent.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Image.asset(
                        'lib/images/gift-card.png',
                        width: size(20, 17),
                        height: size(20, 17),
                      ),
                    ),
                  ),
                  SizedBox(width: size(10, 8)),
                  Expanded(
                    child: Text(
                      'Choose your reward',
                      style: TextStyle(
                        fontSize: size(16, 14),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size(20, 15)),

              // ------------------------------------------------------
              // GIFT CARD OPTIONS
              // ------------------------------------------------------
              Text(
                'Available gift cards',
                style: TextStyle(
                  fontSize: size(12, 10),
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: size(10, 8)),

              Row(
                children: [
                  Expanded(
                    child: _giftCardOption(
                      context,
                      title: 'Amazon',
                      icon: Icons.shopping_bag_outlined,
                      value: 'Amazon',
                    ),
                  ),
                  SizedBox(width: size(8, 6)),
                  Expanded(
                    child: _giftCardOption(
                      context,
                      title: 'iTunes',
                      icon: Icons.music_note_rounded,
                      value: 'iTunes',
                    ),
                  ),
                  SizedBox(width: size(8, 6)),
                  Expanded(
                    child: _giftCardOption(
                      context,
                      title: 'Google',
                      icon: Icons.play_arrow_rounded,
                      value: 'Google Play',
                    ),
                  ),
                ],
              ),

              SizedBox(height: size(20, 15)),

              // ------------------------------------------------------
              // EMAIL LABEL
              // ------------------------------------------------------
              Text(
                'Delivery email',
                style: TextStyle(
                  fontSize: size(12, 10),
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: size(8, 6)),

              // ------------------------------------------------------
              // EMAIL FIELD
              // ------------------------------------------------------
              Container(
                height: size(54, 48),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(size(15, 12)),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    SizedBox(width: size(14, 10)),
                    Icon(
                      Icons.mail_outline_rounded,
                      size: size(20, 17),
                      color: AppColors.giftAccent,
                    ),
                    SizedBox(width: size(10, 8)),
                    Expanded(
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: size(14, 12),
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(
                            fontSize: size(13, 11),
                            color: AppColors.textMuted,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.all(13),
                        ),
                      ),
                    ),
                    SizedBox(width: size(10, 7)),
                  ],
                ),
              ),

              SizedBox(height: size(18, 14)),

              // ------------------------------------------------------
              // SELECTED CARD INFO
              // ------------------------------------------------------
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: size(13, 10),
                  vertical: size(11, 8),
                ),
                decoration: BoxDecoration(
                  color:
                      selectedCard == null
                          ? AppColors.background
                          : AppColors.giftAccent.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(size(13, 10)),
                  border: Border.all(
                    color:
                        selectedCard == null
                            ? AppColors.border
                            : AppColors.giftAccent.withOpacity(0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      selectedCard == null
                          ? Icons.info_outline_rounded
                          : Icons.check_circle_outline_rounded,
                      size: size(18, 15),
                      color:
                          selectedCard == null
                              ? AppColors.textMuted
                              : AppColors.giftAccent,
                    ),
                    SizedBox(width: size(9, 7)),
                    Expanded(
                      child: Text(
                        selectedCard == null
                            ? 'Select a gift card to continue'
                            : '$selectedCard gift card selected',
                        style: TextStyle(
                          fontSize: size(11, 9),
                          color:
                              selectedCard == null
                                  ? AppColors.textMuted
                                  : AppColors.giftAccent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size(20, 15)),

              // ------------------------------------------------------
              // CONFIRM BUTTON
              // ------------------------------------------------------
              SizedBox(
                width: double.infinity,
                height: size(52, 46),
                child: ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();

                    if (email.isEmpty || selectedCard == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please enter your email and select a gift card.",
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Request submitted for $selectedCard to $email",
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.black,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size(15, 12)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.card_giftcard_rounded,
                        size: size(18, 15),
                        color: AppColors.black,
                      ),
                      SizedBox(width: size(8, 6)),
                      Text(
                        'REDEEM GIFT CARD',
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: size(13, 11),
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: size(18, 14)),

        // ============================================================
        // INFORMATION
        // ============================================================
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(size(15, 11)),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(size(16, 13)),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.verified_outlined,
                    size: size(19, 16),
                    color: AppColors.giftAccent,
                  ),
                  SizedBox(width: size(9, 7)),
                  Expanded(
                    child: Text(
                      'Gift card information',
                      style: TextStyle(
                        fontSize: size(13, 11),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size(9, 7)),

              Text(
                'Please make sure that the email address '
                'you entered is correct before submitting your request.',
                style: TextStyle(
                  fontSize: size(11, 9),
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: size(12, 9)),

        // ============================================================
        // HELP
        // ============================================================
        Center(
          child: TextButton.icon(
            onPressed: () {
              // Handle need help action
            },
            icon: Icon(
              Icons.help_outline_rounded,
              size: size(17, 14),
              color: AppColors.blue,
            ),
            label: Text(
              'Need Help?',
              style: TextStyle(
                color: AppColors.blue,
                fontSize: size(12, 10),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        SizedBox(height: size(15, 10)),

        // ============================================================
        // FOOTER
        // ============================================================
        Center(
          child: Text(
            'Rewards made simple with Credora',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.w700,
              fontSize: size(12, 10),
            ),
          ),
        ),

        SizedBox(height: size(35, 25)),
      ],
    );
  }

  // ==================================================================
  // GIFT CARD OPTION
  // ==================================================================
  Widget _giftCardOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String value,
  }) {
    final bool isSelected = selectedCard == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCard = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: size(82, 70),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.giftAccent.withOpacity(0.10)
                  : AppColors.background,
          borderRadius: BorderRadius.circular(size(15, 12)),
          border: Border.all(
            color: isSelected ? AppColors.giftAccent : AppColors.border,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: size(24, 20),
                    color:
                        isSelected ? AppColors.giftAccent : AppColors.textMuted,
                  ),
                  SizedBox(height: size(6, 4)),
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size(10, 8),
                      fontWeight: FontWeight.w800,
                      color:
                          isSelected
                              ? AppColors.giftAccent
                              : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),

            if (isSelected)
              Positioned(
                top: size(6, 5),
                right: size(6, 5),
                child: Icon(
                  Icons.check_circle_rounded,
                  size: size(15, 13),
                  color: AppColors.giftAccent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
