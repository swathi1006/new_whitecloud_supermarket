// import 'package:mongo_dart/mongo_dart.dart';
// import '../modal/order.dart';
// import '../modal/invoice.dart';
// import '../modal/product.dart';
// import '../modal/user_address.dart';
// import 'constants.dart';
// import 'global.dart';

// class MongoDB {
//   static Future<Map<String, dynamic>> connect() async {
//     db = await Db.create(MONGO_URL);
//     await db!.open();
//     //var status = db!.serverStatus();
//     var collection_items = db!.collection(COLLECTION_ITEMS);
//     var collection_banners = db!.collection(COLLECTION_BANNERS);
//     collection_users = db!.collection('users');
//     //print('Connected to MongoDB');
//     //addUser();
//     return {
//       'db': db,
//       'collection_items': collection_items,
//       'collection_banners': collection_banners
//     };
//   }

//   static getBanners() async {
//     globalBanners = await collection_banners!.find().toList();
//     //print(globalBanners);
//   }

//   static getTags() async {
//     var collection_tags = db!.collection("tags");
//     globalTags = await collection_tags.find().toList();
//     //print(globalTags);
//   }

//   static Future<List<Map<String, dynamic>>> getItems() async {
//   var items = await collection_items!.aggregateToStream([
//     {
//       '\$sample': {
//         'size': 6
//       }
//     }
//   ]).toList();
//   return items;
// }

//   static Future<List<Map<String, dynamic>>> getCategoryItems(String category) async {
//     var items = await collection_items!.aggregateToStream([
//       {
//         '\$match': {
//           'item_catogory': {
//             '\$in': [category]
//           }
//         }
//       },
//       {
//         '\$sample': {
//           'size': 6
//         }
//       }
//     ]).toList();
//     //print(items);
//     //print('------------------------Item fetched-------------------------');
//     return items;
//   }

//   static Future<List<Map<String, dynamic>>> getTagItems(String tag) async {
//     var items = await collection_items!.aggregateToStream([
//       {
//         '\$match': {
//           'item_tags': {
//             '\$in': [tag]
//           }
//         }
//       },
//       {
//         '\$sample': {
//           'size': 6
//         }
//       }
//     ]).toList();
//     //print(items);
//     //print('------------------------Item fetched-------------------------');
//     return items;
//   }

//   static getItemsById(id) async {
//     var items = await collection_items!.findOne(where.eq('id', id));
//     //print(items);
//     //print('------------------------Item fetched-------------------------');
//     return items;
//   }

//   static getuser(String phone) async {
//     globalusers = (await collection_users?.findOne(where.eq('phone', phone)))!;
//     //print(globalusers);
//     UserId = globalusers['_id'].toHexString();
//     UserName = globalusers['name'];
//     //var usercart = globalusers['user_cart'].toList();
//     getCart();
//     getAddress();
//     getOrder();
//     //print(globalcart);
//     //print(globaladdress);
//     //print(globalorder);
//     //print(UserId);

//     //addUserOrder(order);
//     //getUserAddress(UserId);
//     //addAddress(userAddress);
//     //updateItemPrice(UserId, '1', 3.99);
//     //globalcart = await collection_users!.find().toList();
//     //var userId = ObjectId.parse('65fc3523f2e9ef7611000000');
//     //print(await collection_users?.findOne(where.eq('_id', userId)));
//     //await collection_users?.update(where.eq('_id', userId), modify.push('user_cart', {'item_id': '123', 'item_name': 'Apple', 'item_price': 1.99,}));
//   }

//   static getCart() async {
//     var usercart = (globalusers['user_cart'] ?? []).toList();
//     globalcart = usercart.cast<Map<String, dynamic>>();
//   }

//   static getAddress() async {
//     var useraddress = (globalusers['user_address'] ?? []).toList();
//     globaladdress = useraddress.cast<Map<String, dynamic>>();
//   }

//   static getOrder() async {
//     var userorder = (globalusers['user_order'] ?? []).toList();
//     globalorder = userorder.cast<Map<String, dynamic>>();
//   }

//   static Future<void> updateItemPrice(String userId, String itemId,
//       double newPrice) async {
//     //print(UserId);
//     await collection_users?.update(
//         where.eq('_id', ObjectId.parse(UserId)).eq('user_cart.item_id', itemId),
//         modify.set('user_cart.item_price', newPrice)
//     );

