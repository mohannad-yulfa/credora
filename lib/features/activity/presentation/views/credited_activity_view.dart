import 'package:credora/features/activity/domain/entities/activity_entities.dart';
import 'package:credora/core/presentation/widgets/base_screen.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CreditedActivityscreen extends StatefulWidget {
  final List<CerditedActivity> creditedActivities;

  const CreditedActivityscreen({super.key, required this.creditedActivities});

  @override
  State<CreditedActivityscreen> createState() => _CreditedActivityscreenState();
}

class _CreditedActivityscreenState extends State<CreditedActivityscreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

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
      duration: const Duration(milliseconds: 700),
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
          _size(45, 30),
        ),
        children: [
          _buildHeader(),
          SizedBox(height: _size(18, 14)),
          _buildOverviewCard(),
          SizedBox(height: _size(20, 16)),
          _buildTitle(),
          SizedBox(height: _size(10, 8)),
          _buildActivities(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final animation = CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeOutCubic,
        );

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.08),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Row(
        children: [
          _buildBackButton(),
          SizedBox(width: _size(12, 9)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Credited activity',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: _size(23, 20),
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'All points that have been credited to you',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: _size(11, 9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: _size(46, 41),
        height: _size(46, 41),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: AppColors.text,
          size: _size(21, 18),
        ),
      ),
    );
  }

  Widget _buildOverviewCard() {
    final total = widget.creditedActivities.fold<double>(
      0,
      (sum, item) => sum + (double.tryParse(item.Amount) ?? 0),
    );

    return Container(
      padding: EdgeInsets.all(_size(17, 13)),
      decoration: BoxDecoration(
        color: AppColors.darkTeal,
        borderRadius: BorderRadius.circular(_size(20, 17)),
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
            width: _size(50, 44),
            height: _size(50, 44),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.13),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.success,
              size: _size(26, 22),
            ),
          ),
          SizedBox(width: _size(12, 9)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Credited points',
                  style: TextStyle(
                    color: AppColors.onPrimary.withOpacity(0.70),
                    fontSize: _size(11, 9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '+${total.toStringAsFixed(0)} pts',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: _size(22, 19),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: _size(10, 8),
              vertical: _size(7, 5),
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '${widget.creditedActivities.length} entries',
              style: TextStyle(
                color: AppColors.success,
                fontSize: _size(10, 8),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Container(
          width: _size(8, 7),
          height: _size(8, 7),
          decoration: const BoxDecoration(
            color: AppColors.success,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: _size(8, 6)),
        Expanded(
          child: Text(
            'Credit history',
            style: TextStyle(
              fontSize: _size(17, 15),
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        Text(
          'LATEST',
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: _size(9, 8),
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _buildActivities() {
    if (widget.creditedActivities.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: List.generate(widget.creditedActivities.length, (index) {
        return _AnimatedCreditCard(
          index: index,
          animationController: _animationController,
          child: _buildActivityCard(widget.creditedActivities[index], index),
        );
      }),
    );
  }

  Widget _buildActivityCard(CerditedActivity activity, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: _size(11, 9)),
      padding: EdgeInsets.all(_size(14, 11)),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(_size(18, 15)),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.transparentBlack08,
            blurRadius: 11,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: _size(46, 40),
            height: _size(46, 40),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.check_rounded,
              color: AppColors.success,
              size: _size(24, 21),
            ),
          ),
          SizedBox(width: _size(12, 9)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: _size(13, 11),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      color: AppColors.textMuted,
                      size: _size(12, 10),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        activity.date,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.textMuted,
                          fontSize: _size(10, 9),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: _size(8, 5)),
          Text(
            '+${activity.Amount}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColors.success,
              fontSize: _size(15, 12),
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(width: _size(3, 2)),
          Text(
            'pts',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: _size(9, 8),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: _size(45, 35),
        horizontal: _size(20, 15),
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            color: AppColors.textMuted,
            size: _size(45, 38),
          ),
          const SizedBox(height: 12),
          Text(
            'No credited activity',
            style: TextStyle(
              fontSize: _size(16, 14),
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Your credited points will appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: _size(11, 9),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedCreditCard extends StatelessWidget {
  final int index;
  final AnimationController animationController;
  final Widget child;

  const _AnimatedCreditCard({
    required this.index,
    required this.animationController,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final start = (index * 0.12).clamp(0.0, 0.65);
    final end = (start + 0.35).clamp(0.0, 1.0);

    final animation = CurvedAnimation(
      parent: animationController,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.08),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
