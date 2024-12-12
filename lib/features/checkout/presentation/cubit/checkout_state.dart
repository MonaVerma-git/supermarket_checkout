class CheckoutState {
  final bool isLoading;
  final String? error;

  const CheckoutState({
    this.isLoading = false,
    this.error,
  });

  CheckoutState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}