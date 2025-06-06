import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/view/header_widget.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/commons/widgets/junior/button/view/chat_button_off.dart';
import 'package:weve_client/commons/widgets/junior/button/view/chat_button_on.dart';
import 'package:weve_client/commons/widgets/junior/button/view/senior_profile_button.dart';
import 'package:weve_client/commons/widgets/junior/button/viewmodel/select_language_provider.dart';
import 'package:weve_client/commons/widgets/popup/view/popup.dart';
import 'package:weve_client/commons/widgets/popup/viewmodel/popup_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_svg_image.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/enums/worry_status.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:weve_client/features/junior/data/datasources/chat_detail_service.dart';
import 'package:weve_client/features/junior/presentation/views/write/junior_write_thx_screen.dart';

// 상태 enum 정의

class JuniorChatScreen extends ConsumerStatefulWidget {
  final WorryStatus status;
  final int worryId;
  final String title;

  const JuniorChatScreen({
    super.key,
    required this.status,
    required this.worryId,
    required this.title,
  });

  @override
  ConsumerState<JuniorChatScreen> createState() => _JuniorChatScreenState();
}

class _JuniorChatScreenState extends ConsumerState<JuniorChatScreen> {
  bool _isHeadingBack = false;
  final ChatDetailService _chatDetailService = ChatDetailService();

