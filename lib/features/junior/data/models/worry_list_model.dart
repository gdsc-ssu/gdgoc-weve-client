import 'package:weve_client/core/models/api_response.dart';

/// 고민 항목 모델
class WorryItem {
  final int worryId;
  final String title;
  final String status;

  WorryItem({
    required this.worryId,
    required this.title,
    required this.status,
  });

  factory WorryItem.fromJson(Map<String, dynamic> json) {
    return WorryItem(
      worryId: json['worryId'] as int,
      title: json['title'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'worryId': worryId,
      'title': title,
      'status': status,
    };
  }
}

/// 고민 목록 응답 모델
class WorryListResponse {
  final bool isSuccess;
  final String code;
  final String message;
  final List<WorryItem> worryList;

  WorryListResponse({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.worryList,
  });

  /// API 응답으로부터 WorryListResponse 생성
  factory WorryListResponse.fromApiResponse(
      ApiResponse<Map<String, dynamic>> response) {
    final worryList = <WorryItem>[];

    if (response.isSuccess && response.result != null) {
      final result = response.result!;
      if (result.containsKey('worryList') && result['worryList'] is List) {
        final worryListJson = result['worryList'] as List;
        worryList.addAll(
          worryListJson
              .map((item) => WorryItem.fromJson(item as Map<String, dynamic>)),
        );
      }
    }

    return WorryListResponse(
      isSuccess: response.isSuccess,
      code: response.code,
      message: response.message,
      worryList: worryList,
    );
  }
}
