class WorryDetailModel {
  final String author;
  final String content;
  final String audioUrl;

  WorryDetailModel({
    required this.author,
    required this.content,
    required this.audioUrl,
  });

  factory WorryDetailModel.fromJson(Map<String, dynamic> json) {
    return WorryDetailModel(
      author: json['author'],
      content: json['content'],
      audioUrl: json['audioUrl'],
    );
  }
}
