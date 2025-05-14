class SeniorSubmitState {
  final String name;
  final String phoneNumber;
  final String birth;
  final String job;
  final String value;
  final String hardship;
  final bool isLoading;
  final String? errorMessage;

  SeniorSubmitState({
    this.name = '',
    this.phoneNumber = '',
    this.birth = '',
    this.job = '',
    this.value = '',
    this.hardship = '',
    this.isLoading = false,
    this.errorMessage,
  });

  SeniorSubmitState copyWith({
    String? name,
    String? phoneNumber,
    String? birth,
    String? job,
    String? value,
    String? hardship,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SeniorSubmitState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birth: birth ?? this.birth,
      job: job ?? this.job,
      value: value ?? this.value,
      hardship: hardship ?? this.hardship,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
