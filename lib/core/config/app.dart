import 'package:credora/core/theme/app_theme.dart';
import 'package:credora/features/auth/presentation/views/login_signup_view.dart';
import 'package:flutter/material.dart';

class CredoraApp extends StatelessWidget {
  const CredoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'credora',
        theme: AppTheme.light,
        home: LogeinSignin(),
      ),
    );
  }
}
