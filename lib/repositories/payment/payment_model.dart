class FPayment {
  const FPayment({
    this.id,
    this.amount,
  });

  final String? id;
  final int? amount;

  FPayment copyWith({
    String? id,
    int? amount,
  }) {
    return FPayment(
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }
}
