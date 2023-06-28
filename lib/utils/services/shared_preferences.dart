import 'package:shared_preferences/shared_preferences.dart';

const onboardingKey = 'ONBOARDING_KEY';
const notificationKey = 'NOTIFICATION_KEY';

class FSharedPreferences {
  FSharedPreferences(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  Future<bool> setOnboardingValue(bool value) =>
      sharedPreferences.setBool(onboardingKey, value);

  bool get wasOnboardingShown =>
      sharedPreferences.getBool(onboardingKey) ?? false;

  Future<bool> setHasNotification(bool value) =>
      sharedPreferences.setBool(notificationKey, value);

  bool get hasNotification =>
      sharedPreferences.getBool(notificationKey) ?? false;
}
