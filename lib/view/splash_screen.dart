// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:whitesupermarketapp/controller/splash_controller.dart';
// import 'package:whitesupermarketapp/util/colors.dart';

// class SplashScreen extends StatelessWidget {
//   SplashScreen({Key? key}) : super(key: key);
//   final SplashController controller = Get.put(SplashController());


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: Center(
//         child: Obx(
//           () => SizedBox(
//             height: Get.width * 0.5,
//             width: Get.width * 0.5,
//             child: AnimatedOpacity(
//                 opacity: controller.opacity.value,
//                 duration: const Duration(seconds: 3),
//                 child: Image.asset('assets/logo/white_super_market_logo.png')),
//           ),
//         ),
//       ),
      
//     );
//   }
// }

//old one above

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controller/splash_controller.dart';
// import '../util/colors.dart';

// class SplashScreen extends StatelessWidget {
//   final SplashController controller = Get.put(SplashController());

//   SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Logo with fade-in animation
//             Obx(
//               () => AnimatedOpacity(
//                 opacity: controller.opacity.value,
//                 duration: const Duration(seconds: 3),
//                 child: Image.asset(
//                   'assets/logo/white_super_market_logo.png',
//                   height: Get.width * 0.5,
//                   width: Get.width * 0.5,
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16), // Space between logo and progress indicator

//             // Linear progress indicator just below the logo
//             SizedBox(
//               width: Get.width * 0.5, // Width matches the logo's size
//               child: LinearProgressIndicator(
//                 color: Colors.white,
//                 backgroundColor: Colors.white.withOpacity(0.2),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whitesupermarketapp/controller/splash_controller.dart';
import 'package:whitesupermarketapp/util/colors.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController controller = Get.put(SplashController());
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Obx(
          () => SizedBox(
            height: Get.width * 0.5,
            width: Get.width * 0.5,
            child: AnimatedOpacity(
               opacity: controller.opacity.value,
                duration: const Duration(seconds: 3),
                child: Image.asset('assets/logo/white_super_market_logo.png')),
          ),
        ),
      ),
      /*body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.width * 0.17,
                width: Get.width * 0.17,
                child: Image.asset('assets/logo/white_super_market_logo.png'),
              ),
              const SizedBox(
                width: 20,
                 ),
                     const Text('WHITE', style: TextStyle(fontSize: 40, color: white), textAlign: TextAlign.center)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'CLOUD',
                style: TextStyle(fontSize: 20, color: white),
              ),
              Text(
                ' SUPERMARKET',
                style: TextStyle(fontSize: 20, color: white, fontWeight: FontWeight.bold),
                 ),
            ],
          )
        ],
      ),*/
       );
  }
}