import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart' as algolia;

import '../../../repositories/food/food_model.dart';
import '../../../repositories/search/hits_page.dart';
import '../../../repositories/search/search_repository.dart';
import '../../../base/cubit.dart';
import '../../../base/state.dart';

part 'search_state.dart';

class SearchCubit extends FCubit<SearchState> {
  SearchCubit({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(const SearchState(status: ScreenStatus.value));

  final SearchRepository _searchRepository;
  StreamSubscription<HitsPage>? _searchSubcription;
  StreamSubscription? _categoryFacetSubcription;

  void init() {
    _searchSubcription?.cancel();
    _searchSubcription = _searchRepository.searchData.listen((page) {
      if (page.pageKey == 0) {
        emitValue(
          state.copyWith(
            foods: page.foods,
            page: 0,
          ),
        );
      } else {
        emitValue(state.copyWith(
          foods: [...state.foods, ...page.foods],
          page: page.pageKey,
        ));
      }

      // Lastpage
      if (page.nextPageKey == null) {
        emitValue(state.copyWith(
          isLastPage: true,
          page: page.pageKey,
        ));
      }
    });

    _categoryFacetSubcription?.cancel();
    _categoryFacetSubcription = _searchRepository.foodFacetStateStream.listen(
      (event) {
        emitValue(
          state.copyWith(
            filters: (event as List<algolia.SelectableItem<algolia.Facet>>)
                .map((e) => SelectableItem(
                      value: e.item.value,
                      isSelected: e.isSelected,
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  void onFilterToggled(SelectableItem filter) {
    emitLoading();
    _searchRepository.resetPageKey();
    _searchRepository.toggleFilter(filter.value);
  }

  void clearFilters() async {
    emitLoading();
    _searchRepository.resetPageKey();
    _searchRepository.clearFilters();
  }

  Future<void> syncToggle(String value) async {
    _searchRepository.toggleFilter(value);
  }

  void search(String query) {
    emit(state.copyWith(isLastPage: false));
    _searchRepository.searchFood(query);
  }

  void fetchMoreResult() {
    emitLoading();
    if (state.isLastPage) return;
    _searchRepository.fetchNextPage();
  }

  @override
  Future<void> close() {
    _searchSubcription?.cancel();
    _categoryFacetSubcription?.cancel();
    _searchRepository.dispose();
    return super.close();
  }
}
