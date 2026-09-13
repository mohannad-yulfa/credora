import 'package:credora/core/utils/size_config.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class Crypto extends StatefulWidget {
  final Widget head;
  final Widget mybalance;

  const Crypto({super.key, required this.head, required this.mybalance});

  @override
  State<Crypto> createState() => _CryptoState();
}

class _CryptoState extends State<Crypto> {
  String? selectedCrypto;

  final List<String> options = ["BTC", "LTC", "DOGE", "SHIB"];

  final TextEditingController pointsController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    pointsController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // RESPONSIVE VALUES
  // ------------------------------------------------------------
  //
  // الشاشة العادية:
  // الأحجام ثابتة ولا تكبر مع حجم الجهاز.
  //
  // الشاشة الصغيرة جدًا:
  // نقلل بعض الأحجام والمسافات فقط حتى لا تصبح الواجهة مزدحمة.
  //

  double get screenWidth => MediaQuery.of(context).size.width;

  bool get isSmallScreen => screenWidth < 360;

  double size(double normal, double small) {
    return isSmallScreen ? small : normal;
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return ListView(
      padding: EdgeInsets.only(
        left: size(18, 14),
        right: size(18, 14),
        bottom: 40,
      ),
      children: [
        widget.head,

        SizedBox(height: size(22, 16)),

        // --------------------------------------------------------
        // HEADER
        // --------------------------------------------------------
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size(48, 43),
              height: size(48, 43),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.currency_bitcoin_rounded,
                color: AppColors.onPrimary,
                size: size(27, 24),
              ),
            ),

            SizedBox(width: size(13, 10)),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Withdraw Crypto",
                    style: TextStyle(
                      fontSize: size(23, 20),
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: size(3, 2)),

                  Text(
                    "Send your balance to BitPay",
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: size(12, 11),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: size(22, 17)),

        // --------------------------------------------------------
        // BALANCE
        // --------------------------------------------------------
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

        // --------------------------------------------------------
        // CRYPTO SELECTION TITLE
        // --------------------------------------------------------
        Text(
          "Choose cryptocurrency",
          style: TextStyle(fontSize: size(13, 12), fontWeight: FontWeight.w700),
        ),

        SizedBox(height: size(10, 8)),

        // --------------------------------------------------------
        // CRYPTO OPTIONS
        // --------------------------------------------------------
        SizedBox(
          height: size(68, 62),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            separatorBuilder: (_, __) {
              return SizedBox(width: size(10, 7));
            },
            itemBuilder: (context, index) {
              final crypto = options[index];
              final isSelected = selectedCrypto == crypto;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCrypto = crypto;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: size(85, 76),
                  padding: EdgeInsets.symmetric(horizontal: size(10, 7)),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surface,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size(27, 24),
                        height: size(27, 24),
                        decoration: BoxDecoration(
                          color:
                              isSelected
                                  ? AppColors.onPrimary.withOpacity(0.15)
                                  : AppColors.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            crypto.substring(0, 1),
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? AppColors.onPrimary
                                      : AppColors.primary,
                              fontWeight: FontWeight.w900,
                              fontSize: size(12, 10),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: size(4, 3)),

                      Text(
                        crypto,
                        style: TextStyle(
                          color: isSelected ? AppColors.onPrimary : null,
                          fontSize: size(11, 10),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: size(25, 19)),

        // --------------------------------------------------------
        // WITHDRAWAL AMOUNT
        // --------------------------------------------------------
        Text(
          "Withdrawal amount",
          style: TextStyle(fontSize: size(13, 12), fontWeight: FontWeight.w700),
        ),

        SizedBox(height: size(10, 8)),

        Container(
          padding: EdgeInsets.all(size(16, 13)),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: pointsController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      style: TextStyle(
                        fontSize: size(22, 19),
                        fontWeight: FontWeight.w800,
                      ),
                      decoration: InputDecoration(
                        hintText: "0.00",
                        hintStyle: TextStyle(
                          color: AppColors.textMuted.withOpacity(0.5),
                          fontSize: size(22, 19),
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size(12, 9),
                      vertical: size(8, 6),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.inputGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "POINTS",
                      style: TextStyle(
                        fontSize: size(10, 9),
                        fontWeight: FontWeight.w800,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size(10, 7)),

              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: size(14, 12),
                    color: AppColors.textMuted,
                  ),

                  SizedBox(width: size(5, 4)),

                  Expanded(
                    child: Text(
                      "A 1% withdrawal fee will be deducted.",
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: size(10, 9),
                      ),
                    ),
                  ),

                  Text(
                    "1% fee",
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: size(11, 10),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: size(23, 18)),

        // --------------------------------------------------------
        // BITPAY ACCOUNT
        // --------------------------------------------------------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "BitPay account",
              style: TextStyle(
                fontSize: size(13, 12),
                fontWeight: FontWeight.w700,
              ),
            ),

            Text(
              "Required",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: size(10, 9),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        SizedBox(height: size(10, 8)),

        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: AppColors.border),
          ),
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontSize: size(14, 12),
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: "Enter your BitPay email",
              hintStyle: TextStyle(
                color: AppColors.textMuted,
                fontSize: size(13, 11),
              ),
              prefixIcon: Icon(
                Icons.alternate_email_rounded,
                color: AppColors.textMuted,
                size: size(20, 18),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: size(15, 12),
                vertical: size(17, 14),
              ),
            ),
          ),
        ),

