import 'dart:convert';

import 'package:json_ex/src/external/json_array_ex.dart';
import 'package:json_ex/src/external/json_object_ex.dart';

import 'Util.dart';
import 'json_array_impl.dart';
import 'parse_json_array.dart';

class JsonObjectImpl extends JsonObjectEx {
  final Map<String, dynamic> rawJson;

  @override
  bool autoParse;
  JsonObjectImpl({
    required this.rawJson,
    this.autoParse = true,
  });

  


  @override
  dynamic operator [](Object? key) => rawJson[key];

  @override
  void operator []=(String key, dynamic value) {
    if(value == null)
      return;
    
    if(value is JsonArrayImpl)
      rawJson[key] = value.rawJson;
    else if(value is JsonObjectImpl)
      rawJson[key] = value.rawJson;
    else rawJson[key] = value;
  }

  @override
  void clear() => rawJson.clear();

  @override
  dynamic remove(Object? key) => rawJson.remove(key);

  @override
  Iterable<String> get keys => rawJson.keys;


  @override
  bool isNull(String key)
    => containsKey(key) ? (rawJson[key] == null ? true : false) : true;

  @override
  void put(String key, dynamic value) => this[key] = value;



  @override
  dynamic getDynamic(String key) {
    if(!rawJson.containsKey(key))
      return null;
    final value = rawJson[key];
    return value;
  }

  @override
  bool? getBoolean(String key) {
    if(!rawJson.containsKey(key))
      return null;
    final value = rawJson[key];
    if(value is bool) {
      return value;
    } return autoParse ? Util.convert2bool(rawJson[key]) : null;
  }
  
  @override
  int? getInteger(String key) {
    if(!rawJson.containsKey(key))
      return null;
    final value = rawJson[key];
    if(value is int) {
      return value;
    } return autoParse ? Util.convert2int(rawJson[key]) : null;
  }

  @override
  double? getDouble(String key) {
    if(!rawJson.containsKey(key))
      return null;
    final value = rawJson[key];
    if(value is double) {
      return value;
    } return autoParse ? Util.convert2double(rawJson[key]) : null;
  }


  @override
  String? getString(String key) {
    if(!rawJson.containsKey(key))
      return null;
    final value = rawJson[key];
    if(value is String) {
      return value;
    } return autoParse ? Util.convert2string(rawJson[key]) : null;
  }

  @override
  List<T>? getArray<T>(String key) {
    if(!rawJson.containsKey(key))
      return [];
    final value = rawJson[key];
    if(value is List) {
      return value.cast();
    } return autoParse ? Util.convert2jsonArray(rawJson[key])?.tryCast<T>() : null;
  }


  @override
  JsonObjectEx? getJsonObject(String key) {
    if(!rawJson.containsKey(key))
      return null;
    final value = rawJson[key];
    if(value is Map<String, dynamic>) {
      return JsonObjectEx.fromMap(value);
    } else if(value is JsonObjectEx) {
      return value;
    } return autoParse ? Util.convert2jsonObject(rawJson[key]) : null;
  }



  @override
  JsonArrayEx<T>? getJsonArray<T>(String key) {
    if(!rawJson.containsKey(key))
      return null;
    final value = rawJson[key];
    if(value is List) {
      final list = Util.transformList<T>(value);
      return ParsedJsonArray(rawJson: list);
    } else if(value is JsonArrayEx<T>) {
      return value;
    } return autoParse ? Util.convert2jsonArray(rawJson[key]) : null;
  }



  @override
  JsonObject toJson() => rawJson;






  @override
  String serialize()
    => new JsonEncoder.withIndent('  ').convert(toJson());

  @override
  String stringify()
    => jsonEncode(toJson());

  

  @override
  bool tryGetBoolean(String key, bool def) {
    if(!rawJson.containsKey(key))
      return def;
    return Util.convert2bool(rawJson[key]) ?? def;
  }

  @override
  int tryGetInteger(String key, int def) {
    if(!rawJson.containsKey(key))
      return def;
    return Util.convert2int(rawJson[key]) ?? def;
  }

  @override
  double tryGetDouble(String key, double def) {
    if(!rawJson.containsKey(key))
      return def;
    return Util.convert2double(rawJson[key]) ?? def;
  }

  @override
  String tryGetString(String key, String def) {
    if(!rawJson.containsKey(key))
      return def;
    return Util.convert2string(rawJson[key]) ?? def;
  }

  @override
  JsonObjectEx tryGetJsonObject(String key, JsonObjectEx def) {
    if(!rawJson.containsKey(key))
      return def;
    return Util.convert2jsonObject(rawJson[key]) ?? def;
  }

  @override
  JsonArrayEx<T> tryGetJsonArray<T>(String key, JsonArrayEx<T> def) {
    if(!rawJson.containsKey(key))
      return def;
    return Util.convert2jsonArray(rawJson[key]) ?? def;
  }
}