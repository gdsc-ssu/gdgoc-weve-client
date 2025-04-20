import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/errors/app_error.dart';
import 'package:weve_client/features/junior/data/datasources/user_profile_service.dart';
import 'package:weve_client/features/junior/data/models/user_profile_model.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState {
  final ProfileStatus status;
  final String? errorMessage;
  final String? errorCode;
  final ProfileResult? profileData;

  ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.errorCode,
    this.profileData,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    String? errorCode,
    ProfileResult? profileData,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      errorCode: errorCode ?? this.errorCode,
      profileData: profileData ?? this.profileData,
    );
  }
}

class UserProfileViewModel extends StateNotifier<ProfileState> {
  final UserProfileService _userProfileService;

  UserProfileViewModel(this._userProfileService) : super(ProfileState());

  // 프로필 정보 저장
  Future<bool> saveProfile(
      {String? name, String? birth, String? language}) async {
    state = state.copyWith(status: ProfileStatus.loading);

    try {
      // 로컬 저장소에서 기존 정보 가져오기
      final profileData =
          await _userProfileService.getProfileFromLocalStorage();

      if (profileData == null) {
        state = state.copyWith(
          status: ProfileStatus.error,
          errorMessage: '프로필 정보를 찾을 수 없습니다.',
          errorCode: 'PROFILE_NOT_FOUND',
        );
        return false;
      }

      // 전화번호 가져오기
      var phoneNumber = await _userProfileService.getPhoneNumber();

      // 전화번호가 null인 경우 1초 대기 후 다시 조회 시도
      if (phoneNumber == null || phoneNumber.isEmpty) {
        if (kDebugMode) {
          print('전화번호가 없어 1초 후 다시 조회합니다.');
        }

        // 1초 대기 후 다시 시도
        await Future.delayed(const Duration(seconds: 1));
        phoneNumber = await _userProfileService.getPhoneNumber();
      }

      if (phoneNumber == null || phoneNumber.isEmpty) {
        state = state.copyWith(
          status: ProfileStatus.error,
          errorMessage: '전화번호 정보를 찾을 수 없습니다.',
          errorCode: 'PHONE_NUMBER_NOT_FOUND',
        );
        return false;
      }

      // 언어 설정 가져오기 (기본값)
      String defaultLanguage = await _userProfileService.getLanguage();

      // API 요청 모델 생성 (전달받은 값 또는 기존 값 사용)
      final request = ProfileRequest(
        name: name ?? profileData.name,
        birth: birth ?? profileData.birth,
        phoneNumber: phoneNumber,
        language: language ?? defaultLanguage,
      );

      if (kDebugMode) {
        print('프로필 업데이트 요청: ${request.toJson()}');
      }

      // API 호출
      final response = await _userProfileService.saveProfile(request);

      if (response.isSuccess && response.profileResult != null) {
        state = state.copyWith(
          status: ProfileStatus.success,
          profileData: response.profileResult,
        );
        return true;
      } else {
        state = state.copyWith(
          status: ProfileStatus.error,
          errorMessage: response.message,
          errorCode: response.code,
        );
        return false;
      }
    } catch (e) {
      // AppError 타입 체크하여 메시지 추출
      final errorMessage = e is AppError ? e.message : e.toString();
      final errorCode = e is AppError ? e.code : 'UNKNOWN_ERROR';

      state = state.copyWith(
        status: ProfileStatus.error,
        errorMessage: errorMessage,
        errorCode: errorCode,
      );
      return false;
    }
  }

  // 로컬 저장소에서 프로필 정보 로드
  Future<void> loadProfileFromLocalStorage() async {
    state = state.copyWith(status: ProfileStatus.loading);

    try {
      final profileData =
          await _userProfileService.getProfileFromLocalStorage();

      if (profileData != null) {
        state = state.copyWith(
          status: ProfileStatus.success,
          profileData: profileData,
        );
      } else {
        state = state.copyWith(status: ProfileStatus.initial);
      }
    } catch (e) {
      if (kDebugMode) {
        print('프로필 로드 오류: $e');
      }

      state = state.copyWith(status: ProfileStatus.initial);
    }
  }

  // 상태 초기화
  void resetState() {
    state = ProfileState();
  }

  // 프로필 정보 가져오기
  Future<bool> getProfile() async {
    state = state.copyWith(status: ProfileStatus.loading);

    try {
      // API 호출
      final response = await _userProfileService.getProfile();

      if (response.isSuccess && response.profileResult != null) {
        state = state.copyWith(
          status: ProfileStatus.success,
          profileData: response.profileResult,
        );
        return true;
      } else {
        state = state.copyWith(
          status: ProfileStatus.error,
          errorMessage: response.message,
          errorCode: response.code,
        );
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('프로필 정보 가져오기 오류: $e');
      }

      // AppError 타입 체크하여 메시지 추출
      final errorMessage = e is AppError ? e.message : e.toString();
      final errorCode = e is AppError ? e.code : 'UNKNOWN_ERROR';

      state = state.copyWith(
        status: ProfileStatus.error,
        errorMessage: errorMessage,
        errorCode: errorCode,
      );
      return false;
    }
  }
}

// Provider 정의
final userProfileServiceProvider = Provider<UserProfileService>((ref) {
  return UserProfileService();
});

final userProfileViewModelProvider =
    StateNotifierProvider<UserProfileViewModel, ProfileState>((ref) {
  final userProfileService = ref.watch(userProfileServiceProvider);
  return UserProfileViewModel(userProfileService);
});