//     //print(updatedUser);
//     //print('Item price updated');
//   }
// }
//   Future<void> addUserAddresstoServer(UserAddress userAddress) async {
//     await collection_users?.update(
//         where.eq('_id', ObjectId.parse(UserId)), modify.push('user_address', {
//       'id': userAddress.id,
//       'name': userAddress.name,
//       'mobile': userAddress.mobile,
//       'addressLine1': userAddress.addressLine1,
//       'addressLine2': userAddress.addressLine2,
//       'state': userAddress.state,
//       'city': userAddress.city,
//       'pincode': userAddress.pincode,
//       'isDefault': userAddress.isDefault,
//     }));
//   }

//   Future<void> addCartItem(Product product) async {
//     await collection_users?.update(
//         where.eq('_id', ObjectId.parse(UserId)), modify.push('user_cart', {
//       'id': product.id,
//       'item_name': product.item_name,
//       //'item_mrp': product.item_mrp,
//       //'offer_price': product.offer_price,
//       //'discount': product.discount,
//       //'item_image': product.item_image,
//       //'instock_outstock_indication': product.instock_outstock_indication,
//       //'item_discription': product.item_discription,
//       'count': product.cartCount.value,
//     }));
//   }

// Future<void> updateCartItem(String id,int count) async {
//   var user = await collection_users?.findOne(where.eq('_id', ObjectId.parse(UserId)));
//   var cart = user?['user_cart'] as List;
//   var itemIndex = cart.indexWhere((item) => item['id'] == id);
//   cart[itemIndex]['count'] = count;
//   await collection_users?.update(where.eq('_id', ObjectId.parse(UserId)), modify.set('user_cart', cart));
// }

// Future<void> deleteCartItem(String id) async {
//   var user = await collection_users?.findOne(where.eq('_id', ObjectId.parse(UserId)));
//   var cart = user?['user_cart'] as List;
//   var itemIndex = cart.indexWhere((item) => item['id'] == id);
//   //print(itemIndex);
//   await collection_users?.update(where.eq('_id', ObjectId.parse(UserId)), modify.pull('user_cart', cart[itemIndex]));
// }
// Future<void> deleteCartItems() async {
//   await collection_users?.update(
//       where.eq('_id', ObjectId.parse(UserId)),
//       modify.set('user_cart', [])
//   );
//   //print('Cart emptied');
// }

//   Future<void> addUserOrder(Order order) async {
//     List<Map<String, dynamic>> items = order.items.map((item) =>
//     {
//       'itemId': item.itemId,
//       'itemName': item.itemName,
//       'itemImage': item.itemImage,
//       'count': item.count,
//       'price': item.price,
//     }).toList();
//     await collection_users?.update(
//         where.eq('_id', ObjectId.parse(UserId)), modify.push('user_order', {
//       'id': order.id,
//       'orderDate': order.orderDate,
//       'status': order.status,
//       'orderValue': order.orderValue,
//       'items': items,
//     }));
//   }

//   Future<void> addOrderInvoice(Invoice invoice) async {
//     collection_invoice = db!.collection("invoices");
//     List<Map<String, dynamic>> itemInvoice = invoice.itemInvoice.map((item) =>
//     {
//       'item_code': item.itemId,
//       'item_code': item.itemCode,
//       'item_name': item.itemName,
//       'item_mrp': item.price,
//       'offer_price': item.offerPrice,
//       'discount': item.discount,
//       'count': item.count,
//     }).toList();
//     await collection_invoice?.insert({
//       'order_id': invoice.id,
//       'cx_id': invoice.userId,
//       'cx_name': invoice.userName,
//       'cx_phone_number': invoice.mobile,
//       'cx_address': invoice.address,
//       'order_status': invoice.status,
//       'order_date': invoice.orderDate,
//       'oba': invoice.orderValue,
//       'payment_mode': invoice.paymentMode,
//       'item_details': itemInvoice,
//     });
//   }

// Future<void> qupdateCartItem(String id,int count) async {
//   var user = await collection_users?.findOne(where.eq('_id', ObjectId.parse(UserId)));
//   var cart = user?['user_cart'] as List;
//   var itemIndex = cart.indexWhere((item) => item['id'] == id);
//   cart[itemIndex]['count'] = count;
//   await collection_users?.update(where.eq('_id', ObjectId.parse(UserId)), modify.set('user_cart', cart));
// }

//   Future<void> cancelOrder(String orderId) async {
//     var user = await collection_users?.findOne(where.eq('_id', ObjectId.parse(UserId)));
//     var order = user?['user_order'] as List;
//     var itemIndex = order.indexWhere((item) => item['id'] == orderId);
//     order[itemIndex]['status'] = 'Cancelled';
//     await collection_users?.update(where.eq('_id', ObjectId.parse(UserId)), modify.set('user_order', order));

