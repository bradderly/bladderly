enum Gender {
  female(text: 'Female'),
  male(text: 'Male'),
  ;

  const Gender({
    required this.text,
  });

  final String text;
}
