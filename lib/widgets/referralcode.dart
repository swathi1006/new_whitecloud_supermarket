import 'package:flutter/material.dart';

class ReferralCodeField extends StatelessWidget {
  final TextEditingController referralController;

  ReferralCodeField({Key? key, required this.referralController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: referralController,
      style: const TextStyle(fontSize: 17),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(),
        hintText: 'Enter Referral Code (Optional)',
        counterText: '',
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        // Optional field: no validation needed unless you decide to add specific checks later.
        return null;
      },
    );
  }
}
