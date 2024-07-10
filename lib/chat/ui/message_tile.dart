import 'package:ayna_chat/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  String message;
  MessageTile({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (message.startsWith("You:")) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(),
          Column(children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 251, 226),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.shade300, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 171, 175, 171),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CustomText(text: message, size: 16),
            ),
            SizedBox(height: 8),
          ]),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.shade300, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CustomText(text: message, size: 16),
            ),
            SizedBox(height: 8),
          ]),
          SizedBox(),
        ],
      );
    }
  }
}
