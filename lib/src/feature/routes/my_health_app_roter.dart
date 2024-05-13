import 'package:go_router/go_router.dart';
import 'package:my_health_app/src/feature/screens/widgets/age_screen.dart';
import 'package:my_health_app/src/feature/screens/widgets/bmi_screen.dart';
import 'package:my_health_app/src/feature/screens/widgets/home_screen.dart';
import 'package:my_health_app/src/feature/screens/widgets/zodiac_screen.dart';

class MyHealthAppRouter{
  static GoRouter router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => HomeScreen()),
    GoRoute(path: '/bmi', builder: (context, state) => BmiScreen()),
    GoRoute(path: '/age', builder: (context, state) => AgeScreen()),
    GoRoute(path: '/zodiac', builder: (context, state) => ZodiacScreen()),

  ]);
}