import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whitesupermarketapp/modal/product.dart';
import 'package:whitesupermarketapp/controller/cart_controller.dart';
import '../database/global.dart';
import '../database/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'home_controller.dart';

class ItemViewController extends GetxController {
  final CartController cartController = Get.put(CartController());
  final HomeController homeController = Get.put(HomeController());

  RxList<Product> get products => homeController.products;
  final ScrollController scrollController = ScrollController();
  RxList<Product> gridChildren = RxList.empty();
  RxList<Product> gridChildrenOld = RxList.empty();
  bool nextScroll = true;
  RxBool isAddressSaved = true.obs;
  RxBool token = false.obs;
  RxDouble bottomBarHeight = RxDouble(60);
  Rx<Product?> selectedProduct = Rx(null);
  Map<String, dynamic> address = {
    "line1": "Prasanna",
    "line2": "Kundani, Attappilly",
    "pincode": "280319",
  };

  @override
  void onInit() async{
    getProducts();
    addCartItems();
    super.onInit();
    //ever(selectedProduct, handleProductChange);
  }



  void handleProductChange(Product? product) {
    if (product != null) {
      sortByTags(product.tags);
    }
  }

  void loadToCart() {
    for (var item in globalcart) {
      Product? productData = products.firstWhere((product) => product.id == item['id']);
      if (productData != null && productData.instock_outstock_indication>=item['count']) {
        cartController.addData(productData, item['count']);
        //print(productData.item_name);
      }
    }
  }

  addCartItems() async {
    for (var CartItems in globalcart) {
      var item = await collection_items!.findOne(where.eq('_id', ObjectId.parse(CartItems['id'])));
      if (item != null && item['stock_quantity']>0) {
        List<String> itemCategoryList=[];
        for(var itemCategory in item['item_catogory']) {
          itemCategoryList.add(itemCategory);
        }
        List<String> itemTagList=[];
        for(var itemTags in item['item_tags']) {
          itemTagList.add(itemTags);
        }
        //print(item['item_name']);
        products.add(
          Product(
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
          ),
        );
      }}
    loadToCart();
  }

  getProducts() async {
    gridChildren.clear();
    for (var item in globalitems) {
      List<String> itemCategoryList=[];
      for(var itemCategory in item['item_catogory']) {
        itemCategoryList.add(itemCategory);
      }
      List<String> itemTagList=[];
      for(var itemTag in item['item_tags']) {
        itemTagList.add(itemTag);
      }
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
      bool productExists = products.any((product) =>
      product.id == newProduct.id);
      if (!productExists) {
        products.add(newProduct);
      }
      //print(products);
    }

    //print(products.length);
    products.forEach((product) {
      //print(product.item_name);
    });
    //products.refresh();
    scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    // print(scrollController.position.pixels);

    if (scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      final extentAfter = scrollController.position.extentAfter;
      if (extentAfter < (scrollController.position.minScrollExtent + 200)) {
        addNewProductsToList();
      }
    } else {
      final extentBefore = scrollController.position.extentBefore;
      if (extentBefore < (scrollController.position.maxScrollExtent )) {
        // mainScrollController.animateTo(mainScrollController.offset+extentBefore, duration: const Duration(milliseconds: 100), curve: Curves.linear);
        // mainScrollController.

        // mainScrollController.jumpTo(mainScrollController.offset + productScrollController.position.extentAfter);
      }
      //print('scroll up');
    }
  }
/*
  _scrollListener() {
    if (nextScroll) {
      //print('position:${scrollController.offset}');
      //print('Height:${Get.height}');
      if(scrollController.offset>=Get.height){
        if(bottomBarHeight.value!=0){
          bottomBarHeight.value=0;
        }
      }else{
        if(bottomBarHeight.value!=60){
          bottomBarHeight.value=60;
        }
      }
      var pos = scrollController.position.pixels;
      var maxPos = scrollController.position.maxScrollExtent - 50;
      if (pos > maxPos) {
        addNewProductsToList();
      }
    }
  }*/

  addNewProductsToList() async {
    for (var item in globalitems) {
      List<String> itemCategoryList=[];
      for(var itemCategory in item['item_catogory']) {
        itemCategoryList.add(itemCategory);
      }
      List<String> itemTagList=[];
      for(var itemTag in item['item_tags']) {
        itemTagList.add(itemTag);
      }
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
      bool productExists = products.any((product) =>
      product.id == newProduct.id);
      if (!productExists) {
        products.add(newProduct);
      }
      //print(newProduct.item_name);
    }
  }

  sortByTags(List<String> tags) async{
    //gridChildren.clear();
    if (token.value) {
      for (var tag in tags) {
        //print(tag);
        var items = await MongoDB.getTagItems(tag);
        for (var item in items) {
          if (item['item_tags'].contains(tag)){
            List<String> itemCategoryList = [];
            for (var itemCategory in item['item_catogory']) {
              itemCategoryList.add(itemCategory);
            }
            List<String> itemTagList = [];
            for (var itemTag in item['item_tags']) {
              itemTagList.add(itemTag);
            }
            //print(';;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;');
            //print(item['item_name']);

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
            bool productExists = gridChildren.any((product) =>
            product.id == newProduct.id);
            if (!productExists) {
              gridChildren.add(newProduct);
            }
          }//print(gridChildren.length);
        }

      }

    }//products.sort((a, b) => b.tags.toSet().intersection(tags.toSet()).length.compareTo(a.tags.toSet().intersection(tags.toSet()).length));
    await fetchOtherProducts(category);
  }

  Future<void> fetchOtherProducts(String category) async {
    globalitems = await MongoDB.getNonCategoryItems(category); // New DB query
    for (var item in globalitems) {
      if (!item['item_catogory'].contains(category)) {
        List<String> itemCategoryList = item['item_catogory'].cast<String>();
        List<String> itemTagList = item['item_tags'].cast<String>();

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
        if (!gridChildren.any((product) => product.id == newProduct.id)) {
          gridChildrenOld.add(newProduct);
        }
      }
    }
  }


  shareApp() {
    Share.share('Check out this app https://example.com');
  }

  callHelp() async {
    if (!await launchUrl(Uri.parse('tel:+9181380 66143'))) {
      throw 'Could not launch tel:+918138066143';
    }
  }

  /// Fetches product details by `itemCode`, sets `selectedProduct`, and returns true if successful.
  Future<bool> fetchAndSetProductByItemCode(String itemCode) async {
    try {
      var item = await collection_items!.findOne(where.eq('item_code', itemCode));
      if (item != null) {
        List<String> itemCategoryList = [];
        for (var itemCategory in item['item_catogory']) {
          itemCategoryList.add(itemCategory);
        }
        List<String> itemTagList = [];
        for (var itemTags in item['item_tags']) {
          itemTagList.add(itemTags);
        }

        // Create a new Product instance
        Product product = Product(
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

        // Set the selected product
        selectedProduct.value = product;
        return true;
      } else {
        return false; // Product not found
      }
    } catch (e) {
      print("Error fetching product: $e");
      return false; // Error occurred
    }
  }

}
