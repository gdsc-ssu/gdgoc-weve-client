class SeniorAnswerState {
  final String content;
  final String imageUrl;
  final bool isLoading;
  final String? errorMessage;

  SeniorAnswerState({
    this.content = '',
    this.imageUrl = '',
    this.isLoading = false,
    this.errorMessage,
  });

  SeniorAnswerState copyWith({
    String? content,
    String? imageUrl,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SeniorAnswerState(
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
