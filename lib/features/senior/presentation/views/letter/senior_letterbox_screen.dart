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
  final List<String> newLetters = List.generate(4, (_) => '🇰🇷 {국가이름}');
  final List<String> readLetters = List.generate(3, (_) => '🇰🇷 {국가이름}');

  late final headerViewModel = ref.read(headerProvider.notifier);

  bool _isHeaderSet = false; // ⭐ build마다 중복 세팅 방지

  @override
  void initState() {
    super.initState();
    // 처음 화면 들어올 때: 내 화면 헤더 세팅
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setLetterboxHeader();
      _isHeaderSet = true;
    });
  }

  @override
  void dispose() {
    Future.microtask(() {
      if (mounted) {
        headerViewModel.resetHeader();
      }
    });
    super.dispose();
  }

  void _setLetterboxHeader() {
    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    headerViewModel.setHeader(
      HeaderType.seniorTitleLogo,
      title: appLocalizations.senior.seniorHeaderLetterBoxTitle,
    );
  }

  void _restoreHomeHeader() {
    if (!mounted) return;

    final locale = ref.read(localeProvider);
    final appLocalizations = AppLocalizations(locale);

    ref.read(headerProvider.notifier).setHeader(
          HeaderType.seniorTitleLogo,
          title: appLocalizations.senior.seniorHeaderHomeTitle,
        );
  }

  Future<bool> _onWillPop() async {
    _restoreHomeHeader();
    Navigator.pop(context);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isHeaderSet) {
        _setLetterboxHeader();
        _isHeaderSet = true;
      }
    });

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: WeveColor.bg.bg1,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SectionTitle(
                  title: '새로운 편지',
                  icon: CustomIcons.getIcon(CustomIcons.seniorHeart, size: 40),
                  iconColor: Colors.brown,
                ),
                const SizedBox(height: 20),
                LetterGrid(letters: newLetters, isNew: true),
                const SizedBox(height: 20),
                SectionTitle(
                  title: '읽은 편지',
                  icon: CustomIcons.getIcon(CustomIcons.seniorChat, size: 40),
                  iconColor: Colors.brown,
                ),
                const SizedBox(height: 20),
                LetterGrid(letters: readLetters, isNew: false),
              ],
            ),
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
        const SizedBox(width: 8),
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
              color:
                  isNew ? WeveColor.main.yellow1_100 : WeveColor.main.yellow3,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isNew
                    ? CustomIcons.getIcon(CustomIcons.seniorLetterOn, size: 81)
                    : CustomIcons.getIcon(CustomIcons.seniorLetterOff,
                        size: 81),
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
