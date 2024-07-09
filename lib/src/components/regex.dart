class RegexPattern {
  static String url =
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9].)[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-@]+))*$";

  static String phone =
      r'^(0|\+|(\+[0-9]{2,4}|\(\+?[0-9]{2,4}\)) ?)([0-9]*|\d{2,4}-\d{2,4}(-\d{2,4})?)$';

  static String image = r'.(jpeg|jpg|gif|png|bmp|webp|heic)$';

  static String audio = r'.(mp3|wav|wma|amr|ogg)$';

  static String cvv = r'^\d{3}$';

// 1 letter 1 number 8 in length
  static String passwordStrong = r'^(?=.*[A-Za-z])(?=.*\d)\S{8,}$';

  static String creditCard = r'^(\d{4}\s?\d{4}\s?\d{4}\s?\d{4})$';

  static String jwt = r'^[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_.+/=]*$';
}

class RegexVal {
  static bool hasMatch(String? str, String pattern) =>
      str == null ? false : RegExp(pattern).hasMatch(str);
}

extension RegexExtension on String {
  bool isPasswordvalid() =>
      RegexVal.hasMatch(this, RegexPattern.passwordStrong);
}