  @override
  void initState() {
    super.initState();

    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 헤더 설정
      ref.read(headerProvider.notifier).setHeader(
            HeaderType.juniorBackTitle,
            title: "고민 상세 보기",
          );
    });
  }

  // 뒤로가기 버튼 처리를 위한 오버라이딩
  Future<bool> _onWillPop() async {
    if (!_isHeadingBack) {
      setState(() {
        _isHeadingBack = true;
      });

      Navigator.of(context).pop();
    }
    return false;
  }

  // 공통 팝업 표시 함수
  void _showContentPopup({required String content, required String author}) {
    ref.read(popupProvider.notifier).showPopup(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: WeveColor.gray.gray8,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  content,
                  style: WeveText.body2(color: WeveColor.main.yellowText),
                ),
                const SizedBox(height: 30),
                Text(
                  author,
                  style: WeveText.body3(color: WeveColor.main.yellowText),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        );
  }

  // 고민 상세 내용 팝업 표시 함수
  void _showWorryDetailPopup() async {
    // 먼저 로딩 상태의 팝업을 표시
    ref.read(popupProvider.notifier).showPopup(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: WeveColor.gray.gray8,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: WeveColor.main.yellowText,
                ),
                const SizedBox(height: 20),
                Text(
                  "고민 내용을 불러오는 중...",
                  style: TextStyle(color: WeveColor.main.yellowText),
                ),
              ],
            ),
          ),
        );

    try {
      // API로 고민 상세 내용 가져오기
      final detailResult =
          await _chatDetailService.fetchWorryDetail(widget.worryId);

      if (detailResult != null) {
        // 데이터를 받은 후 팝업 내용 업데이트
        ref.read(popupProvider.notifier).showPopup(
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: WeveColor.gray.gray8,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      detailResult.content,
                      style: WeveText.body2(color: WeveColor.main.yellowText),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      detailResult.author,
                      style: WeveText.body3(color: WeveColor.main.yellowText),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
      } else {
        // 데이터가 없는 경우
        ref.read(popupProvider.notifier).showPopup(
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: WeveColor.gray.gray8,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "고민 내용을 불러올 수 없습니다.",
                  style: WeveText.body2(color: WeveColor.main.yellowText),
                ),
              ),
            );
      }
    } catch (e) {
      // 에러 메시지 표시
      if (kDebugMode) {
        print('고민 상세 조회 오류: $e');
      }

      ref.read(popupProvider.notifier).showPopup(
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: WeveColor.gray.gray8,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "서버 오류가 발생했습니다.",
                style: WeveText.body2(color: WeveColor.main.yellowText),
              ),
            ),
          );
    }
  }

  // 어르신 답변 팝업 표시 함수
  void _showSeniorAnswerPopup() async {
    // 먼저 로딩 상태의 팝업을 표시
    ref.read(popupProvider.notifier).showPopup(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: WeveColor.gray.gray8,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: WeveColor.main.yellowText,
                ),
                const SizedBox(height: 20),
                Text(
                  "어르신의 답변을 불러오는 중...",
                  style: TextStyle(color: WeveColor.main.yellowText),
                ),
              ],
            ),
          ),
        );

    try {
      // API로 어르신 답변 내용 가져오기
      final answerResult =
          await _chatDetailService.fetchSeniorAnswer(widget.worryId);

      if (answerResult != null) {
        // 데이터를 받은 후 팝업 내용 업데이트
        ref.read(popupProvider.notifier).showPopup(
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: WeveColor.gray.gray8,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      answerResult.content,
                      style: WeveText.body2(color: WeveColor.main.yellowText),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      answerResult.author,
                      style: WeveText.body3(color: WeveColor.main.yellowText),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
      } else {
        // 데이터가 없는 경우
        ref.read(popupProvider.notifier).showPopup(
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: WeveColor.gray.gray8,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "어르신의 답변을 불러올 수 없습니다.",
                  style: WeveText.body2(color: WeveColor.main.yellowText),
                ),
              ),
            );
      }
    } catch (e) {
      // 에러 메시지 표시
      if (kDebugMode) {
        print('어르신 답변 조회 오류: $e');
      }

      ref.read(popupProvider.notifier).showPopup(
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: WeveColor.gray.gray8,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "서버 오류가 발생했습니다.",
                style: WeveText.body2(color: WeveColor.main.yellowText),
              ),
            ),
          );
    }
  }

  // 감사 인사 팝업 표시 함수
  void _showThankYouPopup() async {
    // 먼저 로딩 상태의 팝업을 표시
    ref.read(popupProvider.notifier).showPopup(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: WeveColor.gray.gray8,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: WeveColor.main.yellowText,
                ),
                const SizedBox(height: 20),
                Text(
                  "감사 인사를 불러오는 중...",
                  style: TextStyle(color: WeveColor.main.yellowText),
                ),
              ],
            ),
          ),
        );

    try {
      // API로 감사 인사 내용 가져오기
      final appreciateResult =
          await _chatDetailService.fetchAppreciate(widget.worryId);

      if (appreciateResult != null) {
        // 데이터를 받은 후 팝업 내용 업데이트
        ref.read(popupProvider.notifier).showPopup(
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: WeveColor.gray.gray8,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      appreciateResult.content,
                      style: WeveText.body2(color: WeveColor.main.yellowText),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      appreciateResult.author,
                      style: WeveText.body3(color: WeveColor.main.yellowText),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
      } else {
        // 데이터가 없는 경우
        ref.read(popupProvider.notifier).showPopup(
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: WeveColor.gray.gray8,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "감사 인사를 불러올 수 없습니다.",
                  style: WeveText.body2(color: WeveColor.main.yellowText),
                ),
              ),
            );
      }
    } catch (e) {
      // 에러 메시지 표시
      if (kDebugMode) {
        print('감사 인사 조회 오류: $e');
      }

      ref.read(popupProvider.notifier).showPopup(
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: WeveColor.gray.gray8,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "서버 오류가 발생했습니다.",
                style: WeveText.body2(color: WeveColor.main.yellowText),
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: WeveColor.bg.bg1,
        appBar: const HeaderWidget(),
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildContentByStatus(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            // 팝업 컴포넌트 사용
            const Popup(title: ""),
          ],
        ),
      ),
    );
  }

  // 상태에 따른 컨텐츠 빌드
  Widget _buildContentByStatus() {
    switch (widget.status) {
      case WorryStatus.WAITING:
        return _buildStatus1();
      case WorryStatus.ARRIVED:
        return _buildStatus2();
      case WorryStatus.RESOLVED:
        return _buildStatus3();
    }
  }

  // 상태 1: 고민에 대한 답변 대기 중
  Widget _buildStatus1() {
    return Column(
      children: [
        _buildImageContainer(
          image: CustomSvgImages.writeTop,
        ),
        ChatButtonOn(
          title: '당신의 고민',
          buttonText: '내가 쓴 고민 보기',
          onPressed: _showWorryDetailPopup,
        ),
        _buildImageContainer(
          image: CustomSvgImages.middleLine,
        ),
        ChatButtonOff(
          title: '어르신의 답변',
          buttonText: '어르신이 아직 작성중이에요',
        ),
        _buildImageContainer(
          image: CustomSvgImages.writeBottom,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // 상태 2: 고민에 답변이 등록됨
  Widget _buildStatus2() {
    return Column(
      children: [
        _buildImageContainer(
          image: CustomSvgImages.writeTop,
        ),
        ChatButtonOn(
          title: '당신의 고민',
          buttonText: '내가 쓴 고민 보기',
          onPressed: _showWorryDetailPopup,
        ),
        _buildImageContainer(
          image: CustomSvgImages.middleLineLeft,
        ),
        ChatButtonOn(
          title: '어르신의 답변',
          buttonText: '어르신의 답변 보기',
          onPressed: _showSeniorAnswerPopup,
        ),
        _buildImageContainer(
          image: CustomSvgImages.middleLineRight,
        ),
        ChatButtonOn(
          title: '당신의 감사 인사',
          buttonText: '어르신께 감사 인사 남기기',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => JuniorWriteThxScreen(
                  worryId: widget.worryId,
                ),
              ),
            );
          },
        ),
        _buildImageContainer(
          image: CustomSvgImages.writeBottom,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // 상태 3: 고민이 해결됨
  Widget _buildStatus3() {
    return Column(
      children: [
        // 어르신의 프로필 확인하기
        // const SeniorProfileButton(),
        const SizedBox(height: 30),
        _buildImageContainer(
          image: CustomSvgImages.writeTop,
        ),
        ChatButtonOn(
          title: '당신의 고민',
          buttonText: '내가 쓴 고민 보기',
          onPressed: _showWorryDetailPopup,
        ),
        _buildImageContainer(
          image: CustomSvgImages.middleLineLeft,
        ),
        ChatButtonOn(
          title: '어르신의 답변',
          buttonText: '어르신의 답변 보기',
          onPressed: _showSeniorAnswerPopup,
        ),
        _buildImageContainer(
          image: CustomSvgImages.middleLineRight,
        ),
        ChatButtonOn(
          title: '당신의 감사 인사',
          buttonText: '내가 쓴 감사 인사 보기',
          onPressed: _showThankYouPopup,
        ),
        _buildImageContainer(
          image: CustomSvgImages.writeBottom,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // SVG 이미지 컨테이너
  Widget _buildImageContainer({required String image}) {
    return SizedBox(
      width: double.infinity,
      child: SvgPicture.asset(
        image,
        fit: BoxFit.contain,
      ),
    );
  }
}
