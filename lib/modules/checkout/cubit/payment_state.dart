part of 'payment_cubit.dart';

class PaymentState extends FState {
  const PaymentState({
    super.status,
    super.errorMessage,
    this.isSuccess,
  });

  final bool? isSuccess;

  @override
  List<Object?> get props => [...super.props, isSuccess];

  @override
  PaymentState copyWith({
    ScreenStatus? status,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
