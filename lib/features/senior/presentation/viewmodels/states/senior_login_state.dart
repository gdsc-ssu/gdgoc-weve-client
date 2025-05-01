class SeniorLoginState {
  final String name;
  final String phoneNumber;

  SeniorLoginState({
    this.name = '',
    this.phoneNumber = '',
  });

  SeniorLoginState copyWith({
    String? name,
    String? phoneNumber,
  }) {
    return SeniorLoginState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
