import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Paypal extends StatefulWidget {
  final Widget head;
  final Widget mybalance;

  const Paypal({super.key, required this.head, required this.mybalance});

  @override
  State<Paypal> createState() => _PaypalState();
}

class _PaypalState extends State<Paypal> {
  double get screenWidth => MediaQuery.of(context).size.width;

  bool get isSmallScreen => screenWidth < 360;

  double size(double normal, double small) {
    return isSmallScreen ? small : normal;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: size(18, 13),
        vertical: size(10, 8),
      ),
      children: [
        widget.head,

        SizedBox(height: size(24, 18)),

        // ------------------------------------------------------------
        // PAYPAL HEADER
        // ------------------------------------------------------------
        Row(
          children: [
            Container(
              width: size(52, 44),
              height: size(52, 44),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.10),
                borderRadius: BorderRadius.circular(size(16, 13)),
              ),
              child: Center(
                child: Image.asset(
                  'lib/images/paypal.png',
                  width: size(30, 25),
                  height: size(30, 25),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(width: size(13, 10)),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PayPal',
                    style: TextStyle(
                      fontSize: size(21, 18),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: size(3, 2)),
                  Text(
                    'Withdraw your points securely',
                    style: TextStyle(
                      fontSize: size(12, 10),
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: size(22, 17)),

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

        SizedBox(height: size(24, 18)),

        // ------------------------------------------------------------
        // WITHDRAWAL FORM
        // ------------------------------------------------------------
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            size(18, 14),
            size(18, 14),
            size(18, 14),
            size(16, 13),
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(size(20, 16)),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------------------------------------------------
              // FORM TITLE
              // ------------------------------------------------------
              Text(
                'Withdrawal details',
                style: TextStyle(
                  fontSize: size(17, 15),
                  fontWeight: FontWeight.w900,
                ),
              ),

              SizedBox(height: size(5, 3)),

              Text(
                'Enter the amount and PayPal account you want to use.',
                style: TextStyle(
                  fontSize: size(11, 9),
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: size(20, 15)),

              // ------------------------------------------------------
              // AMOUNT LABEL
              // ------------------------------------------------------
              Text(
                'Amount',
                style: TextStyle(
                  fontSize: size(12, 10),
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: size(8, 6)),

              // ------------------------------------------------------
              // AMOUNT INPUT
              // ------------------------------------------------------
              Container(
                height: size(58, 50),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(size(14, 12)),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    SizedBox(width: size(14, 10)),

                    Container(
                      width: size(34, 30),
                      height: size(34, 30),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.10),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.toll_rounded,
                        size: size(18, 15),
                        color: AppColors.primary,
                      ),
                    ),

                    SizedBox(width: size(10, 8)),

                    Expanded(
                      child: TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        style: TextStyle(
                          fontSize: size(15, 13),
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter points',
                          hintStyle: TextStyle(
                            fontSize: size(13, 11),
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.all(13),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: size(14, 10)),
                      child: Text(
                        '  PTS',
                        style: TextStyle(
                          fontSize: size(11, 9),
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size(18, 14)),

              // ------------------------------------------------------
              // PAYPAL EMAIL LABEL
              // ------------------------------------------------------
              Text(
                'PayPal account',
                style: TextStyle(
                  fontSize: size(12, 10),
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: size(8, 6)),

              // ------------------------------------------------------
              // EMAIL INPUT
              // ------------------------------------------------------
              Container(
                height: size(58, 50),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(size(14, 12)),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    SizedBox(width: size(14, 10)),

                    Icon(
                      Icons.alternate_email_rounded,
                      size: size(20, 17),
                      color: AppColors.primary,
                    ),

                    SizedBox(width: size(10, 8)),

                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: size(14, 12),
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          hintText: 'PayPal email address',
                          hintStyle: TextStyle(
                            fontSize: size(13, 11),
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.all(13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size(10, 8)),

              // ------------------------------------------------------
              // MANAGE EMAIL
              // ------------------------------------------------------
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: size(4, 2),
                      vertical: size(4, 2),
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Manage PayPal emails',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: size(11, 9),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size(14, 10)),

              // ------------------------------------------------------
              // CONVERSION INFO
              // ------------------------------------------------------
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: size(14, 10),
                  vertical: size(12, 9),
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(size(12, 10)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.currency_exchange_rounded,
                      color: AppColors.primary,
                      size: size(18, 15),
                    ),

                    SizedBox(width: size(10, 8)),

                    Expanded(
                      child: Text(
                        'Your points will be converted to USD before the payout.',
                        style: TextStyle(
                          fontSize: size(11, 9),
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w600,
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size(14, 12)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue to withdrawal',
                        style: TextStyle(
                          color: AppColors.onPrimary,
                          fontSize: size(13, 11),
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      SizedBox(width: size(8, 6)),

                      Icon(
                        Icons.arrow_forward_rounded,
                        size: size(18, 15),
                        color: AppColors.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: size(20, 15)),

        // ------------------------------------------------------------
        // SECURITY NOTE
        // ------------------------------------------------------------
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.verified_user_outlined,
              size: size(18, 15),
              color: AppColors.primary,
            ),

            SizedBox(width: size(9, 7)),

            Expanded(
              child: Text(
                'Make sure your PayPal email is correct. '
                'Withdrawals sent to an incorrect account may not be recoverable.',
                style: TextStyle(
                  fontSize: size(11, 9),
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: size(22, 16)),

        // ------------------------------------------------------------
        // HELP
        // ------------------------------------------------------------
        Center(
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.help_outline_rounded,
              size: size(17, 14),
              color: AppColors.primary,
            ),
            label: Text(
              'Need help?',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: size(12, 10),
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),

        SizedBox(height: size(10, 7)),

        Center(
          child: Text(
            'Secure payout powered by Credora',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMuted,
              fontWeight: FontWeight.w700,
              fontSize: size(11, 9),
            ),
          ),
        ),

        SizedBox(height: size(35, 25)),
      ],
    );
  }
}
