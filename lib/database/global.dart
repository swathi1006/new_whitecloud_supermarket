import 'package:mongo_dart/mongo_dart.dart';

Db? db;
DbCollection? collection_items;
DbCollection? collection_banners;
DbCollection? collection_users;
DbCollection? collection_invoice;
DbCollection? collection_agents;
List<Map<String, dynamic>> globalBanners = [];
List<Map<String, dynamic>> globalitems = [];
List<Map<String, dynamic>> globalTags = [];
List<Map<String, dynamic>> globalAgents = [];

//List<Map<String, dynamic>> globalusers = [];
Map<String, dynamic> globalusers = {};
List<Map<String, dynamic>> globalcart = [];
var totalItems = 0;
List<Map<String, dynamic>> globaladdress = [];
List<Map<String, dynamic>> globalorder = [];
String UserId = '';
String UserName = '';
String phone = '';
String category= '';

