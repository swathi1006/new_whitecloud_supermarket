import 'package:flutter/material.dart';

class ReferralCodeField extends StatelessWidget {
  final TextEditingController referralController;
  final VoidCallback onVerify;

  ReferralCodeField({
    Key? key,
    required this.referralController,
    required this.onVerify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            controller: referralController,
            style: const TextStyle(fontSize: 17),
            decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(),
              hintText: 'Referral Code (Optional)',
              counterText: '',
              suffixIcon: referralController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        referralController.clear();
                      },
                    )
                  : null,
            ),
            keyboardType: TextInputType.text,
            validator: (value) {
              return null; // Optional validation logic here if needed
            },
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: referralController.text.isNotEmpty ? onVerify : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: referralController.text.isNotEmpty
                ? Colors.blue
                : Colors.red, // Disable button if no text
          ),
          child: const Text(
            'Verify',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
