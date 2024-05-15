import 'package:flutter/material.dart';

import '../view_model/place_view_model.dart';

class PlaceWidget extends StatelessWidget {
  const PlaceWidget({
    super.key,
    required this.title,
    required this.address,
    this.onPress,
    required this.placeVM,
  });
  final PlaceViewModel placeVM;
  final String title;
  final String address;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined),
          Expanded(
            child: ListTile(
              title: _highlightKeywords(title, placeVM.placeController.text),
              subtitle: _highlightKeywords(address, placeVM.placeController.text),

            ),
          ),
          IconButton(
              onPressed: onPress,
              icon: Icon(Icons.directions))
        ],
      ),
    );
  }
}
RichText _highlightKeywords(String text, String keyword) {
  if (keyword.isEmpty) {
    return RichText(
      text: TextSpan(text: text, style: TextStyle(color: Colors.black)),
    );
  }
  final matches = RegExp(keyword, caseSensitive: false).allMatches(text);
  if (matches.isEmpty) {
    return RichText(
      text: TextSpan(text: text, style: TextStyle(color: Colors.black)),
    );
  }
  final spans = <TextSpan>[];
  var lastIndex = 0;
  for (final match in matches) {
    if (match.start > lastIndex) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex, match.start),
          style: TextStyle(color: Colors.black),
        ),
      );
    }
    spans.add(
      TextSpan(
        text: text.substring(match.start, match.end),
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    lastIndex = match.end;
  }
  if (lastIndex < text.length) {
    spans.add(
      TextSpan(
        text: text.substring(lastIndex),
        style: TextStyle(color: Colors.black),
      ),
    );
  }
  return RichText(
    text: TextSpan(children: spans),
  );
}


