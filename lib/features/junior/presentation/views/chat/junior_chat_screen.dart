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
import 'package:weve_client/core/localization/app_localizations.dart';

// 상태 enum 정의
enum WorryStatus {
  WAITING, // 답변 대기 중
  ARRIVED, // 답변 등록됨
  RESOLVED, // 고민 해결됨
}

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

  // 고민 상세 내용 팝업 표시 함수
  void _showWorryDetailPopup() {
    // 임의의 상세 내용 및 작성자 정보 (나중에 API로 대체 예정)
    final String content =
        "편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다. 편지 내용이 들어갑니다.";
    final String author = "- 대한민국에 사는 5세 신짱구";

    // PopupViewModel을 통해 팝업 내용 설정 및 표시
    ref.read(popupProvider.notifier).showPopup(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
                const SizedBox(height: 16),
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

  // 어르신 답변 팝업 표시 함수
  void _showSeniorAnswerPopup() {
    // 임의의 답변 내용 및 작성자 정보 (나중에 API로 대체 예정)
    final String content =
        "안녕하세요 어르신..이건 어르신의 답변답변답변답변답변답변 의 답변답변답변답변답변답변 의 답변답변답변답변답변답변 의 답변답변답변답변답변답변 ";
    final String author = "- 대한민국에 사는 5세 신짱구";

    // PopupViewModel을 통해 팝업 내용 설정 및 표시
    ref.read(popupProvider.notifier).showPopup(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
                const SizedBox(height: 16),
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

  // 감사 인사 팝업 표시 함수
  void _showThankYouPopup() {
    // 임의의 감사 인사 내용 및 작성자 정보 (나중에 API로 대체 예정)
    final String content =
        "정말 감사합니다. 어르신의 조언 덕분에 많은 도움이 되었습니다. 앞으로도 어르신의 말씀을 새겨듣고 더 나은 사람이 되도록 노력하겠습니다. 건강하시고 행복하세요!";
    final String author = "- 대한민국에 사는 5세 신짱구";

    // PopupViewModel을 통해 팝업 내용 설정 및 표시
    ref.read(popupProvider.notifier).showPopup(
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
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
                const SizedBox(height: 16),
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: WeveColor.gray.gray8,
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
        ChatButtonOff(
          title: '당신의 감사 인사',
          buttonText: '어르신께 감사 인사 남기기',
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
        const SeniorProfileButton(),
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
