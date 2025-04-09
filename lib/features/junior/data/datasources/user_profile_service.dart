import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/core/models/api_response.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/junior/data/models/user_profile_model.dart';

class UserProfileService {
  final ApiClient _apiClient = ApiClient();

  // SharedPreferences 키 상수
  static const String _nameKey = 'user_name';
  static const String _birthKey = 'user_birth';
  static const String _nationalityKey = 'user_nationality';
  static const String _ageKey = 'user_age';
  static const String _languageKey = 'user_language';
  static const String _phoneNumberKey =
      'user_phone_number'; // SMS API에서 사용하는 키와 동일하게 설정
  static const String _userTypeKey = 'user_type';

  // 전화번호 가져오기 (SharedPreferences)
  Future<String?> getPhoneNumber() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final phoneNumber = prefs.getString('user_phone_number');

      if (kDebugMode) {
        print('SharedPreferences에서 전화번호 조회: $phoneNumber');
      }

      return phoneNumber;
    } catch (e) {
      if (kDebugMode) {
        print('전화번호 조회 오류: $e');
      }
      return null;
    }
  }

  // 언어 설정 가져오기 (SharedPreferences)
  Future<String> getLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final language = prefs.getString(_languageKey);

      if (language != null) {
        return language;
      }

      // 언어 설정이 없으면 LanguagePreferences에서 가져옴
      final savedLanguage = await LanguagePreferences.loadLanguage();
      switch (savedLanguage) {
        case LanguageOption.korean:
          return 'KOREAN';
        case LanguageOption.english:
          return 'ENGLISH';
        case LanguageOption.japanese:
          return 'JAPANESE';
        default:
          return 'KOREAN'; // 기본값
      }
    } catch (e) {
      if (kDebugMode) {
        print('언어 설정 조회 오류: $e');
      }
      return 'KOREAN'; // 기본값
    }
  }

  // 프로필 정보 저장 API
  Future<ProfileResponse> saveProfile(ProfileRequest request) async {
    try {
      if (kDebugMode) {
        print('프로필 저장 API 호출: /api/mypage');
        print('요청 데이터: ${request.toJson()}');
      }

      final response = await _apiClient.patch(
        '/api/mypage',
        data: request.toJson(),
      );

      if (kDebugMode) {
        print('프로필 저장 응답: ${response.toJson()}');
      }

      // 응답을 ProfileResponse로 변환
      final apiResponseWithMap = ApiResponse<Map<String, dynamic>>(
        isSuccess: response.isSuccess,
        code: response.code,
        message: response.message,
        result: response.result as Map<String, dynamic>?,
      );

      final profileResponse = ProfileResponse(response: apiResponseWithMap);

      // 프로필 저장 성공 시 로컬 저장소에도 저장
      if (profileResponse.isSuccess && profileResponse.profileResult != null) {
        await _saveProfileToLocalStorage(profileResponse.profileResult!);
      }

      return profileResponse;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('프로필 저장 DioException: ${e.message}');
        print('Response: ${e.response?.data}');
      }
      // 에러 처리 유틸리티 활용
      final appError = ErrorHandler.handleDioError(e);
      throw appError;
    } catch (e) {
      if (kDebugMode) {
        print('프로필 저장 일반 예외: $e');
      }
      throw AppError(
          code: 'PROFILE_SAVE_ERROR',
          message: '프로필 저장 중 오류가 발생했습니다',
          originalError: e);
    }
  }

  // 프로필 정보를 로컬 저장소(SharedPreferences)에 저장
  Future<void> _saveProfileToLocalStorage(ProfileResult profile) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_nameKey, profile.name);
      await prefs.setString(_birthKey, profile.birth);
      await prefs.setString(_nationalityKey, profile.nationality);
      await prefs.setInt(_ageKey, profile.age);
      await prefs.setString(_languageKey, profile.language);
      await prefs.setString(_phoneNumberKey, profile.phoneNumber);
      await prefs.setString(_userTypeKey, profile.userType);

      if (kDebugMode) {
        print('프로필 정보 로컬 저장소 저장 완료');
      }
    } catch (e) {
      if (kDebugMode) {
        print('프로필 정보 로컬 저장소 저장 오류: $e');
      }
      // 로컬 저장소 저장 실패는 무시하고 계속 진행
    }
  }

  // 프로필 정보 조회 (로컬 저장소에서)
  Future<ProfileResult?> getProfileFromLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 필수 값인 name이 없으면 null 반환
      if (!prefs.containsKey(_nameKey)) {
        return null;
      }

      return ProfileResult(
        name: prefs.getString(_nameKey) ?? '',
        birth: prefs.getString(_birthKey) ?? '',
        nationality: prefs.getString(_nationalityKey) ?? '',
        age: prefs.getInt(_ageKey) ?? 0,
        language: prefs.getString(_languageKey) ?? 'KOREAN',
        phoneNumber: prefs.getString(_phoneNumberKey) ?? '',
        userType: prefs.getString(_userTypeKey) ?? '',
      );
    } catch (e) {
      if (kDebugMode) {
        print('프로필 정보 로컬 저장소 조회 오류: $e');
      }
      return null;
    }
  }
}
