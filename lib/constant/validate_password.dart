String? validatePassword(String value) {
  if (value.length < 6) {
    return 'Password must be at least 6 characters long.';
  }
  if (!RegExp(r'\d').hasMatch(value)) {
    return 'Password must contain at least one digit.';
  }
  if (!RegExp(r'[a-z]').hasMatch(value)) {
    return 'Password must contain at least one lowercase letter.';
  }
  if (!RegExp(r'[A-Z]').hasMatch(value)) {
    return 'Password must contain at least one uppercase letter.';
  }
  if (!RegExp(r'\W|_').hasMatch(value)) {
    return 'Password must contain at least one special character.';
  }
  return null;
}