//     collection_invoice = db!.collection("invoices");
//     await collection_invoice?.update(
//         where.eq('order_id', orderId),
//         modify.set('order_status', 'Cancelled')
//     );
//     await MongoDB.getOrder();
//   }

// Future<void> addUser(String name, String mobile) async {
//   await collection_users?.insert({
//     'phone': mobile,
//     'name': name,
//     'created_at': DateTime.now().toUtc(),
//   });
// }

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modal/order.dart';
import '../modal/invoice.dart';
import '../modal/product.dart';
import '../modal/user_address.dart';
import 'constants.dart';
import 'global.dart';

class MongoDB {
  
  // static Future<Map<String, dynamic>> connect() async {
  //   db = await Db.create(MONGO_URL);
  //   await db!.open();
  //   var collection_items = db!.collection(COLLECTION_ITEMS);
  //   var collection_banners = db!.collection(COLLECTION_BANNERS);
  //   collection_users = db!.collection('users');
  //   collection_agents = db!.collection('agents'); // Add agents collection
  //   return {
  //     'db': db,
  //     'collection_items': collection_items,
  //     'collection_banners': collection_banners
  //   };
  // }
   static Future<Map<String, dynamic>?> connect() async {
    try {
      db = await Db.create(MONGO_URL);
      await db!.open();
      
      collection_items = db!.collection(COLLECTION_ITEMS);
      collection_banners = db!.collection(COLLECTION_BANNERS);
      collection_users = db!.collection('users');
      collection_agents = db!.collection('agents'); // Add agents collection

       print('MongoDB connection successful!');

      return {
        'db': db,
        'collection_items': collection_items,
        'collection_banners': collection_banners,
      };
    } catch (e) {
      print('Error connecting to MongoDB: $e');
      return null;
    }
  }

  // // Other methods (unchanged)
  // static getBanners() async {
  //   globalBanners = await collection_banners!.find().toList();
  // }

  static Future<void> getBanners() async {
  try {
    print('Fetching banners from MongoDB...');
    
    // Fetch all banners from the collection
    globalBanners = await collection_banners!.find().toList();
    
    // Log the number of banners fetched
    print('Number of banners fetched: ${globalBanners.length}');
    
    // Log the banner data for debugging
    if (globalBanners.isNotEmpty) {
      globalBanners.forEach((banner) {
        print('Banner: ${banner['banner_img']}');
      });
    } else {
      print('No banners found in the collection.');
    }
  } catch (e) {
    // Log any errors during the fetching process
    print('Error fetching banners: $e');
  }
}


  static getTags() async {
    var collection_tags = db!.collection("tags");
    globalTags = await collection_tags.find().toList();
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    var items = await collection_items!.aggregateToStream([
      {
        '\$sample': {'size': 6}
      }
    ]).toList();
    return items;
  }



  // static Future<List<Map<String, dynamic>>> getCategoryItems(
  //     String category) async {
  //   var items = await collection_items!.aggregateToStream([
  //     {
  //       '\$match': {
  //         'item_catogory': {
  //           '\$in': [category]
  //         }
  //       }
  //     },
  //     {
  //       '\$sample': {'size': 6}
  //     }
  //   ]).toList();
  //   return items;
  // }
  //new one below

  static Future<List<Map<String, dynamic>>> getCategoryItems(
      String category) async {
    var items = await collection_items!.aggregateToStream([
      {
        '\$match': {
          'item_catogory': {
            '\$in': [category]
          }
        }
      },
      // {
        // '\$sample': {'size': 6},
        // '\$limit':17
      // }
    ]).toList();
    return items;
  }

  static Future<List<Map<String, dynamic>>> getNonCategoryItems(
      String category) async {
    var items = await collection_items!.aggregateToStream([
      {
        '\$match': {
         'item_catogory': {
          '\$not': {'\$in': [category]}
        }
        }
      },
      {
        '\$sample': {'size': 6},
      }
    ]).toList();
    // print('Non-category items: ${items.length}');
    return items;
}

  static Future<List<Map<String, dynamic>>> getTagItems(String tag) async {
    var items = await collection_items!.aggregateToStream([
      {
        '\$match': {
          'item_tags': {
            '\$in': [tag]
          }
        }
      },
      {
        '\$sample': {'size': 6}
      }
    ]).toList();
    return items;
  }

