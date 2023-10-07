
import 'dart:convert';

import 'package:json_ex/src/external/json_array_ex.dart';
import 'package:json_ex/src/external/json_object_ex.dart';
import 'package:json_ex/src/external/value_parser.dart';

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

abstract class Util {
  static bool? convert2bool(dynamic value)
    => ValueParser.tryParseBoolean(value);


  static int? convert2int(dynamic value)
    => ValueParser.tryParseInteger(value);


  static double? convert2double(dynamic value)
    => ValueParser.tryParseDouble(value);

  static String? convert2string(dynamic value)
    => ValueParser.tryParseString(value);

  static JsonObjectEx? convert2jsonObject(dynamic value) {
    if(value is JsonObjectEx)
      return value;

    if(value is String) {
      return JsonObjectEx.tryFromJson(value);
    } else if(value is Map<String, dynamic>) {
      return JsonObjectEx.fromMap(value);
    } return null;
  }

  static JsonArrayEx<T>? convert2jsonArray<T>(dynamic value) {
    if(value is JsonArrayEx<T>)
      return value;

    if(value is String) {
      return JsonArrayEx.fromJson<T>(value);
    } else if(value is List<T>) {
      return JsonArrayEx.fromList<T>(value);
    } return null;
  }

  static List? convert2list(dynamic value) {
    if(value is String) {
      try { return jsonDecode(value) as List; }
      catch(e) { return null; }
    } else if(value is List) {
      return value;
    } return null;
  }

  static List<T> transformList<T>(List<dynamic> list) {
    if(list.isEmpty)
      return [];
    dynamic element;
    for(final v in list) {
      if(element == null)
        element = v;
      else if(element.runtimeType != v.runtimeType) {
        element = null;
        break;
      }
    }

    if(element == null)
      throw(new Exception("List is dynamic"));
    if(!(element is T)) {
      if(T == JsonObjectEx && element is JsonObject)
        list = list.map((e) => JsonObjectEx.fromMap(e)).toList();
      else if(T == JsonArrayEx && element is JsonArray)
        list = list.map((e) => JsonArrayEx.fromList(e)).toList();
      else throw(new Exception("Cant convert List<${element.runtimeType}> to List<$T>"));
    } return list.cast();
  }

  static bool isPrimitiveType<T>() {
    if(T == int)
      return true;
    if(T == double)
      return true;
    if(T == num)
      return true;
    if(T == bool)
      return true;
    if(T == String)
      return true;
    if(T == List)
      return true;
    if(T == Map)
      return true;
    return false;
  }
}