import 'package:bladderly/domain/exception/domain_exception.dart';

class BluetoothHfpException extends DomainException {
  const BluetoothHfpException()
      : super(
          title: 'Detected: Hearing aid or Live Listen feature',
          message:
              'Please disconnect or turn off your hearing aid or the Live Listen feature, as keeping them on can alter your results.',
        );
}
