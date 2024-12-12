// import 'package:get/get.dart';
// import '../database/mongo.dart';
// import '../view/login_screen.dart';
// import '../view/main_screen.dart';
// import 'login_controller.dart';

// class SplashController extends GetxController {
//   LoginController loginController = Get.put(LoginController());

//   RxDouble opacity = RxDouble(0.0);

//   @override
//   onInit(){
//     super.onInit();
//     animateLogo();
//   }

//   animateLogo() async {
//     await Future.delayed(Duration.zero);
//     opacity.value=1;
//     Future.delayed(const Duration(seconds: 5));
//     await MongoDB.getBanners();
//     await MongoDB.getTags();
//     loginController.isLoggedIn.value
//         ? Get.offAll(() => MainScreen())
//         : Get.offAll(() => LoginScreen());
    
//   }
// }

import 'package:get/get.dart';
import 'package:whitesupermarketapp/database/global.dart';
import '../database/mongo.dart';
import '../view/login_screen.dart';
import '../view/main_screen.dart';
import 'login_controller.dart';

class SplashController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  RxDouble opacity = RxDouble(0.0);

  @override
  void onInit() {
    super.onInit();
    animateLogoAndInitializeApp();
  }

  Future<void> animateLogoAndInitializeApp() async {
    // Animate the logo
    await Future.delayed(Duration.zero);
    opacity.value = 1.0;

    // Show animation for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    try {
      // Connect to MongoDB
      Map<String, dynamic>? dbAndCollection = await MongoDB.connect();
      if (dbAndCollection == null) {
        print('Failed to connect to MongoDB');
        return; // Optionally handle failure silently
      }

      // Assign database and collections
      db = dbAndCollection['db'];
      collection_items = dbAndCollection['collection_items'];
      collection_banners = dbAndCollection['collection_banners'];

      // Load additional data
      await MongoDB.getBanners();
      await MongoDB.getTags();

      // Navigate to appropriate screen
      final bool isLoggedIn = loginController.isLoggedIn.value;
      Get.offAll(() => isLoggedIn ? MainScreen() : LoginScreen());
    } catch (e) {
      print('Error during initialization: $e');
    }
  }
}
