


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whitesupermarketapp/util/colors.dart';
import 'package:whitesupermarketapp/util/theme.dart';
import 'package:whitesupermarketapp/view/splash_screen.dart';
import 'package:whitesupermarketapp/widgets/fallback_ui.dart';
import 'database/global.dart';
import 'database/mongo.dart';
// Future<void> main() async {
//   Map<String, dynamic> dbAndCollection = await MongoDB.connect();
//   db = dbAndCollection['db'];
//   collection_items = dbAndCollection['collection_items'];
//   collection_banners = dbAndCollection['collection_banners'];
//   runApp(const MyApp());
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures binding is initialized for async operations
  bool databaseConnected = false;

  try {
    // Attempt to connect to MongoDB
    Map<String, dynamic>? dbAndCollection = await MongoDB.connect();
    if (dbAndCollection == null) {
      // Handle connection failure gracefully
      print('Failed to connect to MongoDB.');
      // runApp(const ConnectionErrorApp()); // Show a fallback app or UI
    } else{
       // Assign the connected database and collections
      db = dbAndCollection['db'];
      collection_items = dbAndCollection['collection_items'];
      collection_banners = dbAndCollection['collection_banners'];
      databaseConnected = true;
    }
   
  } 
  catch (e) {
    print('An unexpected error occurred during database initialization: $e');
    // runApp(const ConnectionErrorApp()); // Show a fallback app or UI
    
  }
  // Proceed with the main application if no errors
  // runApp(const MyApp());
   runApp(
    databaseConnected
        ? const MyApp() // If connected to the database, launch the main app
        :  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: myTheme.copyWith(
              colorScheme: myTheme.colorScheme.copyWith(secondary: secondary),
            ),
            home:  const OfflineFallbackScreen(),
        ), // Otherwise, show the fallback screen
  );
   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Get.put(ItemListViewController());
    return GetMaterialApp(
      title: 'White Supermarket',
      debugShowCheckedModeBanner: false,
       theme: myTheme.copyWith(colorScheme: myTheme.colorScheme.copyWith(secondary: secondary)),
      home: SplashScreen(),
       );
  }
}















// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:whitesupermarketapp/controller/login_controller.dart';
// import 'package:whitesupermarketapp/util/colors.dart';
// import 'package:whitesupermarketapp/util/theme.dart';
// import 'package:whitesupermarketapp/view/login_screen.dart';
// import 'package:whitesupermarketapp/view/main_screen.dart';
// import 'package:whitesupermarketapp/view/splash_screen.dart';
// import 'database/global.dart';
// import 'database/mongo.dart';



// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensures binding is initialized for async operations

//   try {
//     Map<String, dynamic>? dbAndCollection = await MongoDB.connect();

//     if (dbAndCollection == null) {
//       // Handle connection failure gracefully
//       print('Failed to connect to MongoDB. Exiting app.');
//       // runApp(const ConnectionErrorApp()); // Show a fallback app or UI
//       return;
//     }

//     // Assign the connected database and collections
//     db = dbAndCollection['db'];
//     collection_items = dbAndCollection['collection_items'];
//     collection_banners = dbAndCollection['collection_banners'];
//   } catch (e) {
//     print('An unexpected error occurred during database initialization: $e');
//     // runApp(const ConnectionErrorApp()); // Show a fallback app or UI
//     return;
//   }

//   // Proceed with the main application if no errors
//   runApp(const MyApp());

//   // Lock device orientation
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]);
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     //Get.put(ItemListViewController());

//     return GetMaterialApp(
//       title: 'White Supermarket',
//       debugShowCheckedModeBanner: false,
//       theme: myTheme.copyWith(colorScheme: myTheme.colorScheme.copyWith(secondary: secondary)),
//       home: SplashScreen(),
//     );
//   }
// }


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Initialize LoginController to manage splash tasks and navigation
//     final LoginController loginController = Get.put(LoginController());

//     // Check if the user is logged in to determine the home screen
//     Widget homePage = loginController.isLoggedIn.value 
//         ? MainScreen() 
//         : LoginScreen();

//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'White Supermarket',`
//       theme: myTheme.copyWith(colorScheme: myTheme.colorScheme.copyWith(secondary: secondary)),
//       home: homePage,
//     );
//   }
// }

//new one below
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:whitesupermarketapp/controller/login_controller.dart';
// import 'package:whitesupermarketapp/util/colors.dart';
// import 'package:whitesupermarketapp/util/theme.dart';
// import 'package:whitesupermarketapp/view/login_screen.dart';
// import 'package:whitesupermarketapp/view/main_screen.dart';
// import 'database/global.dart';
// import 'database/mongo.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // Ensures binding is initialized for async operations

//   // Initialize the database
//   try {
//     Map<String, dynamic>? dbAndCollection = await MongoDB.connect();

//     if (dbAndCollection == null) {
//       print('Failed to connect to MongoDB. Exiting app.');
//       return;
//     }

//     db = dbAndCollection['db'];
//     collection_items = dbAndCollection['collection_items'];
//     collection_banners = dbAndCollection['collection_banners'];
//   } catch (e) {
//     print('An unexpected error occurred during database initialization: $e');
//     return;
//   }

//   // Check login state before running the app
//   final initialScreen = await determineInitialScreen();

//   runApp(MyApp(initialScreen: initialScreen));

//   // Lock device orientation
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
// }

// Future<Widget> determineInitialScreen() async {
//   final LoginController loginController = Get.put(LoginController());
//   await loginController.initializeLogin();

//   // Return MainScreen if logged in, else LoginScreen
//   return loginController.isLoggedIn.value ? MainScreen() : LoginScreen();
// }

// class MyApp extends StatelessWidget {
//   final Widget initialScreen;

//   const MyApp({Key? key, required this.initialScreen}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'White Supermarket',
//       theme: myTheme.copyWith(
//         colorScheme: myTheme.colorScheme.copyWith(secondary: secondary),
//       ),
//       home: initialScreen,
//     );
//   }
// }



