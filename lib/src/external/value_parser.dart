import 'package:json_ex/library.dart';

abstract class ValueParser {


  static bool parseBoolean(dynamic value)
    => tryParseBoolean(value)!;

  static int parseInteger(dynamic value)
    => tryParseInteger(value)!;

  static double parseDouble(dynamic value)
    => tryParseDouble(value)!;

  static String parseString(dynamic value)
    => tryParseString(value)!;

  static JsonObjectEx parseJsonObject(dynamic value)
    => tryParseJsonObject(value)!;

  static JsonArrayEx parseJsonArray(dynamic value)
    => tryParseJsonArray(value)!;

  static int sringToInt(String value)
    => tryStringToInt(value)!;

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
      final number = tryStringToInt(value);
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

  static List<T>? tryParseArray<T>(dynamic value) {
    if(value is List) {
      return value.cast();
    } return tryParseJsonArray(value)?.tryCast<T>();
  }

  static JsonObjectEx? tryParseJsonObject(dynamic value) {
    if(value is Map<String, dynamic>) {
      return JsonObjectEx.fromMap(value);
    } else if(value is JsonObjectEx) {
      return value;
    }

    if(value is String) {
      return JsonObjectEx.tryFromJson(value);
    } else if(value is Map<String, dynamic>) {
      return JsonObjectEx.fromMap(value);
    } return null;
  }

  static JsonArrayEx<T>? tryParseJsonArray<T>(dynamic value) {
    if(value is JsonArrayEx<T>)
      return value;

    if(value is String) {
      return JsonArrayEx.fromJson<T>(value);
    } else if(value is List<T>) {
      return JsonArrayEx.fromList<T>(value);
    } return null;
  }

  static int? tryStringToInt(String? value) {
    return value != null ? int.tryParse(value) : null;
  }
}