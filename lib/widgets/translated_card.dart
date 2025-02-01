import 'package:flutter/material.dart';
import 'package:whitesupermarketapp/util/colors.dart';

class TranslationCard extends StatefulWidget {
  const TranslationCard({super.key});

  @override
  _TranslationCardState createState() => _TranslationCardState();
}

class _TranslationCardState extends State<TranslationCard> {
  bool isTranslated = false; // Track if the text is translated
  String translatedText = 'You can order by uploading your list';
  String originalText =
      'നിങ്ങളുടെ ലിസ്റ്റ് അപ്‌ലോഡ് ചെയ്തുകൊണ്ട് നിങ്ങൾക്ക് ഓർഡർ ചെയ്യാവുന്നതാണ്'; // Replace with your translated text

  void _toggleTranslation() {
    setState(() {
      isTranslated =
          !isTranslated; // Toggle between translated and original text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Text(
              isTranslated
                  ? translatedText
                  : originalText, // Display translated or original text
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 10), // Add some spacing

        TextButton(
          onPressed: _toggleTranslation, // Trigger translation toggle
          style: TextButton.styleFrom(
            foregroundColor: primary, // Text color
            padding: const EdgeInsets.symmetric(
                horizontal: 30, vertical: 15), // Button padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),

          ),
          child: Text(
            isTranslated ? 'Show Original' : 'Translate 👆',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              // decoration: TextDecoration.underline, // Optional: Add underline
            ),
          ),
        ),

      ],
    );
  }
}
