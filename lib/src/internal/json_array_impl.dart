import 'dart:convert';

import 'package:json_ex/src/external/json_array_ex.dart';
import 'package:json_ex/src/external/json_object_ex.dart';

import 'Util.dart';

class JsonArrayImpl<T> extends JsonArrayEx<T> {
  final List<T> rawJson;

  @override
  final bool autoParse;
  JsonArrayImpl({
    required this.rawJson,
    this.autoParse = true,
  });

  @override
  int get length => rawJson.length;

  @override
  set length(int newLength) => rawJson.length = newLength;

  @override
  T operator [](int index) => rawJson[index];

  @override
  void operator []=(int index, T value) => rawJson[index] = value;
  
  @override
  bool isNull(int index)
    => _isInRange(index) ? (rawJson[index] == null ? true : false) : true;

  @override
  dynamic getDynamic(int index) {
    if(!_isInRange(index))
      return null;
    final value = rawJson[index];
    return value;
  }

  @override
  bool? getBoolean(int index) {
    if(!_isInRange(index))
      return null;
    final value = rawJson[index];
    if(value is bool) {
      return value;
    } return autoParse ? Util.convert2bool(rawJson[index]) : null;
  }
  

  @override
  int? getInteger(int index) {
    if(!_isInRange(index))
      return null;
    final value = rawJson[index];
    if(value is int) {
      return value;
    } return autoParse ? Util.convert2int(rawJson[index]) : null;
  }

  @override
  double? getDouble(int index) {
    if(!_isInRange(index))
      return null;
    final value = rawJson[index];
    if(value is double) {
      return value;
    } return autoParse ? Util.convert2double(rawJson[index]) : null;
  }
  


  @override
  String? getString(int index) {
    if(!_isInRange(index))
      return null;
    final value = rawJson[index];
    if(value is String) {
      return value;
    } return autoParse ? Util.convert2string(rawJson[index]) : null;
  }

  @override
  List<T>? getArray<T>(int index) {
    if(!_isInRange(index))
      return null;
    final value = rawJson[index];
    if(value is List) {
      return value.cast();
    } return autoParse ? Util.convert2jsonArray(rawJson[index])?.tryCast<T>() : null;
  }


  @override
  JsonObjectEx? getJsonObject(int index) {
    if(!_isInRange(index))
      return null;
    final value = rawJson[index];
    if(value is Map<String, dynamic>) {
      return JsonObjectEx.fromMap(value);
    } else if(value is JsonObjectEx) {
      return value;
    } return autoParse ? Util.convert2jsonObject(rawJson[index]) : null;
  }



  @override
  JsonArrayEx<T>? getJsonArray<T>(int index) {
    if(!_isInRange(index))
      return null;
    final value = rawJson[index];
    if(value is List<T>) {
      return JsonArrayEx.fromList<T>(value);
    } else if(value is JsonArrayEx<T>) {
      return value;
    } return autoParse ? Util.convert2jsonArray(rawJson[index]) : null;
  }

  

  @override
  List<T> cast<T>() {
    final List<T> list = [];

    Function? fnc;
    if(T == JsonObjectEx)
      fnc = Util.convert2jsonObject;
    else if(T == JsonArrayEx)
      fnc = Util.convert2jsonArray;

    for(final value in rawJson) {
      var newValue = fnc == null ? value as T : fnc(value) as T?;
      if(newValue != null)
        list.add(newValue);
    } return list;
    // try { return rawJson.cast<T>(); }
    // catch(e) { return null; }
  }

  @override
  List<T> tryCast<T>() {
    // int hash = rawJson.isEmpty ? 0 : rawJson[0].runtimeType.hashCode;
    // for(final value in rawJson) {
    //   if(value.runtimeType.hashCode != hash)
    //     return [];
    // }
    final List<T> list = [];
    Function fnc;
    if(T == int)
      fnc = Util.convert2int;
    else if(T == bool)
      fnc = Util.convert2bool;
    else if(T == String)
      fnc = Util.convert2string;
    else if(T == JsonObjectEx)
      fnc = Util.convert2jsonObject;
    else if(T == JsonArrayEx)
      fnc = Util.convert2jsonArray;
    else return list;

    
    for(final value in Util.convert2list(rawJson) ?? []) {
      final newValue = fnc(value) as T?;
      if(newValue != null)
        list.add(newValue);
    } return list;
  }

