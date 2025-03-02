import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weve_client/commons/widgets/mode_button/model/mode_type.dart';

final modeTypeProvider =
    StateNotifierProvider<ModeTypeViewmodel, ModeType?>((ref) {
  return ModeTypeViewmodel();
});

class ModeTypeViewmodel extends StateNotifier<ModeType?> {
  ModeTypeViewmodel() : super(null);

  final List<ModeTypeModel> userTypes = [
    ModeTypeModel(type: ModeType.senior),
    ModeTypeModel(type: ModeType.junior)
  ];

  void selectUserType(ModeType type) {
    state = type;
  }
}
