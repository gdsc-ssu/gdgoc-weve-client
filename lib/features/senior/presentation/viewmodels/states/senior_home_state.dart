class SeniorHomeState {
  final bool isLoading;
  final String? errorMessage;
  final List<WorryItem> careerList;
  final List<WorryItem> loveList;
  final List<WorryItem> relationshipList;

  const SeniorHomeState({
    this.isLoading = false,
    this.errorMessage,
    this.careerList = const [],
    this.loveList = const [],
    this.relationshipList = const [],
  });

  SeniorHomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<WorryItem>? careerList,
    List<WorryItem>? loveList,
    List<WorryItem>? relationshipList,
  }) {
    return SeniorHomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      careerList: careerList ?? this.careerList,
      loveList: loveList ?? this.loveList,
      relationshipList: relationshipList ?? this.relationshipList,
    );
  }
}

class WorryItem {
  final int worryId;
  final String author;
  final String title;

  WorryItem({required this.worryId, required this.author, required this.title});

  factory WorryItem.fromJson(Map<String, dynamic> json) => WorryItem(
        worryId: json['worryId'],
        author: json['author'],
        title: json['title'],
      );
}
