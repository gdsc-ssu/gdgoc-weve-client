import 'package:flutter/material.dart';
import 'package:weve_client/commons/widgets/senior/button/view/button.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';

class InputBox extends StatefulWidget {
  final double gap;
  const InputBox({super.key, required this.gap});

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
                    hintStyle: WeveText.header4(color: WeveColor.gray.gray5)),
                style: WeveText.header4(color: WeveColor.gray.gray1),
              ),
              Column(
                children: [
                  Text("($_textLength / 300)",
                      style: WeveText.body3(color: WeveColor.gray.gray5)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: widget.gap,
        ),
        _textLength >= 50
            // @TODO: on pressed 적용 필요
            ? SeniorButton(
                text: "다 작성했어요",
                backgroundColor: WeveColor.main.yellow1_100,
                textColor: WeveColor.main.yellowText,
                onPressed: () {})
            // @NOTE: 50미만 onPressed는 void로 유지
            : SeniorButton(
                text: "다 작성했어요",
                backgroundColor: WeveColor.main.yellow3,
                textColor: WeveColor.main.yellow4,
                onPressed: () {}),
      ],
    );
  }
}
