import 'dart:async';
import 'package:hive/hive.dart';
import 'package:swapy/core/base/view_model/base_view_model.dart';
import 'package:swapy/core/constants/string/string_constants.dart';

class OnboardViewModel extends BaseViewModel {
  @override
  FutureOr<void> init() {
    final box = Hive.box(StringConstants.hiveBoxName);
    final userId = box.get(StringConstants.hiveUserKey);
    if (userId != null) {
      //NavigationService.instance.navigateTo(AppRouter.home);
    }
  }
}
