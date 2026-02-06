import 'package:hive_flutter/hive_flutter.dart';

class AppStorage {
  static const _appBoxName = 'appBox';

  static const _onboardingSeen = 'onboarding_seen';

  static final Box _appBox = Hive.box(_appBoxName);

  void setOnboardingSeen() async {
    await _appBox.put(_onboardingSeen, true);
  }

  bool getOnboardingSeen() {
    return _appBox.get(_onboardingSeen, defaultValue: false);
  }
}
