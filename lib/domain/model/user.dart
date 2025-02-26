class User {
  const User({
    required this.id,
    required this.email,
    required this.gender,
    required this.yearOfBirth,
    required this.name,
    required this.signupMethod,
  });

  final String id;

  final String gender;

  final int yearOfBirth;

  final String? name;

  final String signupMethod;

  final String? email;
}
