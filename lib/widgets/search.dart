import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/providers/products_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBarCustom extends ConsumerStatefulWidget {
  const SearchBarCustom({super.key});

  @override
  ConsumerState<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends ConsumerState<SearchBarCustom> {
  @override
  Widget build(BuildContext context) {
    var allProducts = ref.watch(productProvider);

    return allProducts.when(
      loading: () => Placeholder(),
      error: (e, _) => Text(e.toString()),
      data: (data) => SearchAnchor(
        shrinkWrap: true,
        isFullScreen: true,
        viewOnSubmitted: (String text) {
          ref.read(searchQueryNotifierProvider.notifier).updateQuery(text);
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
              ref.read(searchQueryNotifierProvider.notifier).updateQuery(text);
              controller.openView();
            },
            onSubmitted: (String text) {
              ref.read(searchQueryNotifierProvider.notifier).updateQuery(text);
            },
            leading: const Icon(Icons.search),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
              return data
                  .map((product) => product.title)
                  .where(
                    (title) => title.toLowerCase().contains(
                      controller.text.toLowerCase(),
                    ),
                  )
                  .map((item) {
                    return ListTile(
                      title: Text(item),
                      onTap: () {
                        ref
                            .read(searchQueryNotifierProvider.notifier)
                            .updateQuery(item);
                        controller.closeView(item);
                      },
                    );
                  });
            },
      ),
    );
  }
}
