import 'package:get/get.dart';
import 'package:job_portal/screens/onboarding/onboard_controller.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnboardingController());
  }
}