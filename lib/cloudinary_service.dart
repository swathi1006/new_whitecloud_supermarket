import 'dart:io';

import 'package:cloudinary/cloudinary.dart';

class CloudinaryService {
  final cloudinary = Cloudinary.signedConfig(
    cloudName: 'your_cloud_name', // Replace with your Cloudinary cloud name
    apiKey: '951487944391241', // Replace with your Cloudinary API key
    apiSecret: 'your_api_secret', // Replace with your Cloudinary API secret
  );

  Future<String> uploadImage(File imageFile) async {
    try {
      final response = await cloudinary.upload(
        file: imageFile.path,
        fileBytes: imageFile.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: 'uploads', // Optional: Organize files into folders
      );

      if (response.isSuccessful) {
        return response.secureUrl!; // Return the uploaded image URL
      } else {
        throw Exception('Failed to upload image: ${response.error}');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}