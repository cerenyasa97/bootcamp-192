mixin InputValidationMixin {
  bool isPasswordValid(String password) => _isValid(
      r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}$',
      password);

  bool isEmailValid(String email) => _isValid(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      email);

  bool isTextValid(String text) => text.isNotEmpty;

  bool _isValid(String pattern, String value) {
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(value);
  }
}