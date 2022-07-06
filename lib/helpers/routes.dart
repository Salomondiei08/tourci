import 'package:flutter/material.dart';
import '../screens/camera_screen.dart';
import '../screens/city_info_screen.dart';
import '../screens/city_list_screen.dart';
import '../screens/login_screen.dart';

import '../screens/onboarding_screen.dart';
import '../screens/place_info_screen.dart';
import '../screens/sign_up_screen.dart';

class AppRoute {
  static const String home = '/home';
  static const String loginScreen = '/login_screen';
  static const String signInScreen = '/sign_in_screen';
  static const String signUpScreen = '/sign_up_screen';
  static const String resetScreen = '/reset_screen';
  static const String overviewScreen = '/overview_screen';
  static const String onBoardingScreen = '/onboarding_screen';
  static const String placeInfoScreen = '/place_info_screen';
  static const String cityInfoScreen = '/city_info_screen';
  static const String cameraScreen = '/cameraScreen';
  static const String cityListScreen = '/city_list_screen';

  static const String aboutScreen = '/about_screen';

  static const String profileScreen = '/profile_screen';

  static Map<String, Widget Function(BuildContext)> routes = {
    signUpScreen: (BuildContext context) => const SignUpScreen(),
    onBoardingScreen: (BuildContext context) => const OnboardingScreen(),
    placeInfoScreen: (BuildContext context) => const PageInfoScreen(),
    cameraScreen: (BuildContext context) => const CameraScreen(),
    cityListScreen: (BuildContext context) => const CityListScreen(),
    cityInfoScreen: (BuildContext context) => const CityInfoScreen(),
    
  };
}
