import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import '../database/constants.dart';

class ReferralCodeField extends StatefulWidget {
  final TextEditingController referralController;
  final Function(bool) onReferralVerified;

  const ReferralCodeField({
    super.key,
    required this.referralController, required this.onReferralVerified,
  });

  @override
  _ReferralCodeFieldState createState() => _ReferralCodeFieldState();
}

class _ReferralCodeFieldState extends State<ReferralCodeField> {
  bool isVerified = false;
  bool result = false;

  @override
  void initState() {
    super.initState();

    // Add listener to referralController
    widget.referralController.addListener(() {
      setState(() {}); // Trigger rebuild when text changes
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    widget.referralController.removeListener(() {});
    super.dispose();
  }

  Future<bool> verifyReferralCode(BuildContext context) async {
    final db = await mongo.Db.create(MONGO_URL);
    await db.open();

    final agentsCollection = db.collection('agents');
    final referralCode = widget.referralController.text.trim();

    final agent = await agentsCollection.findOne({'referralCode': referralCode});
    await db.close();

    if (agent != null) {
      // Referral code exists
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text('Referral code verified!'),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } else {
      // Referral code doesn't exist
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid referral code!'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            controller: widget.referralController,
            style: const TextStyle(fontSize: 17),
            decoration: InputDecoration(
              isDense: true,
              border: const OutlineInputBorder(),
              hintText: 'Referral Code (Optional)',
              counterText: '',
              suffixIcon: widget.referralController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          widget.referralController.clear();
                          isVerified = false; // Reset verification state
                        });
                      },
                    )
                  : null,
            ),
            keyboardType: TextInputType.text,
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: widget.referralController.text.isNotEmpty
              ? () async {
                  result = await verifyReferralCode(context);
                  setState(() {
                    isVerified = result;
                  });
                  widget.onReferralVerified(result); // Invoke the callback
                }
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: isVerified ? Colors.green : Colors.blue,
          ),
          child: Text(
            isVerified ? 'Verified' : 'Verify',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}


// class _ReferralCodeFieldState extends State<ReferralCodeField> {
//   bool isVerified = false;
//   bool result = false;

//   Future<bool> verifyReferralCode(BuildContext context) async {
//     final db = await mongo.Db.create(MONGO_URL);
//     await db.open();

//     final agentsCollection = db.collection('agents');
//     final referralCode = widget.referralController.text.trim();

//     final agent = await agentsCollection.findOne({'referralCode': referralCode});
//     await db.close();

//     if (agent != null) {
//       // Referral code exists
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Row(
//             children: [
//               Icon(Icons.check_circle, color: Colors.green),
//               SizedBox(width: 8),
//               Text('Referral code verified!'),
//             ],
//           ),
//           backgroundColor: Colors.green,
//         ),
//       );
//       return true;
//     } else {
//       // Referral code doesn't exist
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Invalid referral code!'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Expanded(
//           child: TextFormField(
//             controller: widget.referralController,
//             style: const TextStyle(fontSize: 17),
//             decoration: InputDecoration(
//               isDense: true,
//               border: const OutlineInputBorder(),
//               hintText: 'Referral Code (Optional)',
//               counterText: '',
//               suffixIcon: widget.referralController.text.isNotEmpty
//                   ? IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: () {
//                   setState(() {
//                     widget.referralController.clear();
//                     isVerified = false; // Reset verification state
//                   });
//                 },
//               )
//                   : null,
//             ),
//             keyboardType: TextInputType.text,
//           ),
//         ),
//         const SizedBox(width: 10),
//         ElevatedButton(
//           onPressed: widget.referralController.text.isNotEmpty
//               ? () async {
//             //print('referral widget result1 = $result');
//              result = await verifyReferralCode(context);
//             //print('referral widget result2 = $result');
//             setState(() {
//               isVerified = result;
//             });
//             widget.onReferralVerified(result); // Invoke the callback
//           }
//               : null,
//           style: ElevatedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//             backgroundColor: isVerified ? Colors.green : Colors.blue,
//           ),
//           child: Text(
//             isVerified ? 'Verified' : 'Verify',
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
