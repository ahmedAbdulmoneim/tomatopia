import 'package:easy_localization/easy_localization.dart';

String? validatePassword(String value) {
  if (value.length < 6) {
    return 'en_password_length'.tr();
  }
  if (!RegExp(r'\d').hasMatch(value)) {
    return 'en_password_digit'.tr();
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'en_password_lowercase'.tr();
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'en_password_uppercase'.tr();
  }
  if (!RegExp(r'\W|_').hasMatch(value)) {
    return 'en_password_special_character'.tr();
  }
  return null;
}
