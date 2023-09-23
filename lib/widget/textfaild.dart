import 'package:flutter/material.dart';

class TextFaildWidget extends StatelessWidget {
   const TextFaildWidget(
      {super.key, required this.hintText, required this.maxLine, required this.textController});

  final String hintText;
  final int maxLine;
  final TextEditingController  textController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey.shade100, borderRadius: BorderRadius.circular(9)),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hintText),
        maxLines: maxLine,
      ),
    );
  }
}