  @override
  JsonArray toJson() => rawJson;


  @override
  String serialize()
    => new JsonEncoder.withIndent('  ').convert(toJson());

  @override
  String stringify()
    => jsonEncode(toJson());





    


  @override
  bool tryGetBoolean(int index, bool def) {
    if(!_isInRange(index))
      return def;
    return Util.convert2bool(rawJson[index]) ?? def;
  }

  @override
  int tryGetInteger(int index, int def) {
    if(!_isInRange(index))
      return def;
    return Util.convert2int(rawJson[index]) ?? def;
  }

  @override
  double tryGetDouble(int index, double def) {
    if(!_isInRange(index))
      return def;
    return Util.convert2double(rawJson[index]) ?? def;
  }

  @override
  String tryGetString(int index, String def) {
    if(!_isInRange(index))
      return def;
    return Util.convert2string(rawJson[index]) ?? def;
  }

  @override
  JsonObjectEx tryGetJsonObject(int index, JsonObjectEx def) {
    if(!_isInRange(index))
      return def;
    return Util.convert2jsonObject(rawJson[index]) ?? def;
  }
  @override
  JsonArrayEx<T> tryGetJsonArray<T>(int index, JsonArrayEx<T> def) {
    if(!_isInRange(index))
      return def;
    return Util.convert2jsonArray<T>(rawJson[index]) ?? def;
  }















  bool _isInRange(int index) {
    if(rawJson.length - 1 < index)
      return false;
    return true;
  }
  
  // bool setValue(int index, dynamic value) {
  //   if(!_isInRange(index))
  //     return false;
  //   if(Util.isPrimitiveType(value)) {
  //     rawJson[index] = value;
  //     return true;
  //   } else if(value is _NeonJsonArray) {
  //     rawJson[index] = value.rawJson;
  //     return true;
  //   } else if(value is _JsonObjectEx) {
  //     rawJson[index] = value.rawJson;
  //     return true;
  //   } return false;
  // }
  
  // @override
  // bool pushValue(dynamic value) {
  //   if(Util.isPrimitiveType(value)) {
  //     rawJson.add(value);
  //     return true;
  //   } else if(value is _NeonJsonArray) {
  //     rawJson.add(value.rawJson);
  //     return true;
  //   } else if(value is _JsonObjectEx) {
  //     rawJson.add(value.rawJson);
  //     return true;
  //   } return false;
  // }




  // void forEach<T>(void Function(T e) func) {
  //   if(!Util.isPrimitiveType<T>())
  //     return;
  //   var converter = Util.functionByPrimitive<T>(
  //     integer:  Util.convert2int,
  //     boolean:  Util.convert2bool,
  //     string:   Util.convert2string,
  //   );
  //   rawJson.forEach((e) {
  //     // try {
  //     func(converter!(e));
  //     // } catch(err) {
  //     //   debugger();
  //     //   var i = converter(e);
  //     //   print("$i");
  //     //   print("$e");
  //     //   _isPrimitiveType<T>();
  //     // }
  //   });
  // }

  // void forEachObject(void f(JsonObjectEx e) ) {
  //   rawJson.forEach((e) {
  //     if(e is String)
  //       f.call(JsonObjectEx.fromJson(e));
  //     else f.call(JsonObjectEx.fromMap(e));
  //   });
  // }
  // void forEachInteger(void f(int e) ) {
  //   rawJson.forEach((e) {
  //     f.call(e);
  //   });
  // }
  // void forEachString(void f(String e) ) {
  //   rawJson.forEach((e) {
  //     f.call(e);
  //   });
  // }


  // List<JsonObjectEx> toListObject() {
  //   return List<JsonObjectEx>.from(
  //     rawJson.map((e) => JsonObjectEx.fromMap(e))
  //   );
  // }
  // List<int> toListInteger() {
  //   return List<int>.from(rawJson);
  // }
  // List<String> toListString() {
  //   return List<String>.from(rawJson);
  // }




  //for realization
  //----------------------------------------------------------------------------
  // Iterator<T> toIterator<T>() {
  //   return new _ArrayIterator<T>(this);
  // }
  //----------------------------------------------------------------------------

}