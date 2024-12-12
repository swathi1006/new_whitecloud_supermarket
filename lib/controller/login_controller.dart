// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart' as launcher;
// import 'package:http/http.dart' as http;
// import '../database/global.dart';
// import '../database/mongo.dart';

// class LoginController extends GetxController {
//   RxBool showOtp = false.obs;
//   RxDouble otpHeight = 0.0.obs;
//   RxDouble mobileHeight = 70.0.obs;
//   GlobalKey<FormState> nameKey = GlobalKey();
//   GlobalKey<FormState> mobileKey = GlobalKey();
//   GlobalKey<FormState> otpKey = GlobalKey();
//   FocusNode otpFocusNode=FocusNode();
//   TextEditingController phoneController = TextEditingController();
//   RxBool dataFetched = false.obs;
//   RxInt resendSeconds = 60.obs;
//   RxBool isLoggedIn = false.obs;

//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     //await MongoDB.getTags();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey('phonenumber')) {
//       //print(prefs.getString('phonenumber')!);
//       phone = prefs.getString('phonenumber')!;
//       isLoggedIn(true);
//       phoneController.text = prefs.getString('phonenumber')!;
//       await MongoDB.getuser(phoneController.text);
//     } else {
//       isLoggedIn(false);
//     }
//     dataFetched.toggle();
//   }

//   showLoginBottomSheet() async {
//     await Future.delayed(Duration.zero);
//     if (Get.isBottomSheetOpen ?? false) {
//       Get.back();
//     }
//     /*Get.bottomSheet(
//         Container(
//           decoration: const BoxDecoration(
//             color: white,
//             borderRadius: BorderRadiusDirectional.vertical(
//               top: Radius.circular(10),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   'Sign In',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       prefixIcon: SizedBox(
//                         width: 30,
//                         child: Center(
//                           child: Text(
//                             '+91',
//                             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                       hintText: 'Enter Phone Number'),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     hintText: 'Entre OTP',
//                     prefixIcon: SizedBox(
//                       width: 30,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.offAll(() => HomeScreen());
//                   },
//                   style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(15))),
//                   child: const Text(
//                     'Sign In',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         barrierColor: Colors.transparent,
//         elevation: 15,
//         isDismissible: false);*/
//   }

//   sendOtp2factor(String number, String otp) async {
//     var url = Uri.parse('https://2factor.in/API/R1/');
//     var response = await http.post(url, body: {
//       'module': 'TRANS_SMS',
//       'apikey': '2f5355a4-044b-11ef-8cbb-0200cd936042',
//       'to': '91$number',
//       'from': 'WCLOUD',
//       'templatename' :'OTPVerification',
//       'var1': UserName,
//       'var2': otp,
//       'msg': 'Dear #VAR1#, your login pin is #VAR2#'
//     });
//     /*
//     if (response.statusCode == 200) {
//       //print('OTP sent successfully');
//     } else {
//       print('Failed to send OTP');
//       print(response.body);
//     }*/
//   }
//   sendOtp(String number, String otp) async {
//     if (mobileKey.currentState!.validate()) {
//       //launcher.launch('sms:$number?body=$otp');
//       sendOtp2factor(number, otp);
//       mobileHeight.value = 0.0;
//       otpHeight.value = 70.0;
//       showOtp.toggle();
//       otpFocusNode.requestFocus();
//     }
//   }
// }

//old one above


 // @override
  // Future<void> onInit() async {
  //   super.onInit();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey('phonenumber')) {
  //     phone = prefs.getString('phonenumber')!;
  //     isLoggedIn(true);
  //     phoneController.text = phone;
  //     await MongoDB.getuser(phone);
  //   } else {
  //     isLoggedIn(false);
  //   }
  //   dataFetched.toggle();
  // }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../database/global.dart';
import '../database/mongo.dart';

class LoginController extends GetxController {
  RxBool showOtp = false.obs;
  RxDouble otpHeight = 0.0.obs;
  RxDouble mobileHeight = 70.0.obs;

    // Assign unique GlobalKeys
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> mobileKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpKey = GlobalKey<FormState>();


  // GlobalKey<FormState> nameKey = GlobalKey();
  // GlobalKey<FormState> mobileKey = GlobalKey();
  // GlobalKey<FormState> otpKey = GlobalKey();
  FocusNode otpFocusNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  RxBool dataFetched = false.obs;
  RxInt resendSeconds = 60.obs;
  RxBool isLoggedIn = false.obs;

 

