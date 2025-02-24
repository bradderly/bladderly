enum Sex {
  female(text: 'Female'),
  male(text: 'Male'),
  ;

  const Sex({
    required this.text,
  });

  final String text;
}
