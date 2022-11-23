class FSearchFilter {
  const FSearchFilter({
    this.type = const <FSearchType>[],
    this.location = const <FSearchLocation>[],
    this.category = const <FSearchCategory>[],
  });

  final List<FSearchType> type;
  final List<FSearchLocation> location;
  final List<FSearchCategory> category;

  FSearchFilter copyWith({
    List<FSearchType>? type,
    List<FSearchLocation>? location,
    List<FSearchCategory>? category,
  }) {
    return FSearchFilter(
      type: type ?? this.type,
      location: location ?? this.location,
      category: category ?? this.category,
    );
  }
}

abstract class FFilter {}

enum FSearchType {
  restaurant,
  food,
}

enum FSearchLocation {
  nearYou,
}

enum FSearchCategory {
  bbq,
  bestFood,
  bread,
  burger,
  chocolate,
  dessert,
  drink,
  friedChicken,
  iceCream,
  pizza,
  pork,
  sandwich,
  sausage,
  steak,
}