  @override
  Future<void> onInit() async {
    super.onInit();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (prefs.containsKey('phonenumber')) {
        phone = prefs.getString('phonenumber')!;
        isLoggedIn(true);
        phoneController.text = phone;

        // Safely attempt to fetch user details
        await MongoDB.getuser(phone);

        // Check if globalusers was successfully set
        if (globalusers.isEmpty) {
          print("Failed to fetch user data. User may not exist.");
        }
      } else {
        isLoggedIn(false);
      }

      dataFetched.toggle(); // Toggle data fetched status
    } catch (e) {
      print("Error during onInit: $e");
    }
  }

  @override
  void onClose() {
    otpFocusNode.dispose(); // Properly dispose FocusNode
    phoneController.dispose();
    super.onClose();
  }

  sendOtp2factor(String number, String otp) async {
    var url = Uri.parse('https://2factor.in/API/R1/');
    await http.post(url, body: {
      'module': 'TRANS_SMS',
      'apikey': '2f5355a4-044b-11ef-8cbb-0200cd936042',
      'to': '91$number',
      'from': 'WCLOUD',
      'templatename': 'OTPVerification',
      'var1': UserName,
      'var2': otp,
      'msg': 'Dear #VAR1#, your login pin is #VAR2#',
    });
  }

  sendOtp(String number, String otp) async {
    if (mobileKey.currentState!.validate()) {
      sendOtp2factor(number, otp);
      mobileHeight.value = 0.0;
      otpHeight.value = 70.0;
      showOtp.toggle();
      otpFocusNode.requestFocus();
    }
  }
}
// before native splash code is above

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../database/global.dart';
// import '../database/mongo.dart';
// import '../view/login_screen.dart';
// import '../view/main_screen.dart';

// class LoginController extends GetxController {
//   RxBool showOtp = false.obs;
//   RxDouble otpHeight = 0.0.obs;
//   RxDouble mobileHeight = 70.0.obs;
//   GlobalKey<FormState> nameKey = GlobalKey();
//   GlobalKey<FormState> mobileKey = GlobalKey();
//   GlobalKey<FormState> otpKey = GlobalKey();
//   FocusNode otpFocusNode = FocusNode();
//   TextEditingController phoneController = TextEditingController();
//   RxBool dataFetched = false.obs;
//   RxInt resendSeconds = 60.obs;
//   RxBool isLoggedIn = false.obs;

//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     await handleSplashTasks(); // Perform splash-related tasks
//     await initializeLogin(); // Initialize login
//     dataFetched.value = true; // Ensure this is set after initialization
//   }

//   Future<void> handleSplashTasks() async {
//     // Perform the tasks from the splash controller
//     await MongoDB.getBanners();
//     await MongoDB.getTags();
//   }

//   // Future<void> initializeLogin() async {
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   if (prefs.containsKey('phonenumber')) {
//   //     phone = prefs.getString('phonenumber')!;
//   //     print('Retrieved phone number: $phone');
//   //     isLoggedIn(true);
//   //     phoneController.text = phone;
//   //     await MongoDB.getuser(phone);
//   //   } else {
//   //     print('No phone number found in SharedPreferences.');
//   //     isLoggedIn(false);
//   //   }
//   // }

//   Future<void> initializeLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     if (prefs.containsKey('phonenumber')) {
//       phone = prefs.getString('phonenumber')!;
//       print('Retrieved phone number: $phone');
//       isLoggedIn.value = true;

//       // Fetch user details from the database
//       await MongoDB.getuser(phone);
//     } else {
//       print('No phone number found in SharedPreferences.');
//       isLoggedIn.value = false;
//     }
//   }


//   @override
//   void onClose() {
//     otpFocusNode.dispose(); // Properly dispose FocusNode
//     phoneController.dispose();
//     super.onClose();
//   }

//   sendOtp2factor(String number, String otp) async {
//     var url = Uri.parse('https://2factor.in/API/R1/');
//     await http.post(url, body: {
//       'module': 'TRANS_SMS',
//       'apikey': '2f5355a4-044b-11ef-8cbb-0200cd936042',
//       'to': '91$number',
//       'from': 'WCLOUD',
//       'templatename': 'OTPVerification',
//       'var1': UserName,
//       'var2': otp,
//       'msg': 'Dear #VAR1#, your login pin is #VAR2#',
//     });
//   }

//   sendOtp(String number, String otp) async {
//     if (mobileKey.currentState!.validate()) {
//       sendOtp2factor(number, otp);
//       mobileHeight.value = 0.0;
//       otpHeight.value = 70.0;
//       showOtp.toggle();
//       otpFocusNode.requestFocus();
//     }
//   }
// }