        SizedBox(height: size(8, 6)),

        Text(
          "The currency you receive is determined by your BitPay account.",
          style: TextStyle(color: AppColors.textMuted, fontSize: size(10, 9)),
        ),

        SizedBox(height: size(25, 19)),

        // --------------------------------------------------------
        // SUMMARY
        // --------------------------------------------------------
        Container(
          padding: EdgeInsets.all(size(18, 14)),
          decoration: BoxDecoration(
            color: AppColors.surfaceElevated,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Withdrawal summary",
                    style: TextStyle(
                      fontSize: size(14, 12),
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const Spacer(),

                  Icon(
                    Icons.receipt_long_outlined,
                    size: size(18, 16),
                    color: AppColors.textMuted,
                  ),
                ],
              ),

              SizedBox(height: size(18, 14)),

              _summaryRow(
                title: "Requested",
                value:
                    pointsController.text.isEmpty
                        ? "0.00"
                        : pointsController.text,
              ),

              SizedBox(height: size(12, 9)),

              _summaryRow(
                title: "Withdrawal fee",
                value: "1%",
                valueColor: AppColors.green,
              ),

              SizedBox(height: size(14, 11)),

              Divider(color: AppColors.border, height: 1),

              SizedBox(height: size(14, 11)),

              Row(
                children: [
                  Text(
                    "You will receive",
                    style: TextStyle(
                      fontSize: size(13, 11),
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const Spacer(),

                  Text(
                    "0.00000000",
                    style: TextStyle(
                      color: AppColors.success,
                      fontSize: size(18, 16),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              SizedBox(height: size(5, 4)),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  selectedCrypto ?? "Select currency",
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: size(10, 9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: size(24, 19)),

        // --------------------------------------------------------
        // CONFIRM BUTTON
        // --------------------------------------------------------
        SizedBox(
          height: size(56, 51),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.success,
              foregroundColor: AppColors.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline_rounded, size: size(19, 17)),

                SizedBox(width: size(8, 6)),

                Text(
                  "CONFIRM WITHDRAWAL",
                  style: TextStyle(
                    fontSize: size(13, 11),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: size(12, 9)),

        // --------------------------------------------------------
        // MANAGE EMAIL
        // --------------------------------------------------------
        TextButton.icon(
          onPressed: () {},
          icon: Icon(
            Icons.settings_outlined,
            color: AppColors.primary,
            size: size(17, 15),
          ),
          label: Text(
            "Manage BitPay emails",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: size(12, 10),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        SizedBox(height: size(20, 15)),

        // --------------------------------------------------------
        // SECURITY INFORMATION
        // --------------------------------------------------------
        Container(
          padding: EdgeInsets.all(size(15, 12)),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.06),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary.withOpacity(0.15)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.shield_outlined,
                color: AppColors.primary,
                size: size(20, 18),
              ),

              SizedBox(width: size(10, 7)),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Withdrawal information",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: size(12, 10),
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    SizedBox(height: size(4, 3)),

                    Text(
                      "Make sure your BitPay email is correct before confirming the withdrawal.",
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: size(10, 9),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: size(22, 17)),

        // --------------------------------------------------------
        // HELP
        // --------------------------------------------------------
        Center(
          child: TextButton(
            onPressed: () {},
            child: Text(
              "Need help?",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: size(12, 10),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // SUMMARY ROW
  // ------------------------------------------------------------

  Widget _summaryRow({
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.textMuted,
            fontSize: size(11, 10),
            fontWeight: FontWeight.w600,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: size(12, 10),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
