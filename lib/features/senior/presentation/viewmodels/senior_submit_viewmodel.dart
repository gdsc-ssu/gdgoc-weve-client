import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/utils/api_client.dart';
import 'package:weve_client/features/senior/presentation/viewmodels/states/senior_submit_state.dart';
import 'package:weve_client/features/senior/presentation/views/senior_main_screen.dart';

class SeniorSubmitViewModel extends StateNotifier<SeniorSubmitState> {
  SeniorSubmitViewModel() : super(SeniorSubmitState());

  final ApiClient _apiClient = ApiClient();

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value);
  }

  void updateBirth(String value) {
    state = state.copyWith(birth: value);
  }

  void updateJob(String value) {
    state = state.copyWith(job: value);
  }

  void updateValue(String value) {
    state = state.copyWith(value: value);
  }

  void updateHardship(String value) {
    state = state.copyWith(hardship: value);
  }

  // 전화번호 형식 변환 (010-0000-0000 -> +82 010-0000-0000)
  String formatPhoneNumber(String phoneNumber) {
    // 이미 +82로 시작하면 그대로 반환
    if (phoneNumber.startsWith('+82')) {
      return phoneNumber;
    }

    // 01X-XXXX-XXXX 형식인 경우 앞에 +82 추가
    if (phoneNumber.startsWith('01')) {
      return '+82 $phoneNumber';
    }

    // 그 외의 경우 원래 값 반환
    return phoneNumber;
  }

  Future<void> submit(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      String formatBirth(String birth) {
        // 생년월일 문자열이 비어 있거나 형식이 맞지 않는 경우 기본값 반환
        if (birth.isEmpty) {
          return "2000-01-01"; // 기본값 설정
        }

        // '2024년 5월 14일' 형식 변환
        final yearMonthDayMatch =
            RegExp(r'(\d{4})년\s*(\d{1,2})월\s*(\d{1,2})일').firstMatch(birth);
        if (yearMonthDayMatch != null) {
          final year = yearMonthDayMatch.group(1)!;
          final month = yearMonthDayMatch.group(2)!.padLeft(2, '0');
          final day = yearMonthDayMatch.group(3)!.padLeft(2, '0');
          return '$year-$month-$day';
        }

        // 이미 YYYY-MM-DD 형식이면 그대로 반환
        if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(birth)) {
          return birth;
        }

        // 다른 형식일 경우 기본값 반환
        return "2000-01-01";
      }

      // 전화번호 형식 변환
      final formattedPhoneNumber = formatPhoneNumber(state.phoneNumber);

      // 1단계: 회원가입 API 호출
      print('회원가입 API 호출 시작');
      final registerResponse = await _apiClient.post(
        '/api/auth/register',
        data: {
          'name': state.name,
          'phoneNumber': formattedPhoneNumber,
          'birth': formatBirth(state.birth),
          'userType': 'SENIOR',
          'language': 'KOREAN',
        },
      );

      if (!registerResponse.isSuccess || registerResponse.code != 'COMMON200') {
        state = state.copyWith(
          isLoading: false,
          errorMessage: registerResponse.message ?? '회원가입 실패',
        );
        return;
      }
      print('회원가입 성공: ${registerResponse.message}');

      // 2단계: 로그인 API 호출
      print('로그인 API 호출 시작');
      final loginResponse = await _apiClient.post(
        '/api/auth/login',
        data: {
          'phoneNumber': formattedPhoneNumber,
          'name': state.name,
        },
      );

      if (!loginResponse.isSuccess || loginResponse.code != 'COMMON200') {
        state = state.copyWith(
          isLoading: false,
          errorMessage: loginResponse.message ?? '로그인 실패',
        );
        return;
      }

      final token = loginResponse.result as String?;
      if (token != null) {
        await _apiClient.saveToken(token);
        await _apiClient.saveUserType('senior');
        print('로그인 성공: 토큰 저장 완료');
      } else {
        print('로그인 성공했으나 토큰이 없습니다');
      }

      // 필드에 기본값 설정 (빈 문자열인 경우)
      final job = state.job.isEmpty ? "미입력" : state.job;
      final value = state.value.isEmpty ? "미입력" : state.value;
      final hardship = state.hardship.isEmpty ? "미입력" : state.hardship;

      // 3단계: 시니어 정보 등록 API 호출
      print('시니어 정보 등록 API 호출 시작');
      final formattedBirth = formatBirth(state.birth);
      print(
          '전송할 시니어 정보: birth=$formattedBirth, job=$job, value=$value, hardship=$hardship');

      final response = await _apiClient.post(
        '/api/senior',
        data: {
          'birth': formattedBirth,
          'job': job,
          'value': value,
          'hardship': hardship,
        },
      );

      if (response.isSuccess && response.code == 'COMMON200') {
        print('시니어 정보 등록 성공');
        if (!context.mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SeniorMainScreen()),
        );
      } else {
        print('시니어 정보 등록 실패: ${response.message}');
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.message ?? '정보 등록 실패',
        );
      }
    } catch (e) {
      print('시니어 정보 제출 에러: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: '서버 에러가 발생했습니다.',
      );
    }
  }
}
