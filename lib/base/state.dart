import 'package:equatable/equatable.dart';

enum ScreenStatus {
  loading,
  value,
  error;

  bool get hasError => this == ScreenStatus.error;
  bool get hasValue => this == ScreenStatus.value;
  bool get isLoading => this == ScreenStatus.loading;
}

abstract class FState extends Equatable {
  final ScreenStatus status;
  final String? errorMessage;

  const FState({
    this.status = ScreenStatus.loading,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];

  FState copyWith({
    ScreenStatus? status,
    String? errorMessage,
  });
}
