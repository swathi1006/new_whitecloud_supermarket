// import 'package:auto_animated/auto_animated.dart';
// import 'package:draggable_fab/draggable_fab.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:whitesupermarketapp/controller/home_controller.dart';
// import 'package:whitesupermarketapp/controller/item_list_view_controller.dart';
// import 'package:whitesupermarketapp/controller/nav_drawer_controller.dart';
// import 'package:whitesupermarketapp/util/colors.dart';
// import 'package:whitesupermarketapp/widgets/product_card.dart';
// import '../controller/cart_controller.dart';
// import '../controller/item_view_controller.dart';

// class ItemListViewScreen extends StatefulWidget {
//   ItemListViewScreen({Key? key}) : super(key: key);

//   @override
//   _ItemListViewScreenState createState() => _ItemListViewScreenState();
// }

// class _ItemListViewScreenState extends State<ItemListViewScreen> {

//   final ItemListViewController controller = Get.find<ItemListViewController>();
//   final ItemViewController itemViewController = Get.find();
//   final CartController cartController = Get.find();
//   final HomeController homeController = Get.find();
//   final NavDrawerController navDrawerController = Get.find();


//   @override
//   void initState() {
//     super.initState();
//     controller.gridChildren.clear();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return WillPopScope(
//       onWillPop: () async {
//         controller.gridChildren.clear();
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(controller.categoryController.text =="Detergents" ? "Cleaners & Detergents" :controller.categoryController.text ,style: const TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w400)),
//           actions: [
//             Flexible(
//               child: IconButton(
//                 onPressed: () {
//                   Share.share('White CloudSupermarket App. Download the app now. https://play.google.com/store/apps/');
//                 },
//                 icon: const Icon(
//                   Icons.share,
//                   size: 20,
//                 ),
//               ),
//             ),
//             Flexible(
//               child: IconButton(
//                 onPressed: () {
//                   navDrawerController.selectIndex(3);
//                 },
//                 icon: SizedBox(
//                   height: 36,
//                   width: 25,
//                   child: Obx(
//                         () => Stack(
//                       children: [
//                         Align(
//                           alignment: Alignment.center,
//                           child: SizedBox(
//                             height: 16,
//                             child: SvgPicture.asset(
//                               'assets/logo/whitelogo.svg',
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                         if (cartController.cart.isNotEmpty)
//                           Align(
//                             alignment: Alignment.topRight,
//                             child: Container(
//                               padding: const EdgeInsets.all(4),
//                               decoration: const BoxDecoration(color: secondary,shape: BoxShape.circle),
//                               child: Text('${cartController.cart.length}',style: const TextStyle(fontSize: 12,color: Colors.black,fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//           elevation: 0,
//         ),

//         floatingActionButton: DraggableFab(
//           child: Container(
//             decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
//             padding: const EdgeInsets.only(left:4,right:4,top:4,bottom:30),
//             child: FloatingActionButton(
//               backgroundColor: primary,
//               onPressed: () {
//                 homeController.callHelp();
//               },
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(100.0),
//               ),
//               child: const Icon(Icons.call,color: Colors.white),
//             ),
//           ),
//         ),

//         body:Column(
//             children: [
//               Expanded(
//                 child: Center(
//                   child: Container(
//                       width: Get.width*.98,
//                       decoration: const BoxDecoration(
//                         color: greylight,
//                         borderRadius: BorderRadius.all(Radius.circular(30)),
//                       ),
//                       child: CustomScrollView(
//                         //controller: controller.productScrollController,
//                         slivers: [
//                           Obx(() {
//                             controller.showProductCategory(controller.categoryController.text);
//                             return controller.gridChildren.isNotEmpty
//                                 ? LiveSliverGrid.options(
//                               itemBuilder: buildAnimatedItem,
//                               controller: controller.productScrollController,
//                               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 6 / 7),
//                               itemCount: controller.gridChildren.length,
//                               options: const LiveOptions(
//                                 delay: Duration(milliseconds: 100),
//                                 showItemInterval: Duration(milliseconds: 250),
//                                 showItemDuration: Duration(milliseconds: 250),
//                                 visibleFraction: 0.05,
//                                 reAnimateOnVisibility: false,
//                               ),
//                             )
//                                 : const SliverToBoxAdapter(
//                               child: SizedBox(
//                                 child: Center(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SizedBox(height: 20),
//                                       CircularProgressIndicator(color: primary,),
//                                       SizedBox(height: 20),
//                                       Text('Loading...',),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ],
//                       )
//                   ),
//                 ),

//               ),
//             ],
//         ),
//       ),
//     );
//   }

//   // Build animated item (helper for all examples)
//   Widget buildAnimatedItem(BuildContext context, int i, Animation<double> animation) =>
//   FadeTransition(
//     key: UniqueKey(),
//     opacity: Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(animation),
//     child: SlideTransition(
//       position: Tween<Offset>(
//         begin: const Offset(0, -0.1),
//         end: Offset.zero,
//       ).animate(animation),
//       child: ProductCard(controller.gridChildren[i], cartController, itemViewController, false),
//     ),
//   );
// }

