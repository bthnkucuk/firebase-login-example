class RegisterRequestModel {
  final String fullName;
  final String biography;
  final DateTime birthDate;
  final String email;
  final String password;

  RegisterRequestModel({
    required this.fullName,
    required this.biography,
    required this.birthDate,
    required this.email,
    required this.password,
  });
}