  static getItemsById(id) async {
    var items = await collection_items!.findOne(where.eq('id', id));
    return items;
  }

  // static getuser(String phone) async {
  //   globalusers = (await collection_users?.findOne(where.eq('phone', phone)))!;
  //   UserId = globalusers['_id'].toHexString();
  //   UserName = globalusers['name'];

  //    // Save username to SharedPreferences
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // await prefs.setString('username', UserName);

  // print('User fetched from DB: ${globalusers['name']}');

  //   getCart();
  //   getAddress();
  //   getOrder();
  // }

  // testing one below
  static Future<void> getuser(String phone) async {
  try {
    print('Fetching user from database for phone: $phone'); // Debug log

    // Query the database
    globalusers = (await collection_users?.findOne(where.eq('phone', phone)))!;
    UserId = globalusers['_id'].toHexString();
    UserName = globalusers['name'];

    // Save username to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', UserName);

    print('User fetched from DB: $UserName'); // Log user name
    print('User ID: $UserId'); // Log user ID

    // Fetch other data
    await getCart();
    await getAddress();
    await getOrder();
  } catch (e) {
    print('Error in getuser: $e'); // Log any error
  }
}



















// static Map<String, dynamic> globalusers = {}; // Initialize as an empty map

// static Future<void> getuser(String phone) async {
//   try {
//     // Ensure the collection is not null
//     if (collection_users == null) {
//       throw Exception("Database collection 'collection_users' is null. Check your MongoDB connection.");
//     }

//     // Query the user based on the phone number
//     var result = await collection_users?.findOne(where.eq('phone', phone));

//     // Handle case where no user is found
//     if (result == null) {
//       throw Exception("No user found with phone number: $phone");
//     }

//     // Assign global user data
//     globalusers = result;
//     UserId = globalusers['_id']?.toHexString() ?? "Unknown User ID";
//     UserName = globalusers['name'] ?? "Unknown User";

//     // Call dependent functions safely
//     getCart();
//     getAddress();
//     getOrder();
//   } catch (e) {
//     // Log and handle the error gracefully
//     print("Error in getuser: $e");

//     // Reset global variables to avoid using invalid data
//     globalusers = {}; // Clear the map safely by reinitializing
//     UserId = "Unknown";
//     UserName = "Unknown";
//   }
// }

//testing one below
// static Map<String, dynamic> globalusers = {}; // Initialize as an empty map

// static Future<void> getuser(String phone) async {
//   try {
//     // Ensure the collection is not null
//     if (collection_users == null) {
//       throw Exception("Database collection 'collection_users' is null. Check your MongoDB connection.");
//     }

//     // Query the user based on the phone number
//     var result = await collection_users?.findOne(where.eq('phone', phone));

//     // Handle case where no user is found
//     if (result == null) {
//       throw Exception("No user found with phone number: $phone");
//     }

//     // Assign global user data
//     globalusers = result;
//     UserId = globalusers['_id']?.toHexString() ?? "Unknown User ID";
//     UserName = globalusers['name'] ?? "Unknown User";

//     // Call dependent functions safely
//     await getCart();
//     await getAddress();
//     await getOrder();
//   } catch (e) {
//     // Log and handle the error gracefully
//     print("Error in getuser: $e");

//     // Reset global variables to avoid using invalid data
//     globalusers = {}; // Clear the map safely by reinitializing
//     UserId = "Unknown";
//     UserName = "Unknown";
//   }
// }



  static getCart() async {
    var usercart = (globalusers['user_cart'] ?? []).toList();
    globalcart = usercart.cast<Map<String, dynamic>>();
  }

  static getAddress() async {
    var useraddress = (globalusers['user_address'] ?? []).toList();
    globaladdress = useraddress.cast<Map<String, dynamic>>();
  }

  static getOrder() async {
    var userorder = (globalusers['user_order'] ?? []).toList();
    globalorder = userorder.cast<Map<String, dynamic>>();
  }

  static Future<void> updateItemPrice(
      String userId, String itemId, double newPrice) async {
    await collection_users?.update(
        where.eq('_id', ObjectId.parse(UserId)).eq('user_cart.item_id', itemId),
        modify.set('user_cart.item_price', newPrice));
  }
}

Future<void> addUserAddressToServer(UserAddress userAddress) async {
  await collection_users?.update(
      where.eq('_id', ObjectId.parse(UserId)),
      modify.push('user_address', {
        'id': userAddress.id,
        'name': userAddress.name,
        'mobile': userAddress.mobile,
        'addressLine1': userAddress.addressLine1,
        'addressLine2': userAddress.addressLine2,
        'state': userAddress.state,
        'city': userAddress.city,
        'pincode': userAddress.pincode,
        'isDefault': userAddress.isDefault,
      }));
}

