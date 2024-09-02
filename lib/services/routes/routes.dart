import 'package:get/get_navigation/get_navigation.dart';
import 'package:job_portal/screens/dashboard/home_screen.dart';
import 'package:job_portal/screens/onboarding/login.dart';
import 'package:job_portal/screens/onboarding/signin.dart';
import 'package:job_portal/screens/splash/splash_screen.dart';
import 'package:job_portal/services/bindings/home_screen_binding.dart';
import 'package:job_portal/services/bindings/onboard_binding.dart';

List<GetPage> getRoutes = [
  GetPage(name: "/", page:()=> SplashScreen()),
  GetPage(
      name: '/HomeScreen',
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),
  GetPage(
      name: '/LoginScreen',
      page: () => const LoginScreen(),
      binding: OnboardingBinding(),
    ),
  GetPage(
      name: '/SigninScreen',
      page: () => const SigninScreen(),
      binding: OnboardingBinding(),
    ),


];