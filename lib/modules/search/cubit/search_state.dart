part of 'search_cubit.dart';

class SelectableItem {
  const SelectableItem({
    required this.value,
    required this.isSelected,
  });

  final String value;
  final bool isSelected;
}

class SearchState extends FState {
  const SearchState({
    super.status,
    super.errorMessage,
    this.filters = const <SelectableItem>[],
    this.foods = const <FFood>[],
    this.page = 0,
    this.isLastPage = false,
  });

  final List<SelectableItem> filters;
  final List<FFood> foods;
  final int page;
  final bool isLastPage;

  @override
  List<Object?> get props => [...super.props, filters, foods, page, isLastPage];

  @override
  SearchState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    List<SelectableItem>? filters,
    List<FFood>? foods,
    int? page,
    bool? isLastPage,
  }) {
    return SearchState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      filters: filters ?? this.filters,
      foods: foods ?? this.foods,
      page: page ?? this.page,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
