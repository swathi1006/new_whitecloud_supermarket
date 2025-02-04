

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modal/order.dart';
import '../modal/invoice.dart';
import '../modal/product.dart';
import '../modal/user_address.dart';
import 'constants.dart';
import 'global.dart';

class MongoDB {
  
  
  static Future<Map<String, dynamic>> connect() async {
    db = await Db.create(MONGO_URL);
    await db!.open();
    var collection_items = db!.collection(COLLECTION_ITEMS);
    var collection_banners = db!.collection(COLLECTION_BANNERS);
    collection_users = db!.collection('users');
    collection_agents = db!.collection('agents'); // Add agents collection
    return {
      'db': db,
      'collection_items': collection_items,
      'collection_banners': collection_banners
    };
  }


 

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
  print("Searching for: $tag");  // Log the tag being searched

  var items = await collection_items!.aggregateToStream([
    {
      '\$match': {
        'item_tags': {
          '\$regex': tag, 
          '\$options': 'i'
        }
      }
    },
    {
      '\$sample': {'size': 6}
    }
  ]).toList();

  if (items.isEmpty) {
    print("MongoDB returned 0 items for '$tag'");
  } else {
    print("MongoDB returned ${items.length} items for '$tag'");
  }

  return items;
}


  // static Future<List<Map<String, dynamic>>> getTagItems(String tag) async {
  //   var items = await collection_items!.aggregateToStream([
  //     {
  //       '\$match': {
  //         'item_tags': {
  //           '\$in': [tag]
  //         }
  //       }
  //     },
  //     {
  //       '\$sample': {'size': 6}
  //     }
  //   ]).toList();
  //   return items;
  // }

  static getItemsById(id) async {
    var items = await collection_items!.findOne(where.eq('id', id));
    return items;
  }

  
 static getuser(String phone) async {
    globalusers = (await collection_users?.findOne(where.eq('phone', phone)))!;
    UserId = globalusers['_id'].toHexString();
    UserName = globalusers['name'];
    getCart();
    getAddress();
    getOrder();
     }




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
