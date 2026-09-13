import 'package:credora/core/presentation/widgets/base_screen.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class Referrals extends StatefulWidget {
  const Referrals({super.key});

  @override
  State<Referrals> createState() => _ReferralsState();
}

class _ReferralsState extends State<Referrals> {
  final TextEditingController _controller = TextEditingController(
    text: "https://xxxxx.me?refer=7186793",
  );

  final String referralCode = "7186793";

  double _size(BuildContext context, double normal, double small) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 360) {
      return small;
    }

    return normal;
  }

  Future<void> _shareLink() async {
    final txt = _controller.text.trim();

    if (txt.isEmpty) {
      return;
    }

    await Share.share('Join me on Credora and start earning rewards!\n\n$txt');
  }

  Future<void> _copyLink() async {
    await Clipboard.setData(ClipboardData(text: _controller.text.trim()));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: AppColors.onPrimary),
            SizedBox(width: 10),
            Text('Referral link copied'),
          ],
        ),
        backgroundColor: AppColors.primaryStrong,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Basescreen(
      screen: ListView(
        padding: EdgeInsets.fromLTRB(
          _size(context, 16, 12),
          _size(context, 18, 14),
          _size(context, 16, 12),
          _size(context, 30, 22),
        ),
        children: [
          // =========================================================
          // HEADER
          // =========================================================
          Container(
            padding: EdgeInsets.all(_size(context, 20, 15)),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.darkTeal, AppColors.primaryStrong],
              ),
              borderRadius: BorderRadius.circular(_size(context, 22, 18)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: _size(context, 58, 48),
                  height: _size(context, 58, 48),
                  decoration: BoxDecoration(
                    color: AppColors.giftAccent.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(_size(context, 18, 15)),
                    border: Border.all(
                      color: AppColors.giftAccent.withOpacity(0.35),
                    ),
                  ),
                  child: Icon(
                    Icons.group_add_rounded,
                    color: AppColors.giftAccent,
                    size: _size(context, 31, 26),
                  ),
                ),
                SizedBox(width: _size(context, 14, 10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Refer & Earn',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: _size(context, 23, 19),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: _size(context, 5, 3)),
                      Text(
                        'Invite friends and earn rewards together.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.onPrimary.withOpacity(0.82),
                          fontSize: _size(context, 13, 11),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: _size(context, 22, 17)),

          // =========================================================
          // SECTION TITLE
          // =========================================================
          Row(
            children: [
              Container(
                width: _size(context, 4, 3),
                height: _size(context, 24, 20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: _size(context, 10, 8)),
              Text(
                'Your Referral Link',
                style: TextStyle(
                  fontSize: _size(context, 20, 17),
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
            ],
          ),

          SizedBox(height: _size(context, 12, 9)),

          // =========================================================
          // REFERRAL LINK CARD
          // =========================================================
          Container(
            padding: EdgeInsets.all(_size(context, 16, 12)),
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(_size(context, 20, 16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Link field
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _size(context, 13, 10),
                    vertical: _size(context, 3, 2),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSoft,
                    borderRadius: BorderRadius.circular(_size(context, 14, 11)),
                    border: Border.all(
                      color: AppColors.border.withOpacity(0.7),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: _size(context, 36, 30),
                        height: _size(context, 36, 30),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(
                            _size(context, 10, 8),
                          ),
                        ),
                        child: Icon(
                          Icons.link_rounded,
                          color: AppColors.primary,
                          size: _size(context, 20, 17),
                        ),
                      ),
                      SizedBox(width: _size(context, 10, 7)),
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: TextStyle(
                            fontSize: _size(context, 14, 11),
                            color: AppColors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _copyLink,
                        splashRadius: _size(context, 22, 18),
                        tooltip: 'Copy',
                        icon: Icon(
                          Icons.copy_rounded,
                          color: AppColors.primary,
                          size: _size(context, 21, 17),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: _size(context, 14, 10)),

                // Share button
                SizedBox(
                  width: double.infinity,
                  height: _size(context, 52, 46),
                  child: ElevatedButton.icon(
                    onPressed: _shareLink,
                    icon: Icon(
                      Icons.share_rounded,
                      color: AppColors.onPrimary,
                      size: _size(context, 21, 18),
                    ),
                    label: Text(
                      'SHARE REFERRAL LINK',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w800,
                        fontSize: _size(context, 14, 11),
                        letterSpacing: 0.3,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          _size(context, 16, 13),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: _size(context, 14, 10)),

          // =========================================================
          // REFERRAL CODE
          // =========================================================
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: _size(context, 16, 12),
              vertical: _size(context, 13, 10),
            ),
            decoration: BoxDecoration(
              color: AppColors.surfaceSoft,
              borderRadius: BorderRadius.circular(_size(context, 16, 13)),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.confirmation_number_outlined,
                  color: AppColors.primary,
                  size: _size(context, 22, 18),
                ),
                SizedBox(width: _size(context, 10, 8)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Referral Code',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: _size(context, 11, 9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: _size(context, 2, 1)),
                      Text(
                        referralCode,
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: _size(context, 16, 13),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: referralCode));

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Referral code copied'),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: AppColors.primaryStrong,
                        margin: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: _size(context, 12, 9),
                      vertical: _size(context, 7, 5),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(
                        _size(context, 10, 8),
                      ),
                    ),
                    child: Text(
                      'COPY',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: _size(context, 11, 9),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: _size(context, 24, 18)),

          // =========================================================
          // STATS
          // =========================================================
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.people_alt_rounded,
                  value: '0',
                  label: 'Referrals',
                ),
              ),
              SizedBox(width: _size(context, 10, 7)),
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.stars_rounded,
                  value: '0',
                  label: 'Rewards',
                ),
              ),
              SizedBox(width: _size(context, 10, 7)),
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.hourglass_top_rounded,
                  value: '0',
                  label: 'Pending',
                ),
              ),
            ],
          ),

          SizedBox(height: _size(context, 24, 18)),

          // =========================================================
          // YOUR STATS BUTTON
          // =========================================================
          SizedBox(
            width: double.infinity,
            height: _size(context, 52, 46),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.bar_chart_rounded,
                color: AppColors.primary,
                size: _size(context, 22, 18),
              ),
              label: Text(
                'VIEW YOUR STATS',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: _size(context, 14, 11),
                  letterSpacing: 0.4,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primary, width: 1.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_size(context, 16, 13)),
                ),
              ),
            ),
          ),

          SizedBox(height: _size(context, 28, 21)),

          // =========================================================
          // HOW IT WORKS TITLE
          // =========================================================
          Row(
            children: [
              Container(
                width: _size(context, 4, 3),
                height: _size(context, 23, 19),
                decoration: BoxDecoration(
                  color: AppColors.giftAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: _size(context, 10, 8)),
              Text(
                'How It Works',
                style: TextStyle(
                  color: AppColors.text,
                  fontSize: _size(context, 19, 16),
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          SizedBox(height: _size(context, 13, 10)),

          // =========================================================
          // STEP 1
          // =========================================================
          _buildStep(
            context,
            number: '1',
            icon: Icons.link_rounded,
            title: 'Share your link',
            description: 'Send your personal referral link to your friends.',
          ),

          SizedBox(height: _size(context, 10, 7)),

          // =========================================================
          // STEP 2
          // =========================================================
          _buildStep(
            context,
            number: '2',
            icon: Icons.person_add_alt_1_rounded,
            title: 'Friend joins Credora',
            description: 'Your friend signs up using your referral link.',
          ),

          SizedBox(height: _size(context, 10, 7)),

          // =========================================================
          // STEP 3
          // =========================================================
          _buildStep(
            context,
            number: '3',
            icon: Icons.card_giftcard_rounded,
            title: 'Both earn rewards',
            description:
                'Once the referral is completed, rewards become available.',
          ),

          SizedBox(height: _size(context, 28, 21)),

          // =========================================================
          // BENEFITS CARD
          // =========================================================
          Container(
            padding: EdgeInsets.all(_size(context, 18, 14)),
            decoration: BoxDecoration(
              color: AppColors.darkTeal,
              borderRadius: BorderRadius.circular(_size(context, 20, 16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: _size(context, 40, 33),
                      height: _size(context, 40, 33),
                      decoration: BoxDecoration(
                        color: AppColors.giftAccent.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(
                          _size(context, 12, 9),
                        ),
                      ),
                      child: Icon(
                        Icons.emoji_events_rounded,
                        color: AppColors.giftAccent,
                        size: _size(context, 22, 18),
                      ),
                    ),
                    SizedBox(width: _size(context, 11, 8)),
                    Expanded(
                      child: Text(
                        'Why refer friends?',
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: _size(context, 17, 14),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: _size(context, 16, 12)),

                _buildBenefit(
                  context,
                  Icons.monetization_on_outlined,
                  'Earn rewards from successful referrals',
                ),

                SizedBox(height: _size(context, 10, 7)),

                _buildBenefit(
                  context,
                  Icons.groups_outlined,
                  'Help your friends discover Credora',
                ),

                SizedBox(height: _size(context, 10, 7)),

                _buildBenefit(
                  context,
                  Icons.flash_on_rounded,
                  'Share your link instantly from the app',
                ),
              ],
            ),
          ),

          SizedBox(height: _size(context, 24, 18)),

          // =========================================================
          // HELP
          // =========================================================
          Container(
            padding: EdgeInsets.all(_size(context, 16, 12)),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(_size(context, 18, 14)),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: _size(context, 42, 35),
                  height: _size(context, 42, 35),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.help_outline_rounded,
                    color: AppColors.primary,
                    size: _size(context, 22, 18),
                  ),
                ),
                SizedBox(width: _size(context, 12, 9)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Need Help?',
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: _size(context, 14, 12),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: _size(context, 3, 2)),
                      Text(
                        'Learn more about referral rewards.',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.text,
                          fontSize: _size(context, 11, 9),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.text,
                  size: _size(context, 16, 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // STAT CARD
  // ===============================================================
  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: _size(context, 15, 11),
        horizontal: _size(context, 8, 5),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_size(context, 17, 13)),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primary, size: _size(context, 24, 20)),
          SizedBox(height: _size(context, 7, 5)),
          Text(
            value,
            style: TextStyle(
              color: AppColors.text,
              fontSize: _size(context, 19, 16),
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: _size(context, 2, 1)),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontSize: _size(context, 10, 8),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // STEP CARD
  // ===============================================================
  Widget _buildStep(
    BuildContext context, {
    required String number,
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(_size(context, 14, 10)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_size(context, 18, 14)),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: _size(context, 48, 39),
                height: _size(context, 48, 39),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(_size(context, 14, 11)),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primary,
                  size: _size(context, 24, 19),
                ),
              ),
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  width: _size(context, 19, 16),
                  height: _size(context, 19, 16),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.surface, width: 2),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    number,
                    style: TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: _size(context, 9, 7),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: _size(context, 14, 10)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: _size(context, 14, 11),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: _size(context, 4, 3)),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: _size(context, 11, 9),
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

  // ===============================================================
  // BENEFIT ROW
  // ===============================================================
  Widget _buildBenefit(BuildContext context, IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: AppColors.giftAccent, size: _size(context, 20, 16)),
        SizedBox(width: _size(context, 10, 7)),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.onPrimary.withOpacity(0.88),
              fontSize: _size(context, 12, 10),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
