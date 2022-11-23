import 'dart:developer';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

import '../food/food_model.dart';

class HitsPage {
  const HitsPage(
    this.foods,
    this.pageKey,
    this.nextPageKey,
  );

  final List<FFood> foods;
  final int pageKey;
  final int? nextPageKey;

  factory HitsPage.fromResponse(SearchResponse response) {
    log('query: ${response.query}');
    log('facets: ${response.facets}');
    final items = response.hits
        .map(
          (e) => FFood.fromMap(e.cast<String, dynamic>()),
        )
        .toList();
    final isLastPage = response.page >= response.nbPages - 1;
    final nextPageKey = isLastPage ? null : response.page + 1;
    return HitsPage(items, response.page, nextPageKey);
  }
}
