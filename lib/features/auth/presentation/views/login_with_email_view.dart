import 'package:credora/features/offers/presentation/views/earn_view.dart';
import 'package:credora/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Loginwithemail extends StatefulWidget {
  const Loginwithemail({super.key});

  @override
  State<Loginwithemail> createState() => _LoginwithemailState();
}

class _LoginwithemailState extends State<Loginwithemail> {
  bool _obscureText = true;

  Widget field(
    String fieldName,
    String fieldContain, {
    required bool isPassword,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldName,
            style: TextStyle(
              fontSize: 14.spMin,
              fontWeight: FontWeight.w600,
              color: AppColors.text,
            ),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            obscureText: isPassword ? _obscureText : false,
            style: TextStyle(color: AppColors.text, fontSize: 15.spMin),
            decoration: InputDecoration(
              suffixIcon:
                  isPassword
                      ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: AppColors.textMuted,
                        ),
                      )
                      : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide(color: AppColors.border, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24.r),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
              hintText: fieldContain,
              hintStyle: TextStyle(
                color: AppColors.textMuted,
                fontSize: 14.spMin,
              ),
              filled: true,
              fillColor: AppColors.surfaceSoft,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.surface,
            centerTitle: true,
            title: Text(
              "LogIn With Email",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.text,
                fontSize: 18.spMin,
              ),
            ),
            iconTheme: IconThemeData(color: AppColors.text),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 460.w),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 24.h),
                children: [
                  field("Your Email", "Enter Your Email", isPassword: false),
                  SizedBox(height: 20.h),
                  field("Password", "Enter Your Password", isPassword: true),
                  SizedBox(height: 36.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Earn()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 4,
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shadowColor: AppColors.primary.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.spMin,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: Text(
                      "Some Informations",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                        fontSize: 13.spMin,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
