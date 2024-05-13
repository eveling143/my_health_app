import 'package:flutter/material.dart';
import 'package:my_health_app/src/feature/routes/my_health_app_roter.dart';
import 'package:my_health_app/src/feature/screens/widgets/age_screen.dart';
import 'package:my_health_app/src/feature/screens/widgets/bmi_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: MyHealthAppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
