extension EmailValidator on String? {
  bool get isValidEmail {
    if (this == null) return false;
    final email = this!;
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }
}
