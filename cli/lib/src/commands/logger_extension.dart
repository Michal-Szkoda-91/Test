import 'package:mason/mason.dart';

extension StringToBool on String {
  bool toBool() {
    final normalized = toLowerCase().trim();
    return normalized == 'true' || normalized == 'y' || normalized == 'yes';
  }
}

extension LoggerBool on Logger {
  bool ask(String message) {
    return prompt(lightGreen.wrap(message)).toBool();
  }
}
