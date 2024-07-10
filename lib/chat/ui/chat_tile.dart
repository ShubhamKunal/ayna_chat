// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:ayna_chat/widgets/custom_text.dart';

class ChatTile extends StatelessWidget {
  String receiver;
  final VoidCallback onTap;
  ChatTile({
    super.key,
    required this.receiver,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [CustomText(text: receiver, size: 18)],
          ),
        ));
  }
}
