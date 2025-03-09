import 'package:flutter/material.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/core/constants/fonts.dart';

class InputBoxWorry extends StatefulWidget {
  const InputBoxWorry({super.key});

  @override
  State<InputBoxWorry> createState() => _InputBoxWorryState();
}

class _InputBoxWorryState extends State<InputBoxWorry> {
  final TextEditingController _controller = TextEditingController();
  int _textLength = 0;
  final String placeholder =
      "어떤 고민이든 편하게 남겨주세요 \n당신의 고민은 익명으로 작성되며, 지혜로운 어르신께 따뜻한 조언을 받을 수 있어요.\n 단, 부적절한 언행은 법적 책임을 물을 수도 있어요.";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _textLength = _controller.text.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: WeveColor.bg.bg2,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            maxLines: 5,
            maxLength: 300,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeholder,
                hintStyle: WeveText.body3(color: WeveColor.gray.gray5)),
            style: WeveText.body3(color: WeveColor.gray.gray2),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("($_textLength / 300)",
                  style: WeveText.body3(color: WeveColor.gray.gray5)),

              // 종이비행기 아이콘 (50자 이상이면 검은색, 아니면 회색)
              _textLength >= 50
                  ? CustomIcons.getIcon(CustomIcons.mySendActive, size: 24)
                  : CustomIcons.getIcon(CustomIcons.mySendDeactive, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}
