import 'dart:developer';

import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({super.key, required this.onSearchSubmit});

  final ValueChanged<String?> onSearchSubmit;

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      shrinkWrap: true,
      isFullScreen: false,
      viewOnSubmitted: (String text) {
        widget.onSearchSubmit(text);
      },
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onTap: () {
            controller.openView();
          },
          onChanged: (String text) {
            // controller.openView();
          },
          onSubmitted: (String text) {
            controller.closeView(null);
            FocusScope.of(context).unfocus();
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        // return <Widget>[];
        return List<ListTile>.generate(2, (int index) {
          final String item = 'gold';
          return ListTile(
            title: Text(item),
            onTap: () {
              log("Suggestions on tap: $item");
              widget.onSearchSubmit(item);
              controller.closeView(item);
              FocusScope.of(context).unfocus();

              // setState(() {
              // controller.closeView(item);
              // });
            },
          );
        });
      },
    );
  }
}
