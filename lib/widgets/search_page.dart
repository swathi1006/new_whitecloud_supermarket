// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:whitesupermarketapp/controller/cart_controller.dart';
// import 'package:whitesupermarketapp/controller/item_view_controller.dart';
// import 'package:whitesupermarketapp/controller/search_page_controller.dart';
// import 'package:whitesupermarketapp/util/colors.dart';
// import 'package:whitesupermarketapp/view/submit_list_screen.dart';
// import 'package:whitesupermarketapp/controller/home_controller.dart';
// import 'package:whitesupermarketapp/widgets/product_card.dart';

// class SearchPage extends StatelessWidget {
//   SearchPage({Key? key}) : super(key: key);

//   final homeController = Get.find<SearchPageController>();
//   final searchController = Get.find<SearchPageController>();
//   final cartController = Get.find<CartController>();
//   final itemViewController = Get.find<ItemViewController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primary,
//         iconTheme: const IconThemeData(color: white),
//         elevation: 0,
//         toolbarHeight: 80,
//         title: Row(
//           children: [
//             Expanded(
//               child: Container(
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: white,
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//                 child: TextField(
//                   controller: homeController.searchbarController,
//                   focusNode: homeController.searchBarFocusNode,
//                   autofocus: true,
//                   style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search, color: Colors.black),
//                     hintText: 'Search for items',
//                     hintStyle: GoogleFonts.poppins(
//                       color: Colors.black.withOpacity(0.6),
//                       fontSize: 14,
//                     ),
//                     suffixIcon: homeController
//                             .searchbarController.text.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.clear, color: Colors.black),
//                             onPressed: () {
//                               homeController.clearSearch();
//                             },
//                           )
//                         : null,
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: const EdgeInsets.all(0),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(18),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   onChanged: (text) {
//                     print("⌨️ Typing: $text"); // Debug log
//                     homeController.searchProduct(text);
//                     homeController.setProductsBasedOnTagSearch();
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(width: 20),
//             IconButton(
//               onPressed: () {
//                 Get.to(() => const SubmitListScreen());
//               },
//               icon: const Icon(
//                 Icons.format_list_numbered_outlined,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Obx(() {
//               if (homeController.searchSuggestions.isNotEmpty) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Search Suggestions',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Wrap(
//                       spacing: 8,
//                       children: homeController.searchSuggestions
//                           .map(
//                             (suggestion) => Chip(
//                               label: Text(suggestion),
//                               onDeleted: () {
//                                 homeController.searchbarController.text =
//                                     suggestion;
//                                 homeController.setProductsBasedOnTagSearch();
//                               },
//                             ),
//                           )
//                           .toList(),
//                     ),
//                     const SizedBox(height: 16),
//                   ],
//                 );
//               } else {
//                 return const SizedBox.shrink(); // Hide if no suggestions
//               }
//             }),

//             // Obx(() {
//             //   print(
//             //       "🖥️ UI Rebuilding, Search Active: ${homeController.search.value}");
//             //   print(
//             //       "🎯 UI Search Suggestions: ${homeController.searchSuggestions.join(', ')}");

//             //   if (homeController.search.value &&
//             //       homeController.searchSuggestions.isNotEmpty) {
//             //     return Column(
//             //       crossAxisAlignment: CrossAxisAlignment.start,
//             //       children: [
//             //         Text(
//             //           'Search Suggestions',
//             //           style: GoogleFonts.poppins(
//             //             fontSize: 16,
//             //             fontWeight: FontWeight.bold,
//             //             color: Colors.black,
//             //           ),
//             //         ),
//             //         const SizedBox(height: 8),
//             //         Wrap(
//             //           spacing: 8,
//             //           children: homeController.searchSuggestions
//             //               .map(
//             //                 (suggestion) => Chip(
//             //                   label: Text(suggestion),
//             //                   onDeleted: () {
//             //                     homeController.searchbarController.text =
//             //                         suggestion;
//             //                     homeController.setProductsBasedOnTagSearch();
//             //                   },
//             //                 ),
//             //               )
//             //               .toList(),
//             //         ),
//             //         const SizedBox(height: 16),
//             //       ],
//             //     );
//             //   } else {
//             //     return const SizedBox.shrink();
//             //   }
//             // }),

//             // Text(
//             //   'Products',
//             //   style: GoogleFonts.poppins(
//             //     fontSize: 18,
//             //     fontWeight: FontWeight.bold,
//             //     color: Colors.black,
//             //   ),
//             // ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: Obx(() {
//                 if (homeController.gridChildren.isEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.search_off,
//                           color: Colors.grey,
//                           size: 40,
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Start typing to search for products!',
//                           style: GoogleFonts.poppins(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }
//                 return GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 0.7,
//                   ),
//                   itemCount: homeController.gridChildren.length,
//                   itemBuilder: (context, index) {
//                     final product = homeController.gridChildren[index];
//                     return ProductCard(
//                       product,
//                       cartController,
//                       itemViewController,
//                       false,
//                     );
//                   },
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whitesupermarketapp/controller/cart_controller.dart';
import 'package:whitesupermarketapp/controller/item_view_controller.dart';
import 'package:whitesupermarketapp/controller/search_page_controller.dart';
import 'package:whitesupermarketapp/util/colors.dart';
import 'package:whitesupermarketapp/view/submit_list_screen.dart';
import 'package:whitesupermarketapp/widgets/product_card.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final searchController = Get.find<SearchPageController>();
  final cartController = Get.find<CartController>();
  final itemViewController = Get.find<ItemViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: white),
        elevation: 0,
        toolbarHeight: 80,
        title: _buildSearchBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => _buildSearchSuggestions()),
            const SizedBox(height: 8),
            Expanded(child: _buildProductGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextField(
              controller: searchController.searchbarController,
              focusNode: searchController.searchBarFocusNode,
              autofocus: true,
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                hintText: 'Search for items',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 14,
                ),
                suffixIcon: searchController.searchbarController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.black),
                        onPressed: searchController.clearSearch,
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (text) {
                searchController.searchProduct(text);
                searchController.setProductsBasedOnTagSearch();
              },
            ),
          ),
        ),
        const SizedBox(width: 20),
        IconButton(
          onPressed: () {
            Get.to(() => const SubmitListScreen());
          },
          icon: const Icon(
            Icons.format_list_numbered_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSuggestions() {
    if (searchController.searchSuggestions.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search Suggestions',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: searchController.searchSuggestions
                .map((suggestion) => ActionChip(
                      label: Text(suggestion),
                      onPressed: () {
                        // Extract the first word before any special characters
                        String searchTerm =
                            suggestion.split(RegExp(r'\s|\|')).first.trim();

                        searchController.searchbarController.text = searchTerm;

                        // Clear the suggestions
                        searchController.searchSuggestions.clear();

                        searchController.setProductsBasedOnTagSearch();
                      },
                    ))
                .toList(),
          ),

          // Wrap(
          //   spacing: 8,
          //   children: searchController.searchSuggestions
          //       .map(
          //         (suggestion) => Chip(
          //           label: Text(suggestion),
          //           onDeleted: () {
          //             // searchController.searchbarController.text = suggestion;
          //             // searchController.searchProduct(suggestion);
          //             searchController.searchbarController.text = suggestion;
          //             // searchController.clearSearch(); // Clear previous results
          //             // searchController
          //                 // .searchProduct(suggestion); // Update search text
          //             searchController
          //                 .setProductsBasedOnTagSearch(); // Fetch products for this tag
          //           },
          //         ),
          //       )
          //       .toList(),
          // ),
          const SizedBox(height: 16),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildProductGrid() {
    return Obx(() {
      if (searchController.gridChildren.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.search_off,
                color: Colors.grey,
                size: 40,
              ),
              const SizedBox(height: 10),
              Text(
                'Start typing to search for products!',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      }
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemCount: searchController.gridChildren.length,
        itemBuilder: (context, index) {
          final product = searchController.gridChildren[index];
          return ProductCard(
            product,
            cartController,
            itemViewController,
            false,
          );
        },
      );
    });
  }
}
