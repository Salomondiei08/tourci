
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tour_ci/providers/city_provider.dart';
import 'providers/place_provider.dart';
import 'theme/app_theme.dart';
import 'firebase_options.dart';
import 'helpers/routes.dart';
import 'screens/onboarding_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TourcIApp());
}

class TourcIApp extends StatelessWidget {
  const TourcIApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => PlaceProvider()),
            ChangeNotifierProvider(create: (_) => CityProvider()),
          ],
          builder: (context, child) {
            return MaterialApp(
              title: 'Tour CI',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              routes: AppRoute.routes,
              home: const OnboardingScreen(),
            );
          },
        );
      },
    );
  }
}
