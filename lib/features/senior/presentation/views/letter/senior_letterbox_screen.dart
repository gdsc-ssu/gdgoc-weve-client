import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/header/model/header_type.dart';
import 'package:weve_client/commons/widgets/header/viewmodel/header_viewmodel.dart';
import 'package:weve_client/core/constants/colors.dart';
import 'package:weve_client/core/constants/fonts.dart';
import 'package:weve_client/core/localization/app_localizations.dart';
import 'package:weve_client/core/constants/custom_icon.dart';
import 'package:weve_client/features/senior/presentation/views/letter/senior_letter_detail.dart';

class SeniorLetterboxScreen extends ConsumerStatefulWidget {
  const SeniorLetterboxScreen({super.key});

  @override
  ConsumerState<SeniorLetterboxScreen> createState() =>
      _SeniorLetterboxScreenState();
}

class _SeniorLetterboxScreenState extends ConsumerState<SeniorLetterboxScreen> {
  final List<String> newLetters = List.generate(4, (_) => '🇰🇷 ${"{국가이름}"}');
  final List<String> readLetters = List.generate(3, (_) => '🇰🇷 ${"{국가이름}"}');

  @override
  void initState() {
    super.initState();
    // 헤더 설정
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      final appLocalizations = AppLocalizations(locale);

      ref.read(headerProvider.notifier).setHeader(
            HeaderType.seniorTitleLogo,
            title: appLocalizations.senior.seniorHeaderLetterBoxTitle,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WeveColor.bg.bg1,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SectionTitle(
                title: '새로운 편지',
                icon: CustomIcons.getIcon(CustomIcons.seniorHeart, size: 40),
                iconColor: Colors.brown,
              ),
              SizedBox(height: 20),
              LetterGrid(letters: newLetters, isNew: true),
              SizedBox(height: 20),
              SectionTitle(
                title: '읽은 편지',
                icon: CustomIcons.getIcon(CustomIcons.seniorChat, size: 40),
                iconColor: Colors.brown,
              ),
              SizedBox(height: 20),
              LetterGrid(letters: readLetters, isNew: false),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color iconColor;

  const SectionTitle({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 8),
        Text(title, style: WeveText.header3(color: WeveColor.gray.gray1)),
      ],
    );
  }
}

class LetterGrid extends StatelessWidget {
  final List<String> letters;
  final bool isNew;

  const LetterGrid({
    super.key,
    required this.letters,
    required this.isNew,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: letters.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LetterDetailScreen(letter: letters[index]),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: isNew
                  ? WeveColor.main.yellow1_100
                  : WeveColor.main.yellow1_20,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isNew
                    ? CustomIcons.getIcon(CustomIcons.seniorLetterOn, size: 24)
                    : CustomIcons.getIcon(CustomIcons.seniorLetterOff,
                        size: 24),
                const SizedBox(height: 8),
                Text(
                  letters[index],
                  style: isNew
                      ? WeveText.semiHeader5(color: WeveColor.main.yellowText)
                      : WeveText.semiHeader5(color: WeveColor.main.yellow4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
