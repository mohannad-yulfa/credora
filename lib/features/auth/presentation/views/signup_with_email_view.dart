import 'package:credora/core/theme/app_theme.dart';
import 'package:credora/features/auth/presentation/views/login_with_email_view.dart';
import 'package:credora/features/offers/presentation/views/earn_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signupwithemail extends StatefulWidget {
  const Signupwithemail({super.key});

  @override
  State<Signupwithemail> createState() => _SignupwithemailState();
}

class _SignupwithemailState extends State<Signupwithemail> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _obscureText = true;

  Widget _buildField(
    String fieldName,
    String fieldContent, {
    required bool isPassword,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldName,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextFormField(
            obscureText: isPassword ? _obscureText : false,
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
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(26),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
              hintText: fieldContent,
              hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
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
            iconTheme: IconThemeData(color: AppColors.text),
            title: const Text(
              "Sign Up with Email",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                children: [
                  _buildField(
                    "User Name",
                    "Enter user name",
                    isPassword: false,
                  ),
                  const SizedBox(height: 20),
                  _buildField(
                    "Your Email",
                    "Enter your email",
                    isPassword: false,
                  ),
                  const SizedBox(height: 20),
                  _buildField(
                    "Password",
                    "Enter your password",
                    isPassword: true,
                  ),
                  const SizedBox(height: 12),
                  CheckboxListTile(
                    title: const Text('I agree to receive promotional updates'),
                    value: _isChecked1,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isChecked1 = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  CheckboxListTile(
                    title: const Text('I accept the terms and conditions'),
                    value: _isChecked2,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _isChecked2 = newValue!;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Earn()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        "Click To Verify",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loginwithemail(),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.border),
                        elevation: 0,
                        backgroundColor: AppColors.surface,
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