Future<void> addCartItem(Product product) async {
  await collection_users?.update(
      where.eq('_id', ObjectId.parse(UserId)),
      modify.push('user_cart', {
        'id': product.id,
        'item_name': product.item_name,
        'count': product.cartCount.value,
      }));
}

Future<void> updateCartItem(String id, int count) async {
  var user =
      await collection_users?.findOne(where.eq('_id', ObjectId.parse(UserId)));
  var cart = user?['user_cart'] as List;
  var itemIndex = cart.indexWhere((item) => item['id'] == id);
  cart[itemIndex]['count'] = count;
  await collection_users?.update(
      where.eq('_id', ObjectId.parse(UserId)), modify.set('user_cart', cart));
}

Future<void> deleteCartItem(String id) async {
  var user =
      await collection_users?.findOne(where.eq('_id', ObjectId.parse(UserId)));
  var cart = user?['user_cart'] as List;
  var itemIndex = cart.indexWhere((item) => item['id'] == id);
  await collection_users?.update(where.eq('_id', ObjectId.parse(UserId)),
      modify.pull('user_cart', cart[itemIndex]));
}

Future<void> deleteCartItems() async {
  await collection_users?.update(
      where.eq('_id', ObjectId.parse(UserId)), modify.set('user_cart', []));
}

Future<void> addUserOrder(Order order) async {
  List<Map<String, dynamic>> items = order.items
      .map((item) => {
            'itemId': item.itemId,
            'itemName': item.itemName,
            'itemImage': item.itemImage,
            'count': item.count,
            'price': item.price,
          })
      .toList();
  await collection_users?.update(
      where.eq('_id', ObjectId.parse(UserId)),
      modify.push('user_order', {
        'id': order.id,
        'orderDate': order.orderDate,
        'status': order.status,
        'orderValue': order.orderValue,
        'items': items,
      }));
}



Future<void> addOrderInvoice(Invoice invoice) async {
  collection_invoice = db!.collection("invoices");
  List<Map<String, dynamic>> itemInvoice = invoice.itemInvoice
      .map((item) => {
            'item_code': item.itemCode,
            'item_name': item.itemName,
            'item_mrp': item.price,
            'offer_price': item.offerPrice,
            'discount': item.discount,
            'count': item.count,
          })
      .toList();
  await collection_invoice?.insert({
    'order_id': invoice.id,
    'cx_id': invoice.userId,
    'cx_name': invoice.userName,
    'cx_phone_number': invoice.mobile,
    'cx_address': invoice.address,
    'order_status': invoice.status,
    'order_date': invoice.orderDate,
    'oba': invoice.orderValue,
    'payment_mode': invoice.paymentMode,
    'item_details': itemInvoice,
  });
}

Future<void> cancelOrder(String orderId) async {
  var user =
      await collection_users?.findOne(where.eq('_id', ObjectId.parse(UserId)));
  var order = user?['user_order'] as List;
  var itemIndex = order.indexWhere((item) => item['id'] == orderId);
  order[itemIndex]['status'] = 'Cancelled';
  await collection_users?.update(
      where.eq('_id', ObjectId.parse(UserId)), modify.set('user_order', order));

  collection_invoice = db!.collection("invoices");
  await collection_invoice?.update(
      where.eq('order_id', orderId), modify.set('order_status', 'Cancelled'));
  await MongoDB.getOrder();
}

// Add User with Referral Code Logic
Future<void> addUser({
  required String name,
  required String mobile,
  String? referralCode,
}) async {
  try {
    // Insert user into 'users' collection
    var newUser = await collection_users?.insertOne({
      'phone': mobile,
      'name': name,
      'created_at': DateTime.now().toUtc(),
    });

    // Check if referral code is provided and valid
    if (newUser?.isSuccess == true &&
        referralCode != null &&
        referralCode.isNotEmpty) {
      var agent =
          await collection_agents?.findOne({'referralCode': referralCode});

      if (agent != null) {
        // Add new user's ID to the agent's accountsCreated field
        await collection_agents?.updateOne(
          {'_id': agent['_id']},
          {
            r'$push': {
              'accountsCreated': newUser?.document?['_id'],
            },
          },
        );
      }
    }
  } catch (e) {
    print('Error while adding user: $e');
  }
}
