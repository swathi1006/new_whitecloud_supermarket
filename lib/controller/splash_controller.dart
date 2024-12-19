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

//test:
// import 'package:get/get.dart';
// import 'package:whitesupermarketapp/database/global.dart';
// import '../database/mongo.dart';
// import '../view/login_screen.dart';
// import '../view/main_screen.dart';
// import 'login_controller.dart';

// class SplashController extends GetxController {
//   final LoginController loginController = Get.put(LoginController());
//   RxDouble opacity = RxDouble(0.0);

//   @override
//   void onInit() {
//     super.onInit();
//     animateLogoAndInitializeApp();
//   }

//   Future<void> animateLogoAndInitializeApp() async {
//     // Animate the logo
//     await Future.delayed(Duration.zero);
//     opacity.value = 1.0;

//     // Show animation for 3 seconds
//     await Future.delayed(const Duration(seconds: 3));

//     try {
//       // Connect to MongoDB
//       Map<String, dynamic>? dbAndCollection = await MongoDB.connect();
//       if (dbAndCollection == null) {
//         print('Failed to connect to MongoDB');
//         return; // Optionally handle failure silently
//       }

//       // Assign database and collections
//       db = dbAndCollection['db'];
//       collection_items = dbAndCollection['collection_items'];
//       collection_banners = dbAndCollection['collection_banners'];

//       // Load additional data
//       await MongoDB.getBanners();
//       await MongoDB.getTags();

//       // Navigate to appropriate screen
//       final bool isLoggedIn = loginController.isLoggedIn.value;
//       Get.offAll(() => isLoggedIn ? MainScreen() : LoginScreen());
//     } catch (e) {
//       print('Error during initialization: $e');
//     }
//   }
// } 



//just before

// import 'package:get/get.dart';
// import 'package:whitesupermarketapp/database/global.dart';
// import 'package:whitesupermarketapp/widgets/fallback_ui.dart';
// import '../database/mongo.dart';
// import '../view/login_screen.dart';
// import '../view/main_screen.dart';
// import 'login_controller.dart';

// class SplashController extends GetxController {
//   late LoginController loginController =
//       Get.put(LoginController(), tag: 'loginController'); // Add a unique tag
//   // final LoginController loginController = Get.put(LoginController());
//   RxDouble opacity = RxDouble(0.0);

//   @override
//   void onInit() {
//     super.onInit();

//     // // Delete the previous instance of LoginController (if it exists)
//     // if (Get.isRegistered<LoginController>(tag: 'loginController')) {
//     //   Get.delete<LoginController>(tag: 'loginController');
//     // }

//     // // Create a new instance of LoginController
//     // loginController = Get.put(LoginController(), tag: 'loginController');

//     animateLogoAndInitializeApp();
//   }

//   Future<void> animateLogoAndInitializeApp() async {
//     // Animate the logo
//     await Future.delayed(Duration.zero);
//     opacity.value = 1.0;

//     // Show animation for 3 seconds
//     await Future.delayed(const Duration(seconds: 3));

//     // try {
//     //   // Connect to MongoDB
//     //   Map<String, dynamic>? dbAndCollection = await MongoDB.connect();
//     //   if (dbAndCollection == null) {
//     //     print('Failed to connect to MongoDB');
//     //     return; // Optionally handle failure silently
//     //   }

//     //   // Assign database and collections 
//     //   db = dbAndCollection['db'];
//     //   collection_items = dbAndCollection['collection_items'];
//     //   collection_banners = dbAndCollection['collection_banners'];

//     //   // Load additional data
//     //   await MongoDB.getBanners();
//     //   await MongoDB.getTags();

//     //   // Navigate to appropriate screen
//     //   final bool isLoggedIn = loginController.isLoggedIn.value;
//     //   Get.offAll(() => isLoggedIn ? MainScreen() : LoginScreen());
//     // } catch (e) {
//     //   print('Error during initialization: $e');
//     // }
//     try {
//       // Connect to MongoDB
//       Map<String, dynamic>? dbAndCollection = await MongoDB.connect();
//       if (dbAndCollection == null) {
//         print('Failed to connect to MongoDB');
//         return; // Stop further execution
//       }

//       db = dbAndCollection['db'];
//       collection_users = dbAndCollection['collection_users']; // Ensure this is initialized

//       // // Ensure LoginController completes initialization
//       // await loginController.onInit();
//       // Ensure LoginController completes initialization
//       await loginController.initializeLogin();

//       // print('LoginController initialization completed');

//            // Load additional data
//       await MongoDB.getBanners();
//       await MongoDB.getTags();


// // Navigate to the appropriate screen
//       final bool isLoggedIn = loginController.isLoggedIn.value;
//       Get.offAll(() => isLoggedIn ? MainScreen() : LoginScreen());

//       print('MongoDB connected successfully');
//     } catch (e) {
//       print('Error during MongoDB connection: $e');
//        Get.offAll(() => OfflineFallbackScreen());
//     }
//   }
// }


//testing one below:
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:whitesupermarketapp/controller/login_controller.dart';
// import 'package:whitesupermarketapp/database/mongo.dart';
// import 'package:whitesupermarketapp/view/login_screen.dart';
// import 'package:whitesupermarketapp/view/main_screen.dart';

// class SplashController extends GetxController {
//   final LoginController loginController = Get.put(LoginController());
//   RxDouble opacity = RxDouble(0.0);

//   @override
//   void onInit() {
//     super.onInit();
//     animateLogoAndInitializeApp();
//   }

//   Future<void> animateLogoAndInitializeApp() async {
//     // Animate the logo
//     await Future.delayed(Duration.zero);
//     opacity.value = 1.0;

//     // Show animation for 3 seconds
//     await Future.delayed(const Duration(seconds: 3));

//     try {
//       // Connect to MongoDB and ensure collections are initialized
//       await MongoDB.connect();

//       // Load additional data
//       await MongoDB.getBanners();
//       await MongoDB.getTags();

//       // Navigate to appropriate screen
//       final bool isLoggedIn = loginController.isLoggedIn.value;
//       Get.offAll(() => isLoggedIn ? MainScreen() : LoginScreen());
//     } catch (e) {
//       print('Error during initialization: $e');
//     }
//   }
// }










//latest
import 'package:get/get.dart';
import 'package:whitesupermarketapp/database/global.dart';
import '../database/mongo.dart';
import '../view/login_screen.dart';
import '../view/main_screen.dart';
import 'login_controller.dart';

class SplashController extends GetxController {
  LoginController loginController = Get.put(LoginController());
   RxDouble opacity = RxDouble(0.0);

  @override
  onInit(){
     super.onInit();
    animateLogo();
  }

     animateLogo() async {
       await Future.delayed(Duration.zero);
    opacity.value=1;
    Future.delayed(const Duration(seconds: 5));
    await MongoDB.getBanners();
    await MongoDB.getTags();
    loginController.isLoggedIn.value
        ? Get.offAll(() => MainScreen())
        : Get.offAll(() => LoginScreen());
    //Get.offAll(() => LoginScreen());
    //Get.offAll(() => MainScreen());
      }
}