import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/localization/app_localizations.dart';

class InputPhoneField extends ConsumerStatefulWidget {
  final String title;
  final String placeholder;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const InputPhoneField({
    super.key,
    required this.title,
    required this.placeholder,
    required this.controller,
    this.onChanged,
  });

  @override
  ConsumerState<InputPhoneField> createState() => _InputPhoneFieldState();
}

class _InputPhoneFieldState extends ConsumerState<InputPhoneField> {
  // 현재 커서 위치를 저장하기 위한 변수
  int _selectionStart = 0;
  int _selectionEnd = 0;

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch(localeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: WeveText.header4(color: WeveColor.gray.gray1),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 5),

        // 입력 필드 (왼쪽 정렬)
        Align(
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: widget.controller,
            onChanged: (value) {
              _formatPhoneNumber(value, locale.languageCode);
              if (widget.onChanged != null) {
                widget.onChanged!(widget.controller.text);
              }
            },
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(color: WeveColor.gray.gray5),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            style: WeveText.body2(color: WeveColor.gray.gray1),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
            ],
            onTap: () {
              // 현재 선택 상태 저장
              if (widget.controller.selection.start != -1) {
                _selectionStart = widget.controller.selection.start;
                _selectionEnd = widget.controller.selection.end;
              }
            },
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: Divider(thickness: 1, color: WeveColor.gray.gray7),
        ),
      ],
    );
  }

  void _formatPhoneNumber(String value, String languageCode) {
    // 현재 커서 위치 저장
    int cursorPosition = widget.controller.selection.start;

    // 사용자가 입력한 번호에서 하이픈 등 특수문자 제거
    String digits = value.replaceAll(RegExp(r'[^\d]'), '');

    // 이전 텍스트의 하이픈 개수 및 위치 파악
    String previousText = widget.controller.text;
    int previousDigitsBeforeCursor = previousText
        .substring(0, cursorPosition)
        .replaceAll(RegExp(r'[^\d]'), '')
        .length;

    String formattedNumber = '';

    // 언어별 전화번호 포맷팅
    if (languageCode == 'ko') {
      // 한국어: 010-XXXX-XXXX 형식
      if (digits.length > 3) {
        formattedNumber = digits.substring(0, 3);
        if (digits.length > 7) {
          formattedNumber +=
              '-${digits.substring(3, 7)}-${digits.substring(7, digits.length.clamp(0, 11))}';
        } else if (digits.length > 3) {
          formattedNumber += '-${digits.substring(3, digits.length)}';
        }
      } else {
        formattedNumber = digits;
      }
    } else if (languageCode == 'en') {
      // 영어: XXX-XXX-XXXX 형식
      if (digits.length > 3) {
        formattedNumber = digits.substring(0, 3);
        if (digits.length > 6) {
          formattedNumber +=
              '-${digits.substring(3, 6)}-${digits.substring(6, digits.length.clamp(0, 10))}';
        } else if (digits.length > 3) {
          formattedNumber += '-${digits.substring(3, digits.length)}';
        }
      } else {
        formattedNumber = digits;
      }
    } else if (languageCode == 'ja') {
      // 일본어: 090-XXXX-XXXX 또는 080-XXXX-XXXX 형식
      if (digits.length > 3) {
        formattedNumber = digits.substring(0, 3);
        if (digits.length > 7) {
          formattedNumber +=
              '-${digits.substring(3, 7)}-${digits.substring(7, digits.length.clamp(0, 11))}';
        } else if (digits.length > 3) {
          formattedNumber += '-${digits.substring(3, digits.length)}';
        }
      } else {
        formattedNumber = digits;
      }
    } else {
      // 기본 (영어와 동일)
      if (digits.length > 3) {
        formattedNumber = digits.substring(0, 3);
        if (digits.length > 6) {
          formattedNumber +=
              '-${digits.substring(3, 6)}-${digits.substring(6, digits.length.clamp(0, 10))}';
        } else if (digits.length > 3) {
          formattedNumber += '-${digits.substring(3, digits.length)}';
        }
      } else {
        formattedNumber = digits;
      }
    }

    // 변경 전 텍스트 저장
    String oldText = widget.controller.text;

    // 텍스트 변경
    widget.controller.text = formattedNumber;

    // 새로운 커서 위치 계산
    int newPosition = 0;

    if (cursorPosition <= 0) {
      // 커서가 맨 앞에 있을 경우, 그대로 유지
      newPosition = 0;
    } else if (cursorPosition >= oldText.length) {
      // 커서가 맨 뒤에 있을 경우, 맨 뒤로 이동
      newPosition = formattedNumber.length;
    } else {
      // 커서가 중간에 있을 경우, 상대적 위치 유지
      // 커서 위치까지의 숫자 개수를 세어 새 포맷에서 해당 숫자 개수 다음 위치로 설정

      int digitCount = 0;
      newPosition = 0;

      // 이전에 커서 앞에 있던 숫자 개수만큼 새 문자열에서 위치 찾기
      for (int i = 0; i < formattedNumber.length; i++) {
        if (digitCount == previousDigitsBeforeCursor) {
          newPosition = i;
          break;
        }

        if (RegExp(r'[0-9]').hasMatch(formattedNumber[i])) {
          digitCount++;
        }

        if (i == formattedNumber.length - 1 &&
            digitCount == previousDigitsBeforeCursor) {
          newPosition = formattedNumber.length;
        }
      }
    }

    // 만약 커서 위치가 '-' 위치라면 그 다음 위치로 조정
    if (newPosition < formattedNumber.length &&
        formattedNumber[newPosition] == '-') {
      newPosition++;
    }

    // 커서 위치 설정
    widget.controller.selection = TextSelection.fromPosition(
      TextPosition(offset: newPosition),
    );
  }
}
