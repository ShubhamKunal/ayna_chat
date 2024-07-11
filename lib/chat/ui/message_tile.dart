import 'package:flutter/material.dart';

import 'package:ayna_chat/widgets/custom_text.dart';

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
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(8),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 229, 251, 226),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.shade300, width: 1.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 171, 175, 171),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: CustomText(text: message, size: 16),
            ),
            const SizedBox(height: 8),
          ]),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(8),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.shade300, width: 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CustomText(text: message, size: 16),
            ),
            const SizedBox(height: 8),
          ]),
          const SizedBox(),
        ],
      );
    }
  }
}
