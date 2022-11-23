import 'hits_page.dart';

abstract class SearchRepository {
  Stream<HitsPage> get searchData;

  Stream<dynamic> get foodFacetStateStream;

  void searchFood(String query);

  void fetchNextPage();

  void resetPageKey();

  void clearFilters();

  void dispose();

  void toggleFilter(String value);
}
