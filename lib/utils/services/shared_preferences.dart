import 'package:shared_preferences/shared_preferences.dart';

const onboardingKey = 'ONBOARDING_KEY';
const loginStateKey = 'LOGIN_STATE_KEY';

class FSharedPreferences {
  FSharedPreferences(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  Future<bool> setOnboardingValue(bool value) =>
      sharedPreferences.setBool(onboardingKey, value);

  bool get wasOnboardingShown =>
      sharedPreferences.getBool(onboardingKey) ?? false;
}
