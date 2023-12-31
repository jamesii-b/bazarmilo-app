
import 'package:flutter/material.dart';

Future<dynamic> displayPrompt(
    BuildContext context, String titleData, String contentData) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(titleData,
            style: TextStyle(
                color: const Color(0xffFF8D83),
                fontSize: 17.25,
                fontFamily: 'Arbutus Slab')),
        content: Text(contentData,
            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6))),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK',
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 0.85),
              ),
            ),
          ),
        ],
      );
    },
  );
}
