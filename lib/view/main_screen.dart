// import 'package:draggable_fab/draggable_fab.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:whitesupermarketapp/controller/nav_drawer_controller.dart';
// import 'package:whitesupermarketapp/view/home_screen.dart';
// import 'package:whitesupermarketapp/view/my_account_screen.dart';
// import 'package:whitesupermarketapp/view/my_cart_screen.dart';
// import 'package:whitesupermarketapp/view/my_order_screen.dart';
// import '../controller/cart_controller.dart';
// import '../controller/home_controller.dart';
// import '../controller/item_list_view_controller.dart';
// import '../controller/item_view_controller.dart';
// import '../controller/my_account_controller.dart';
// import '../util/colors.dart';
// import '../widgets/nav_drawer.dart';

// class MainScreen extends StatelessWidget {
//   MainScreen({Key? key}) : super(key: key);
//   final NavDrawerController navDrawerController = Get.put(NavDrawerController());
//   final ItemViewController itemViewController = Get.put(ItemViewController());
//   final ItemListViewController itemListViewController = Get.put(ItemListViewController());
//   final HomeController homeController = Get.put(HomeController());
//   final CartController cartController = Get.put(CartController());
//   final MyAccountController myAccountController = Get.put(MyAccountController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => WillPopScope(
//         onWillPop: () async {
//           if (homeController.showSearchSuggestions.value) {
//             homeController.searchBarFocusNode.unfocus();
//             return false;
//           }
//           return true;
//         },
//         child: Scaffold(
//           key: navDrawerController.scaffoldKey,
//           drawer: NavDrawer(),
//           appBar: AppBar(
//             title: Text(navDrawerController.title.value),
//             actions: [
//               Flexible(
//                 child: IconButton(
//                   onPressed: () {
//                     homeController.shareApp();
//                   },
//                   icon: const Icon(
//                     Icons.share,
//                     size: 20,
//                   ),
//                 ),
//               ),
//               Flexible(
//                 child: IconButton(
//                   onPressed: () {
//                     navDrawerController.selectIndex(3);
//                   },
//                   icon: SizedBox(
//                     height: 36,
//                     width: 25,
//                     child: Obx(
//                           () => Stack(
//                         children: [
//                           Align(
//                             alignment: Alignment.center,
//                             child: SizedBox(
//                               height: 16,
//                               child: SvgPicture.asset(
//                                 'assets/logo/whitelogo.svg',
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           if (cartController.cart.isNotEmpty)
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: Container(
//                                 padding: const EdgeInsets.all(4),
//                                 decoration: const BoxDecoration(color: secondary,shape: BoxShape.circle),
//                                 child: Text('${cartController.cart.length}',style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold)),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             elevation: 0,
//           ),
//           floatingActionButton: !homeController.showSearchSuggestions.value
//               ? DraggableFab(
//                   child: Container(
//                     decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
//                     padding: const EdgeInsets.only(left:4,right:4,top:4,bottom:45),
//                     child: FloatingActionButton(

//                       backgroundColor: primary,
//                       onPressed: () {
//                         homeController.callHelp();
//                       },
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(100.0),
//                       ),
//                       child: const Icon(Icons.call, color: Colors.white),
//                     ),
//                   ),
//                 )
//               : null,
//           body: [
//             HomeScreen(),
//             MyAccountScreen(),
//             MyOrderScreen(),
//             MyCartScreen(),
//           ][navDrawerController.selectedIndex.value],
//         ),
//       ),
//     );
//   }
// }

// import 'package:draggable_fab/draggable_fab.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:whitesupermarketapp/controller/nav_drawer_controller.dart';
// import 'package:whitesupermarketapp/view/home_screen.dart';
// import 'package:whitesupermarketapp/view/my_account_screen.dart';
// import 'package:whitesupermarketapp/view/my_cart_screen.dart';
// import 'package:whitesupermarketapp/view/my_order_screen.dart';
// import '../controller/cart_controller.dart';
// import '../controller/home_controller.dart';
// import '../controller/item_list_view_controller.dart';
// import '../controller/item_view_controller.dart';
// import '../controller/my_account_controller.dart';
// import '../util/colors.dart';
// import '../widgets/nav_drawer.dart';
// import 'package:whitesupermarketapp/view/submit_list_screen.dart';

// class MainScreen extends StatelessWidget {
//   MainScreen({Key? key}) : super(key: key);

//   final NavDrawerController navDrawerController = Get.put(NavDrawerController());
//   final ItemViewController itemViewController = Get.put(ItemViewController());
//   final ItemListViewController itemListViewController = Get.put(ItemListViewController());
//   final HomeController homeController = Get.put(HomeController());
//   final CartController cartController = Get.put(CartController());
//   final MyAccountController myAccountController = Get.put(MyAccountController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => WillPopScope(
//         onWillPop: () async {
//           if (homeController.showSearchSuggestions.value) {
//             homeController.searchBarFocusNode.unfocus();
//             return false;
//           }
//           return true;
//         },
//         child: Scaffold(
//           key: navDrawerController.scaffoldKey,
//           drawer: NavDrawer(),
//           appBar: AppBar(
//             title: Text(navDrawerController.title.value),
//             actions: [
//               Flexible(
//                 child: IconButton(
//                   onPressed: () {
//                     homeController.shareApp();
//                   },
//                   icon: const Icon(
//                     Icons.share,
//                     size: 20,
//                   ),
//                 ),
//               ),
//               Flexible(
//                 child: IconButton(
//                   onPressed: () {
//                     navDrawerController.selectIndex(3);
//                   },
//                   icon: SizedBox(
//                     height: 36,
//                     width: 25,
//                     child: Obx(
//                       () => Stack(
//                         children: [
//                           Align(
//                             alignment: Alignment.center,
//                             child: SizedBox(
//                               height: 16,
//                               child: SvgPicture.asset(
//                                 'assets/logo/whitelogo.svg',
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           if (cartController.cart.isNotEmpty)
//                             Align(
//                               alignment: Alignment.topRight,
//                               child: Container(
//                                 padding: const EdgeInsets.all(4),
//                                 decoration: const BoxDecoration(
//                                   color: secondary,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Text(
//                                   '${cartController.cart.length}',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//             elevation: 0,
//           ),
//           floatingActionButton: !homeController.showSearchSuggestions.value
//               ? DraggableFab(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.transparent,
//                     ),
//                     padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 30),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         FloatingActionButton(
//                           heroTag: 'add_button',
//                           backgroundColor: primary,
//                           onPressed: () {
//                             Get.to(() => const SubmitListScreen());
//                           },
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100.0),
//                           ),
//                           child: const Icon(
//                             Icons.format_list_numbered_outlined,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         FloatingActionButton(
//                           heroTag: 'call_button',
//                           backgroundColor: primary,
//                           onPressed: () {
//                             homeController.callHelp();
//                           },
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100.0),
//                           ),
//                           child: const Icon(
//                             Icons.call,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : null,
//           body: [
//             HomeScreen(),
//             MyAccountScreen(),
//             MyOrderScreen(),
//             MyCartScreen(),
//           ][navDrawerController.selectedIndex.value],
//         ),
//       ),
//     );
//   }
// }

