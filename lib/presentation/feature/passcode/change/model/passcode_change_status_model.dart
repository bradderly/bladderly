enum PasscodeChangeStatusModel {
  verification(text: 'Enter your old passcode'),
  changing(text: 'Enter your new passcode'),
  confirm(text: 'Confirm your new passcode'),
  ;

  const PasscodeChangeStatusModel({
    required this.text,
  });

  final String text;
}
