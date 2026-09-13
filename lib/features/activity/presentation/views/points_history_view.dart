import 'package:credora/features/activity/presentation/views/clicked_activity_view.dart';
import 'package:credora/features/activity/presentation/views/credited_activity_view.dart';
import 'package:credora/features/activity/domain/entities/activity_entities.dart';
import 'package:credora/core/presentation/widgets/base_screen.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PointsHistory extends StatefulWidget {
  const PointsHistory({super.key});

  @override
  State<PointsHistory> createState() => _PointsHistoryState();
}

class _PointsHistoryState extends State<PointsHistory>
    with SingleTickerProviderStateMixin {
  final List<CerditedActivity> creditedActivities = [
    CerditedActivity(date: '2025-04-01', Amount: '100', name: 'Verify email'),
    CerditedActivity(date: '2025-04-05', Amount: '250', name: 'Verify email'),
    CerditedActivity(date: '2025-04-10', Amount: '75', name: 'Verify email'),
  ];

  final List<PendingActivity> pendingActivities = [
    PendingActivity(
      creditReleaseDate: '2025-04-15',
      Amount: '150',
      Action: 'Waiting',
    ),
    PendingActivity(
      creditReleaseDate: '2025-04-18',
      Amount: '300',
      Action: 'Reviewing',
    ),
    PendingActivity(
      creditReleaseDate: '2025-04-20',
      Amount: '500',
      Action: 'Pending Approval',
    ),
  ];

  final List<ClickedActivity> clickedActivities = [
    ClickedActivity(date: '03:53 AM 04-12-25', offerName: 'Loot Chest Daily'),
    ClickedActivity(
      date: '03:50 AM 04-12-25',
      offerName: 'Earn credora Points',
    ),
    ClickedActivity(date: '10:49 AM 04-09-25', offerName: 'Loot Chest Daily'),
    ClickedActivity(date: '10:48 AM 04-07-25', offerName: 'Loot Chest Daily'),
    ClickedActivity(
      date: '10:25 AM 04-01-25',
      offerName: 'Install & Open the credora.me Android app to earn rewards.',
    ),
  ];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  double _size(double normal, double small) {
    if (MediaQuery.of(context).size.width < 360) {
      return small;
    }

    return normal;
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Basescreen(
      screen: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          _size(16, 12),
          _size(18, 12),
          _size(16, 12),
          _size(40, 28),
        ),
        children: [
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: _buildHero(),
            ),
          ),
          SizedBox(height: _size(18, 14)),
          _buildSummary(),
          SizedBox(height: _size(26, 20)),
          _buildSection(
            title: 'Pending activity',
            subtitle: 'Waiting to be released',
            icon: Icons.schedule_rounded,
            color: AppColors.warning,
            child: _buildPendingCard(),
          ),
          SizedBox(height: _size(24, 18)),
          _buildSection(
            title: 'Credited activity',
            subtitle: 'Lifetime earnings: 10.0 points',
            icon: Icons.check_circle_outline_rounded,
            color: AppColors.success,
            child: _buildCreditedCard(),
          ),
          SizedBox(height: _size(24, 18)),
          _buildSection(
            title: 'Clicked activity',
            subtitle: 'Your recent offer visits',
            icon: Icons.touch_app_rounded,
            color: AppColors.primary,
            child: _buildClickedCard(),
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      padding: EdgeInsets.all(_size(20, 15)),
      decoration: BoxDecoration(
        color: AppColors.darkTeal,
        borderRadius: BorderRadius.circular(_size(24, 20)),
        boxShadow: const [
          BoxShadow(
            color: AppColors.transparentBlack08,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: _size(58, 50),
            height: _size(58, 50),
            decoration: BoxDecoration(
              color: AppColors.giftAccent.withOpacity(0.14),
              borderRadius: BorderRadius.circular(_size(18, 15)),
              border: Border.all(color: AppColors.giftAccent.withOpacity(0.24)),
            ),
            child: Icon(
              Icons.insights_rounded,
              color: AppColors.giftAccent,
              size: _size(31, 27),
            ),
          ),
          SizedBox(width: _size(14, 11)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Points activity',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: _size(23, 20),
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Track every point you earn and unlock.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onPrimary.withOpacity(0.72),
                    fontSize: _size(12, 10),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Row(
      children: [
        Expanded(
          child: _summaryTile(
            value: '10.0',
            label: 'Total points',
            icon: Icons.stars_rounded,
            color: AppColors.primary,
          ),
        ),
        SizedBox(width: _size(10, 8)),
        Expanded(
          child: _summaryTile(
            value: '0.0',
            label: 'Pending',
            icon: Icons.schedule_rounded,
            color: AppColors.warning,
          ),
        ),
      ],
    );
  }

  Widget _summaryTile({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      height: _size(84, 74),
      padding: EdgeInsets.symmetric(
        horizontal: _size(13, 10),
        vertical: _size(11, 9),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_size(17, 15)),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.transparentBlack08,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: _size(40, 35),
            height: _size(40, 35),
            decoration: BoxDecoration(
              color: color.withOpacity(0.11),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: _size(22, 19)),
          ),
          SizedBox(width: _size(9, 7)),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.primaryStrong,
                    fontSize: _size(19, 17),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: _size(11, 9),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: _size(38, 34),
              height: _size(38, 34),
              decoration: BoxDecoration(
                color: color.withOpacity(0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: _size(20, 18)),
            ),
            SizedBox(width: _size(10, 8)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: _size(18, 16),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: _size(10, 9),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: _size(11, 9)),
        child,
      ],
    );
  }

  Widget _panel({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(_size(14, 11)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_size(19, 16)),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.transparentBlack08,
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildPendingCard() {
    return _panel(
      child: Column(
        children: [
          for (int i = 0; i < pendingActivities.length; i++) ...[
            _activityRow(
              icon: Icons.hourglass_top_rounded,
              iconColor: AppColors.warning,
              title: pendingActivities[i].Action,
              subtitle:
                  'Release date  ${pendingActivities[i].creditReleaseDate}',
              value: '${pendingActivities[i].Amount} pts',
              valueColor: AppColors.warning,
            ),
            if (i != pendingActivities.length - 1)
              Divider(height: 1, color: AppColors.border),
          ],
        ],
      ),
    );
  }

  Widget _buildCreditedCard() {
    return _panel(
      child: Column(
        children: [
          for (int i = 0; i < creditedActivities.length; i++) ...[
            _activityRow(
              icon: Icons.check_circle_rounded,
              iconColor: AppColors.success,
              title: creditedActivities[i].name,
              subtitle: creditedActivities[i].date,
              value: '+${creditedActivities[i].Amount} pts',
              valueColor: AppColors.success,
            ),
            if (i != creditedActivities.length - 1)
              Divider(height: 1, color: AppColors.border),
          ],
          SizedBox(height: _size(10, 8)),
          _moreButton(
            label: 'View credited activity',
            icon: Icons.arrow_forward_rounded,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => CreditedActivityscreen(
                        creditedActivities: creditedActivities,
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildClickedCard() {
    return _panel(
      child: Column(
        children: [
          for (int i = 0; i < clickedActivities.length; i++) ...[
            _activityRow(
              icon: Icons.local_offer_rounded,
              iconColor: AppColors.primary,
              title: clickedActivities[i].offerName,
              subtitle: clickedActivities[i].date,
              trailing: IconButton(
                onPressed: () {},
                splashRadius: 20,
                icon: Icon(
                  Icons.mail_outline_rounded,
                  color: AppColors.primary,
                  size: _size(20, 18),
                ),
                tooltip: 'Contact support',
              ),
            ),
            if (i != clickedActivities.length - 1)
              Divider(height: 1, color: AppColors.border),
          ],
          SizedBox(height: _size(10, 8)),
          _moreButton(
            label: 'View clicked activity',
            icon: Icons.arrow_forward_rounded,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => ClickedActivityScreen(
                        clickedActivities: clickedActivities,
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _activityRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? value,
    Color? valueColor,
    Widget? trailing,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _size(10, 8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: _size(42, 37),
            height: _size(42, 37),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.10),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: iconColor, size: _size(21, 18)),
          ),
          SizedBox(width: _size(11, 9)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: _size(13, 11),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: _size(10, 9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (value != null) ...[
            SizedBox(width: _size(8, 5)),
            Flexible(
              flex: 0,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: valueColor ?? AppColors.primaryStrong,
                  fontWeight: FontWeight.w900,
                  fontSize: _size(12, 10),
                ),
              ),
            ),
          ],
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _moreButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: _size(46, 42),
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: _size(17, 15)),
        label: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: _size(12, 10),
            fontWeight: FontWeight.w800,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary.withOpacity(0.65)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
    );
  }
}