//very new one below:

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whitesupermarketapp/controller/nav_drawer_controller.dart';
import 'package:whitesupermarketapp/view/home_screen.dart';
import 'package:whitesupermarketapp/view/my_account_screen.dart';
import 'package:whitesupermarketapp/view/my_cart_screen.dart';
import 'package:whitesupermarketapp/view/my_order_screen.dart';
import 'package:whitesupermarketapp/widgets/search_page.dart';
import '../controller/cart_controller.dart';
import '../controller/home_controller.dart';
import '../controller/item_list_view_controller.dart';
import '../controller/item_view_controller.dart';
import '../controller/my_account_controller.dart';
import '../util/colors.dart';
import '../widgets/nav_drawer.dart';
import 'package:whitesupermarketapp/view/submit_list_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final NavDrawerController navDrawerController =
      Get.put(NavDrawerController());
  final ItemViewController itemViewController = Get.put(ItemViewController());
  final ItemListViewController itemListViewController =
      Get.put(ItemListViewController());
  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());
  final MyAccountController myAccountController =
      Get.put(MyAccountController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          if (homeController.showSearchSuggestions.value) {
            homeController.searchBarFocusNode.unfocus();
            return false;
          }
          return true;
        },
        child: Scaffold(
          key: navDrawerController.scaffoldKey,
          drawer: NavDrawer(),
          appBar: AppBar(
            backgroundColor: primary,
            elevation: 0,
            toolbarHeight: 80,
            iconTheme: const IconThemeData(color: white),
            title: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: TextField(
                      focusNode: homeController.searchBarFocusNode,
                      style: const TextStyle(color: Colors.black),
                      onTap: () {
                        Get.to(() => const SearchPage());
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.black),
                        hintText: 'Search WhiteApp',
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(
                            right: 1,
                            left: 2,
                            top: 4), // Adjust top padding to move hint down
                      ),
                    ),
                  ),
                ),
                // const SizedBox(width: 0),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: screenWidth * 0.2),
                  child: IconButton(
                    onPressed: () {
                      navDrawerController.selectIndex(3);
                    },
                    icon: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 16,
                            child: SvgPicture.asset(
                              'assets/logo/whitelogo.svg',
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (cartController.cart.isNotEmpty)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${cartController.cart.length}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    homeController.shareApp();
                  },
                  icon: const Icon(Icons.share, color: Colors.white),
                ),
              ],
            ),
          ),
          floatingActionButton: !homeController.showSearchSuggestions.value
              ? DraggableFab(
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, top: 4, bottom: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FloatingActionButton(
                          heroTag: 'add_button',
                          backgroundColor: primary,
                          onPressed: () {
                            Get.to(() => const SubmitListScreen());
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: const Icon(
                            Icons.format_list_numbered_outlined,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FloatingActionButton(
                          heroTag: 'call_button',
                          backgroundColor: primary,
                          onPressed: () {
                            homeController.callHelp();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.0),
                          ),
                          child: const Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : null,
          body: [
            HomeScreen(),
            MyAccountScreen(),
            MyOrderScreen(),
            MyCartScreen(),
          ][navDrawerController.selectedIndex.value],
        ),
      ),
    );
  }
}
