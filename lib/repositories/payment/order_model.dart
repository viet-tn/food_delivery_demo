class FOrder {
  const FOrder({
    this.id,
    required this.amount,
  });

  final String? id;
  final int amount;

  FOrder copyWith({
    String? id,
    int? amount,
  }) {
    return FOrder(
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }
}
