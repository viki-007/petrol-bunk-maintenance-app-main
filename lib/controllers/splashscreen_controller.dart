import 'package:get/get.dart';
import '../main.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
        const Duration(seconds: 0), () => {Get.offAll(()=> const Home())});
    super.onInit();
  }
}