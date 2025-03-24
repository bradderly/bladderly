enum PasscodeSetStatusModel {
  input(text: 'Enter your passcode'),
  confirm(text: 'Confirm your new passcode'),
  ;

  const PasscodeSetStatusModel({required this.text});

  final String text;
}
