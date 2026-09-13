import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Giveaway extends StatefulWidget {
  final String status;
  final String name;
  final int numberOfpoints;
  final String typeGiveaway;
  final String TimePeriod;
  final String ViewButton;

  const Giveaway({
    super.key,
    this.status = "",
    this.TimePeriod = "0",
    required this.typeGiveaway,
    required this.name,
    required this.numberOfpoints,
    required this.ViewButton,
  });

  @override
  State<Giveaway> createState() => _GiveawayState();
}

class _GiveawayState extends State<Giveaway>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool _pressed = false;

  final String imageUrl =
      "https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?q=80&w=500&auto=format&fit=crop";

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
      duration: const Duration(milliseconds: 650),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(const Duration(milliseconds: 60), () {
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
        child:
            widget.typeGiveaway == "special"
                ? _buildSpecialGiveaway()
                : _buildNormalGiveaway(),
      ),
    );
  }

  // ===============================================================
  // NORMAL GIVEAWAY
  // ===============================================================
  Widget _buildNormalGiveaway() {
    return Center(
      child: Container(
        width: _size(340, 305),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(_size(25, 20)),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.055),
              blurRadius: 20,
              offset: const Offset(0, 9),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildImageSection(showStatus: false),

            Padding(
              padding: EdgeInsets.fromLTRB(
                _size(18, 14),
                _size(18, 14),
                _size(18, 14),
                _size(18, 14),
              ),
              child: Column(
                children: [
                  _buildTitle(),

                  SizedBox(height: _size(13, 9)),

                  _buildWinnerInfo(),

                  SizedBox(height: _size(13, 9)),

                  _buildPrize(),

                  SizedBox(height: _size(17, 12)),

                  _buildActionButton(backgroundColor: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // SPECIAL GIVEAWAY
  // ===============================================================
  Widget _buildSpecialGiveaway() {
    return Center(
      child: Container(
        width: _size(340, 305),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(_size(25, 20)),
          border: Border.all(color: AppColors.primary.withOpacity(0.25)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.10),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildImageSection(showStatus: true),

            Padding(
              padding: EdgeInsets.fromLTRB(
                _size(18, 14),
                _size(15, 12),
                _size(18, 14),
                _size(18, 14),
              ),
              child: Column(
                children: [
                  _buildTitle(),

                  SizedBox(height: _size(12, 8)),

                  _buildWinnerInfo(),

                  SizedBox(height: _size(11, 8)),

                  _buildTime(),

                  SizedBox(height: _size(11, 8)),

                  _buildPrize(),

                  SizedBox(height: _size(17, 12)),

                  _buildActionButton(backgroundColor: AppColors.primaryStrong),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // IMAGE SECTION
  // ===============================================================
  Widget _buildImageSection({required bool showStatus}) {
    return Hero(
      tag: "giveaway_${widget.name}",
      child: Container(
        width: double.infinity,
        height: _size(165, 135),
        decoration: BoxDecoration(
          color: AppColors.grey300,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Dark gradient
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.08),
                      Colors.black.withOpacity(0.62),
                    ],
                  ),
                ),
              ),
            ),

            // Top category
            Positioned(
              left: _size(14, 10),
              top: _size(14, 10),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: _size(10, 8),
                  vertical: _size(6, 4),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.card_giftcard_rounded,
                      color: AppColors.giftAccent,
                      size: _size(14, 11),
                    ),
                    SizedBox(width: _size(5, 3)),
                    Text(
                      "GIVEAWAY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _size(9, 7),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Status
            if (showStatus && widget.status.isNotEmpty)
              Positioned(
                right: _size(14, 10),
                top: _size(14, 10),
                child: _buildStatusBadge(),
              ),

            // Bottom reward
            Positioned(
              left: _size(15, 11),
              right: _size(15, 11),
              bottom: _size(13, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "WIN UP TO",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.70),
                            fontSize: _size(9, 7),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.7,
                          ),
                        ),
                        SizedBox(height: _size(2, 1)),
                        Text(
                          "${widget.numberOfpoints} POINTS",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: _size(18, 14),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: _size(9, 7),
                      vertical: _size(6, 4),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.giftAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.stars_rounded,
                      color: AppColors.darkTeal,
                      size: _size(18, 15),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // STATUS BADGE
  // ===============================================================
  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _size(9, 7),
        vertical: _size(6, 4),
      ),
      decoration: BoxDecoration(
        color: AppColors.danger,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: AppColors.danger.withOpacity(0.25), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: _size(6, 5),
            height: _size(6, 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: _size(5, 3)),
          Text(
            widget.status.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: _size(9, 7),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // TITLE
  // ===============================================================
  Widget _buildTitle() {
    return Text(
      widget.name,
      textAlign: TextAlign.center,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.text,
        fontSize: _size(18, 15),
        fontWeight: FontWeight.w900,
        height: 1.15,
      ),
    );
  }

  // ===============================================================
  // WINNER INFO
  // ===============================================================
  Widget _buildWinnerInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: _size(32, 27),
          height: _size(32, 27),
          decoration: BoxDecoration(
            color: AppColors.warning.withOpacity(0.10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.emoji_events_rounded,
            color: AppColors.warning,
            size: _size(18, 15),
          ),
        ),

        SizedBox(width: _size(9, 6)),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Winner",
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: _size(10, 8),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "1 lucky winner",
              style: TextStyle(
                color: AppColors.text,
                fontSize: _size(12, 10),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===============================================================
  // TIME
  // ===============================================================
  Widget _buildTime() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: _size(12, 9),
        vertical: _size(9, 7),
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(_size(13, 10)),
      ),
      child: Row(
        children: [
          Container(
            width: _size(31, 26),
            height: _size(31, 26),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.schedule_rounded,
              color: AppColors.primary,
              size: _size(17, 14),
            ),
          ),

          SizedBox(width: _size(8, 6)),

          Text(
            "Ends",
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: _size(10, 8),
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(width: _size(5, 4)),

          Expanded(
            child: Text(
              widget.TimePeriod,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: AppColors.text,
                fontSize: _size(12, 10),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // PRIZE
  // ===============================================================
  Widget _buildPrize() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(_size(12, 9)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.08),
            AppColors.giftAccent.withOpacity(0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(_size(15, 12)),
        border: Border.all(color: AppColors.primary.withOpacity(0.13)),
      ),
      child: Row(
        children: [
          Container(
            width: _size(40, 33),
            height: _size(40, 33),
            decoration: BoxDecoration(
              color: AppColors.giftAccent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(_size(12, 9)),
            ),
            child: Icon(
              Icons.stars_rounded,
              color: AppColors.warning,
              size: _size(22, 18),
            ),
          ),

          SizedBox(width: _size(10, 7)),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Reward",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: _size(9, 7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: _size(2, 1)),
                Text(
                  "${widget.numberOfpoints} Reward Points",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: _size(13, 10),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textMuted,
            size: _size(14, 11),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // ACTION BUTTON
  // ===============================================================
  Widget _buildActionButton({required Color backgroundColor}) {
    return GestureDetector(
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

        debugPrint('Giveaway button pressed: ${widget.name}');
      },
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          height: _size(50, 44),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(_size(16, 13)),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.20),
                blurRadius: _pressed ? 5 : 12,
                offset: Offset(0, _pressed ? 2 : 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  widget.ViewButton,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.onPrimary,
                    fontSize: _size(13, 10),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              SizedBox(width: _size(8, 5)),
              Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.onPrimary,
                size: _size(19, 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
