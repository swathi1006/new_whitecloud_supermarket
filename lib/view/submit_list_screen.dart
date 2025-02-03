import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whitesupermarketapp/cloudinary_service.dart';
import 'package:whitesupermarketapp/util/colors.dart';
import 'package:whitesupermarketapp/widgets/translated_card.dart';

class SubmitListScreen extends StatefulWidget {
  const SubmitListScreen({super.key});

  @override
  State<SubmitListScreen> createState() => _SubmitListScreenState();
}

class _SubmitListScreenState extends State<SubmitListScreen> {
  // Variable for animation
  bool _isTapped = false;

 

void _pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: source);

  if (image != null) {
    _showImageDialog(File(image.path)); // Show dialog with selected image
  } else {
    Get.snackbar('Error', 'No image selected');
  }
}


void _showImageDialog(File imageFile) {
  final CloudinaryService _cloudinaryService = CloudinaryService();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          'Preview Your List',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, // Prevents infinite height issue
          children: [
            SizedBox(
              width: 250, // Set a fixed width
              height: 250, // Set a fixed height
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop(); // Close the dialog

              try {
                // Upload the image to Cloudinary
                final imageUrl = await _cloudinaryService.uploadImage(imageFile);
                print('Image uploaded successfully: $imageUrl');

                // Store the image URL in MongoDB
                // await storeImageURLInMongoDB(imageUrl);

                // Show success message
                Get.snackbar(
                  'Success',
                  "Thank you for submitting your list, we'll check and contact you as soon as possible.",
                  // backgroundColor: primary.withOpacity(0.2),
                  snackPosition: SnackPosition.TOP,
                  duration: const Duration(seconds: 3),
                );
              } catch (e) {
                print('Error uploading image: $e');

                // Show error message
                Get.snackbar(
                  'Error',
                  'Failed to upload image. Please try again.',
                  backgroundColor: Colors.red.withOpacity(0.2),
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 3),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
            ),
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}


  // Function to show options for camera or gallery
void _showImagePickerOptions() {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Make the background transparent
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Choose an Option',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const Divider(height: 1, color: Colors.grey),

              // Camera Option
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: primary
                  ),
                ),
                title: Text(
                  'Take a Photo',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _pickImage(ImageSource.camera);
                },
              ),

              // Gallery Option
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.photo_library,
                    color: Color.fromARGB(255, 66, 132, 68),
                  ),
                ),
                title: Text(
                  'Choose from Gallery',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _pickImage(ImageSource.gallery);
                },
              ),

              // Cancel Button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Remove AppBar shadow
        backgroundColor: white,
        toolbarHeight: 40,
      ),
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Submit Your List',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              // Image at the top with a gap from the AppBar
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 233, 229, 229)
                            .withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/shopping list.png',
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // Gap between image and text
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              // Gap between text and card
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              // Card with text
              const TranslationCard(),

              // Gap between card and camera icon
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),

              // Camera Icon with animation
              IconButton(
                icon: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform:
                      _isTapped ? Matrix4.rotationZ(0.1) : Matrix4.identity(),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: primary, // Background color for the icon
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isTapped = !_isTapped;
                  });
                  _showImagePickerOptions(); // Show camera/gallery options
                },
              ),

              // Gap between camera icon and submit button
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

              // Submit Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity, // Full width
                  child: ElevatedButton(
                    onPressed: () {
                      _showImagePickerOptions();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary, // Button background color
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text(
                      'Take your list',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // Bottom gap for better spacing
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}