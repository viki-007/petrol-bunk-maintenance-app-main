import 'package:get/get.dart';
import '../main.dart';
import '../screens/authenticate/fingerprint/fingerprint_auth.dart';

class FingerprintController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fingerprintAuth();
  }
    fingerprintAuth()  async{
      final isAuthenticated = await LocalAuthApi.authenticate();
      if (isAuthenticated) {
        Get.offAll(()=>const Home());
      }else {
        // exit(0);
      }
    }
}