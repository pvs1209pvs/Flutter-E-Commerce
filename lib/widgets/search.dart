import 'dart:developer';
import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {
  const SearchBarCustom({
    super.key,
    required this.productTitles,
    required this.onSearchSubmit,
  });

  final ValueChanged<String?> onSearchSubmit;
  final List<String> productTitles;

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      shrinkWrap: true,
      isFullScreen: true,
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
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return widget.productTitles
            .where(
              (titles) =>
                  titles.toLowerCase().contains(controller.text.toLowerCase()),
            )
            .map((item) {
              return ListTile(
                title: Text(item),
                onTap: () {
                  widget.onSearchSubmit(item);
                  controller.closeView(item);
                },
              );
            });
      },
    );
  }
}
