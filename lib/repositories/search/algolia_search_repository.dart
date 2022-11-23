import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';

import '../../config/secrets.dart';
import 'hits_page.dart';
import 'search_repository.dart';

class AlgoliaSearchRepository implements SearchRepository {
  static final _foodsSearcher = HitsSearcher(
    applicationID: Credentials.algoliaAppId,
    apiKey: Credentials.algoliaApiKey,
    indexName: 'foods',
    debounce: const Duration(milliseconds: 500),
  )
    ..applyState(
      (state) => state.copyWith(
        hitsPerPage: 10,
        query: '',
        page: 0,
      ),
    )
    ..connectFilterState(_filterState);

  static final _filterState = FilterState();

  static final foodCategoryFacetList = FacetList(
    searcher: _foodsSearcher,
    filterState: _filterState,
    attribute: 'category',
    persistent: true,
  );

  @override
  Stream<List<SelectableItem<Facet>>> get foodFacetStateStream =>
      foodCategoryFacetList.facets;

  @override
  Stream<HitsPage> get searchData =>
      _foodsSearcher.responses.map(HitsPage.fromResponse);

  @override
  void searchFood(String query) {
    if (query.length <= 2) return;
    _foodsSearcher.query(query);
    _foodsSearcher.applyState(
      (state) => state.copyWith(
        page: 0,
      ),
    );
  }

  @override
  void fetchNextPage() {
    _foodsSearcher.applyState(
      (state) => state.copyWith(
        page: state.page != null ? state.page! + 1 : null,
      ),
    );
  }

  @override
  void resetPageKey() {
    _foodsSearcher.applyState(
      (state) => state.copyWith(page: 0),
    );
  }

  @override
  void clearFilters() {
    _filterState.clear();
  }

  @override
  void dispose() {
    _filterState.clear();
    _foodsSearcher.applyState(
      (state) => const SearchState(indexName: 'foods'),
    );
  }

  @override
  void toggleFilter(String value) {
    foodCategoryFacetList.toggle(value);
  }
}
