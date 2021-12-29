part of truecollaboration.json_ex;

typedef JsonObject = Map<String, dynamic>;
typedef JsonArray = List<dynamic>;

abstract class _Util {
  static bool? convert2bool(dynamic value) {
    if(value is bool)
    return value;

    if(value is String) {
      final str = value.toLowerCase();
      if(str == "true")
        return true;
      else if(str == "false")
        return false;
      final number = string2int(value);
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

  static int? string2int(String? value) {
    return value != null ? int.tryParse(value) : null;
  }


  static int? convert2int(dynamic value) {
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


  static double? convert2double(dynamic value) {
    if(value is double)
    return value;

    if(value is String) {
      return double.tryParse(value);
    } else if(value is int) {
      return value.toDouble();
    } else if(value is bool) {
      return value == true ? 1 : 0;
    } return null;
  }

  static String? convert2string(dynamic value) {
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