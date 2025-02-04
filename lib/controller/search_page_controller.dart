import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whitesupermarketapp/database/mongo.dart';
import 'package:whitesupermarketapp/modal/product.dart';

class SearchPageController extends GetxController {
  RxString label = ''.obs;
  RxBool search = false.obs;
  RxList<String> searchSuggestions = <String>[].obs;
  RxList<Product> gridChildren = <Product>[].obs;
  RxList<Product> gridChildrenOld = <Product>[].obs;
  RxList<Product> globalItems = <Product>[].obs;
  RxList<Product> allProducts =<Product>[].obs; // Assuming all products are preloaded
  RxBool showBlankSearchSuggestions = true.obs;

  final searchbarController = TextEditingController();
  final ScrollController productScrollController = ScrollController();
  late FocusNode searchBarFocusNode; // Add the focus node

  @override
  void onInit() {
    super.onInit();
    searchBarFocusNode = FocusNode(); // Initialize the focus node
    searchBarFocusNode.addListener(() {
       print("Focus changed: ${searchBarFocusNode.hasFocus}");
      if (searchBarFocusNode.hasFocus) {
        showBlankSearchSuggestions.value =
            false; // Show suggestions when focused
      } else {
        if (searchbarController.text.isEmpty) {
          showBlankSearchSuggestions.value =
              true; // Show suggestions again if text is cleared
        }
      }
    });
    productScrollController.addListener(_scrollListener);
  }

  

  // Search for product suggestions
  // void searchProduct(String pattern) {
  //   searchSuggestions.clear();
  //   if (pattern.isNotEmpty) {
  //     showBlankSearchSuggestions.value = false;
  //     searchSuggestions.addAll(
  //       allProducts.where((element) {
  //         print("Checking: ${element.item_name}"); // Debug line
  //         return element.item_name
  //             .toLowerCase()
  //             .startsWith(pattern.toLowerCase());
  //       }).map((e) => e.item_name),
  //     );
  //     searchSuggestions.sort((a, b) => a.compareTo(b));
  //     print("Search Suggestions: ${searchSuggestions.join(', ')}");
  //   } else {
  //     showBlankSearchSuggestions.value = true;
  //     searchSuggestions.addAll(allProducts.map((p) => p.item_name));
  //     searchSuggestions.sort((a, b) => a.compareTo(b));
  //     print("All Suggestions: ${searchSuggestions.join(', ')}");
  //   }
  // }
void searchProduct(String pattern) {
  print("🔍 Searching for: $pattern");
  print("📦 Total Products Loaded: ${allProducts.length}");

  searchSuggestions.clear(); // Clear previous suggestions

  if (pattern.isNotEmpty) {
    showBlankSearchSuggestions.value = false;

    // Filter and map to suggestions (product names)
    var filteredSuggestions = allProducts
        .where((product) => product.item_name.toLowerCase().startsWith(pattern.toLowerCase()))
        .map((product) => product.item_name) // Just add item names for suggestions
        .toList();

    searchSuggestions.assignAll(filteredSuggestions); // Use assignAll to update suggestions
    searchSuggestions.sort(); // Sort suggestions

    print("✅ Updated Search Suggestions: ${searchSuggestions.join(', ')}");
  } else {
    showBlankSearchSuggestions.value = true;
    searchSuggestions.assignAll(allProducts.map((p) => p.item_name)); // Default to all products
    searchSuggestions.sort();

    print("📌 All Search Suggestions: ${searchSuggestions.join(', ')}");
  }

  print("🔹 Final Suggestions Count: ${searchSuggestions.length}");
}


  // Fetch products based on the selected tag/search term
  Future<void> setProductsBasedOnTagSearch() async {
    if (searchbarController.text.isNotEmpty) {
      label.value = searchbarController.text;
      var items = await MongoDB.getTagItems(searchbarController.text);
      print("MongoDB returned ${items.length} items for '${searchbarController.text}'");

      if (items.isNotEmpty) {
        search.value = true;
        gridChildren.clear();

        gridChildrenOld.clear(); // Move this before looping through items.

        for (var item in items) {
          // Add debug print
          print(
              "Processing product: ${item['item_name']} with ID: ${item['_id']}");
          List<String> itemCategoryList =List<String>.from(item['item_catogory']);
          List<String> itemTagList = List<String>.from(item['item_tags']);

          Product newProduct = Product(
            item['_id'].toHexString(),
            item['item_code'],
            item['item_name'],
            item['item_mrp'].toString(),
            item['offer_price'].toString(),
            itemCategoryList,
            item['discount'].toString(),
            itemTagList,
            item['item_image'],
            item['stock_quantity'],
            item['item_discription'],
          );

          bool productExists =
              gridChildren.any((product) => product.id == newProduct.id);
          if (!productExists) {
            gridChildrenOld.add(newProduct);
          }
        }
        gridChildren.addAll(gridChildrenOld);
        gridChildrenOld.clear();
      }

      globalItems.assignAll(
        items.map((item) => Product(
              item['_id'].toHexString(),
              item['item_code'],
              item['item_name'],
              item['item_mrp'].toString(),
              item['offer_price'].toString(),
              List<String>.from(item['item_catogory']),
              item['discount'].toString(),
              List<String>.from(item['item_tags']),
              item['item_image'],
              item['stock_quantity'],
              item['item_discription'],
            )),
      );
    } else {
      gridChildren.clear();
      allProducts.shuffle();
      gridChildren.assignAll(allProducts);
    }
  }

  void _scrollListener() {
    // Implement scroll-based logic if needed
  }

  // void clearSearch() {
  //   searchbarController.clear();
  //   label.value = '';
  //   search.value = false;
  //   searchSuggestions.clear();
  //   gridChildren.clear();
  // }
  void clearSearch() {
  searchbarController.clear();
  label.value = '';
  search.value = false;
  searchSuggestions.clear();
  gridChildren.assignAll(allProducts); // Ensure original products are restored
  print("Cleared search. Restoring ${allProducts.length} products.");
}


  @override
  void onClose() {
    searchBarFocusNode
        .dispose(); // Dispose the focus node when controller is disposed
    super.onClose();
  }
}
