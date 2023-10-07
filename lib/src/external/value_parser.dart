abstract class ValueParser {


  static bool? tryParseBoolean(dynamic value) {
    if(value == null)
      return null;
      
    if(value is bool)
      return value;

    if(value is String) {
      final str = value.toLowerCase();
      if(str == "true")
        return true;
      else if(str == "false")
        return false;
      final number = tryParseStringToInt(value);
      if(number == null)
        return null;
      return number > 0 ? true : false;
    } else if(value is int || value is double) {
      if(value > 0)
        return true;
      else if(value == 0)
        return false;
      return null;
    } return null;
  }

  static int? tryParseInteger(dynamic value) {
    if(value == null)
      return null;

    if(value is int)
      return value;

    if(value is String) {
      return int.tryParse(value);
    } else if(value is double) {
      return value.toInt();
    } else if(value is bool) {
      return value == true ? 1 : 0;
    } return null;
  }

  static double? tryParseDouble(dynamic value) {
    if(value == null)
      return null;

    if(value is String) {
      return double.tryParse(value);
    } else if(value is int) {
      return value.toDouble();
    } else if(value is bool) {
      return value == true ? 1 : 0;
    } return null;
  }



  static String? tryParseString(dynamic value) {
    if(value == null)
      return null;

    if(value is String)
      return value;

    if(value is int) {
      return value.toString();
    } else if(value is double) {
      return value.toString();
    } else if(value is bool) {
      return value? "true" : "false";
    } return null;
  }

  static int? tryParseStringToInt(String? value) {
    return value != null ? int.tryParse(value) : null;
  }
}