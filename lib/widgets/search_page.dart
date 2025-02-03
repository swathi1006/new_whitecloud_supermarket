import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whitesupermarketapp/util/colors.dart';
import 'package:whitesupermarketapp/view/submit_list_screen.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: white),
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          children: [
            // Search TextField
            Expanded(
              child: Container(
                height: 40,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                child: TextField(
                  autofocus: true,
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    hintText: 'Search WhiteApp',
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40),
            // Custom Icon Outside the TextField
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
        ),
      ),
      body: const Center(
        child: Text('Search Results Here'),
      ),
    );
  }
}