//new one below


import 'package:auto_animated/auto_animated.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:whitesupermarketapp/controller/home_controller.dart';
import 'package:whitesupermarketapp/controller/item_list_view_controller.dart';
import 'package:whitesupermarketapp/controller/nav_drawer_controller.dart';
import 'package:whitesupermarketapp/util/colors.dart';
import 'package:whitesupermarketapp/view/submit_list_screen.dart';
import 'package:whitesupermarketapp/widgets/product_card.dart';
import '../controller/cart_controller.dart';
import '../controller/item_view_controller.dart';

class ItemListViewScreen extends StatefulWidget {
  ItemListViewScreen({Key? key}) : super(key: key);

  @override
  _ItemListViewScreenState createState() => _ItemListViewScreenState();
}

class _ItemListViewScreenState extends State<ItemListViewScreen> {
  final ItemListViewController controller = Get.find<ItemListViewController>();
  final ItemViewController itemViewController = Get.find();
  final CartController cartController = Get.find();
  final HomeController homeController = Get.find();
  final NavDrawerController navDrawerController = Get.find();

  @override
  void initState() {
    super.initState();
    controller.gridChildren.clear();
    controller.gridChildrenOld.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.gridChildren.clear();
        controller.gridChildrenOld.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              controller.categoryController.text == "Detergents"
                  ? "Cleaners & Detergents"
                  : controller.categoryController.text,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400)),
          actions: [
            Flexible(
              child: IconButton(
                onPressed: () {
                  Share.share(
                      'White CloudSupermarket App. Download the app now. https://play.google.com/store/apps/');
                },
                icon: const Icon(
                  Icons.share,
                  size: 20,
                ),
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: () {
                  navDrawerController.selectIndex(3);
                },
                icon: SizedBox(
                  height: 36,
                  width: 25,
                  child: Obx(
                    () => Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 16,
                            child: SvgPicture.asset(
                              'assets/logo/whitelogo.svg',
                              color: Colors.black,
                            ),
                          ),
                        ),
                        if (cartController.cart.isNotEmpty)
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                  color: secondary, shape: BoxShape.circle),
                              child: Text('${cartController.cart.length}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          elevation: 0,
        ),
        floatingActionButton: DraggableFab(
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            padding:
                const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // New FloatingActionButton
                FloatingActionButton(
                  heroTag:
                          'add_button', // Unique heroTag for the first button
                  backgroundColor: primary, // Customize the color
                  onPressed: () {
                     // Navigate to the new screen
                  Get.to(() => const SubmitListScreen());
                    // Add functionality for the new button
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: const Icon(Icons.format_list_numbered_outlined,
                      color: Colors.white), // Customize the icon
                ),
                const SizedBox(height: 8), // Add spacing between the buttons
                // Existing FloatingActionButton
                FloatingActionButton(
                  heroTag:
                          'call_button', // Unique heroTag for the second button
                  backgroundColor: primary,
                  onPressed: () {
                    homeController.callHelp();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: const Icon(Icons.call, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                    width: Get.width * .98,
                    decoration: const BoxDecoration(
                      color: greylight,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Obx(() {
                      print(controller.gridChildrenOld.length);
                      print(controller.gridChildren.length);
                      controller.showProductCategory(
                          controller.categoryController.text);

                      // Only use a single CustomScrollView
                      return CustomScrollView(
                        slivers: [
                          // First product grid (current category)
                          if (controller.gridChildren.isNotEmpty)
                            LiveSliverGrid.options(
                              itemBuilder: buildAnimatedItem,
                              controller: controller.productScrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 6 / 7,
                              ),
                              itemCount: controller.gridChildren.length,
                              options: const LiveOptions(
                                delay: Duration(milliseconds: 100),
                                showItemInterval: Duration(milliseconds: 250),
                                showItemDuration: Duration(milliseconds: 250),
                                visibleFraction: 0.05,
                                reAnimateOnVisibility: false,
                              ),
                            )
                          else
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 0)),

                          // Spacer or divider between sections
                          if (controller.gridChildren.isNotEmpty &&
                              controller.gridChildrenOld.isNotEmpty)
                            const SliverToBoxAdapter(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'Other Products',
                                  style: TextStyle(fontSize: 25),
                                ),
                                SizedBox(height: 10),
                              ],
                            )),

                          // Second product grid (other categories)
                          if (controller.gridChildrenOld.isNotEmpty)
                            LiveSliverGrid.options(
                              itemBuilder: buildAnimatedItem2,
                              controller: controller.productScrollController,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 6 / 7,
                              ),
                              itemCount: controller.gridChildrenOld.length,
                              options: const LiveOptions(
                                delay: Duration(milliseconds: 100),
                                showItemInterval: Duration(milliseconds: 250),
                                showItemDuration: Duration(milliseconds: 250),
                                visibleFraction: 0.05,
                                reAnimateOnVisibility: false,
                              ),
                            )
                          else
                            const SliverToBoxAdapter(
                                child: SizedBox(height: 0)),

                          // Placeholder if no products
                          if (controller.gridChildren.isEmpty &&
                              controller.gridChildrenOld.isEmpty)
                            const SliverToBoxAdapter(
                              child: Center(
                                child:
                                    CircularProgressIndicator(color: primary),
                              ),
                            ),
                        ],
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build animated item (helper for all examples)
  Widget buildAnimatedItem(
          BuildContext context, int i, Animation<double> animation) =>
      FadeTransition(
        key: UniqueKey(),
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: ProductCard(controller.gridChildren[i], cartController,
              itemViewController, false),
        ),
      );

  Widget buildAnimatedItem2(
          BuildContext context, int i, Animation<double> animation) =>
      FadeTransition(
        key: UniqueKey(),
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: ProductCard(controller.gridChildrenOld[i], cartController,
              itemViewController, false),
        ),
      );
}




// CustomScrollView(
//                       //controller: controller.productScrollController,
//                       slivers: [
//                         // Obx(() {
//                         //   print(controller.gridChildren.length);
//                         //   controller.showProductCategory(
//                         //       controller.categoryController.text);
//                         //   return

//                         //   controller.gridChildren.isNotEmpty
//                         //       ? LiveSliverGrid.options(
//                         //           itemBuilder: buildAnimatedItem,
//                         //           controller:
//                         //               controller.productScrollController,
//                         //           gridDelegate:
//                         //               const SliverGridDelegateWithFixedCrossAxisCount(
//                         //                   crossAxisCount: 2,
//                         //                   childAspectRatio: 6 / 7),
//                         //           itemCount: controller.gridChildren.length,
//                         //           options: const LiveOptions(
//                         //             delay: Duration(milliseconds: 100),
//                         //             showItemInterval:
//                         //                 Duration(milliseconds: 250),
//                         //             showItemDuration:
//                         //                 Duration(milliseconds: 250),
//                         //             visibleFraction: 0.05,
//                         //             reAnimateOnVisibility: false,
//                         //           ),
//                         //         )
//                         //       : const SliverToBoxAdapter(
//                         //           child: SizedBox(
//                         //             child: Center(
//                         //               child: Column(
//                         //                 mainAxisAlignment:
//                         //                     MainAxisAlignment.center,
//                         //                 children: [
//                         //                   SizedBox(height: 20),
//                         //                   CircularProgressIndicator(
//                         //                     color: primary,
//                         //                   ),
//                         //                   SizedBox(height: 20),
//                         //                   Text(
//                         //                     'Loading...',
//                         //                   ),
//                         //                 ],
//                         //               ),
//                         //             ),
//                         //           ),
//                         //         );
//                         // }),
//                         Obx(() {
//                           print(controller.gridChildrenOld.length);
//                           print(controller.gridChildren.length);
//                           controller.showProductCategory(
//                               controller.categoryController.text);

//                           return CustomScrollView(slivers: [
//                             //     // First product grid (current category)
//                             controller.gridChildren.isNotEmpty
//                                 ? LiveSliverGrid.options(
//                                     itemBuilder: buildAnimatedItem,
//                                     controller:
//                                         controller.productScrollController,
//                                     gridDelegate:
//                                         const SliverGridDelegateWithFixedCrossAxisCount(
//                                       crossAxisCount: 2,
//                                       childAspectRatio: 6 / 7,
//                                     ),
//                                     itemCount: controller.gridChildren.length,
//                                     options: const LiveOptions(
//                                       delay: Duration(milliseconds: 100),
//                                       showItemInterval:
//                                           Duration(milliseconds: 250),
//                                       showItemDuration:
//                                           Duration(milliseconds: 250),
//                                       visibleFraction: 0.05,
//                                       reAnimateOnVisibility: false,
//                                     ),
//                                   )
//                                 : SliverToBoxAdapter(),

//                             // Spacer or divider between sections
//                             const SliverToBoxAdapter(
//                               child: SizedBox(height: 20),
//                             ),

//                             // Second product grid (other categories)
//                             if (controller.gridChildrenOld.isNotEmpty)
//                               LiveSliverGrid.options(
//                                 itemBuilder: buildAnimatedItem,
//                                 controller: controller.productScrollController,
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   childAspectRatio: 6 / 7,
//                                 ),
//                                 itemCount: controller.gridChildrenOld.length,
//                                 options: const LiveOptions(
//                                   delay: Duration(milliseconds: 100),
//                                   showItemInterval: Duration(milliseconds: 250),
//                                   showItemDuration: Duration(milliseconds: 250),
//                                   visibleFraction: 0.05,
//                                   reAnimateOnVisibility: false,
//                                 ),
//                               ),

//                             // Placeholder if no products
//                             if (controller.gridChildren.isEmpty &&
//                                 controller.gridChildrenOld.isEmpty)
//                               const SliverToBoxAdapter(
//                                 child: Center(
//                                   child:
//                                       CircularProgressIndicator(color: primary),
//                                 ),
//                               ),
//                           ]);
//                         })
//                       ],
//                     )),