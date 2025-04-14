import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class InputBox extends StatefulWidget {
  final double gap;
  final VoidCallback onSubmit;

  const InputBox({
    super.key,
    required this.gap,
    required this.onSubmit,
  });

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController _controller = TextEditingController();
  int _textLength = 0;
  final String placeholder = "청년이 고민을 해결할 수 있도록 내용을 작성해주세요";

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
    return Column(
      children: [
        Container(
          height: 400,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: WeveColor.bg.bg2,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  maxLength: 300,
                  buildCounter: (_,
                          {required currentLength,
                          required isFocused,
                          maxLength}) =>
                      null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: placeholder,
                    hintStyle: WeveText.header4(color: WeveColor.gray.gray5),
                  ),
                  style: WeveText.header4(color: WeveColor.gray.gray1),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Text(
                  "($_textLength / 300)",
                  style: WeveText.body3(color: WeveColor.gray.gray5),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: widget.gap),
        SeniorButton(
          text: "다 작성했어요",
          backgroundColor: _textLength >= 50
              ? WeveColor.main.yellow1_100
              : WeveColor.main.yellow3,
          textColor: _textLength >= 50
              ? WeveColor.main.yellowText
              : WeveColor.main.yellow4,
          onPressed: _textLength >= 50 ? widget.onSubmit : () {},
        ),
      ],
    );
  }
}
