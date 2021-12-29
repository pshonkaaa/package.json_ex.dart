part of truecollaboration.json_ex;

abstract class JsonObjectEx extends MapBase<String, dynamic> implements IJsonEx {
  // CONSTRUCTORS
  //----------------------------------------------------------------------------
  static JsonObjectEx empty() {
    return new _WrappedJsonObject(
      rawJson: {},
    );
  }

  static JsonObjectEx fromJson(
    String json, {
      bool autoParse = true,
  }) {
    final data = jsonDecode(json);
    if(!(data is Map<String, dynamic>) &&
        !(data is Map<String, String>))
      throw(const InputIsNotObjectException());
    return new _WrappedJsonObject(
      rawJson: data,
      autoParse: autoParse,
    );
  }

  static JsonObjectEx? tryFromJson(
    String json, {
      bool autoParse = true,
  }) {
    try { return fromJson(json, autoParse: autoParse); }
    on InputIsNotObjectException { return null; }
    on FormatException { return null; }
  }

  static JsonObjectEx fromMap(Map<String, dynamic> json, {
      bool autoParse = true,
  }) {
    return new _WrappedJsonObject(
      rawJson: json,
      autoParse: autoParse,
    );
  }
  //----------------------------------------------------------------------------





  //----------------------------------------------------------------------------

  late bool autoParse;

  bool isNull(String key);

  void put(String key, dynamic value);
  

  bool? getBoolean(String key);

  int? getInteger(String key);

  double? getDouble(String key);

  String? getString(String key);

  List<T>? getArray<T>(String key);

  JsonObjectEx? getJsonObject(String key);

  JsonArrayEx<T>? getJsonArray<T>(String key);


  JsonObject toJson();

  bool tryGetBoolean(String key, bool def);

  int tryGetInteger(String key, int def);

  double tryGetDouble(String key, double def);
  
  String tryGetString(String key, String def);

  JsonObjectEx tryGetJsonObject(String key, JsonObjectEx def);

  JsonArrayEx<T> tryGetJsonArray<T>(String key, JsonArrayEx<T> def);


  String serialize();

  String stringify();
  //----------------------------------------------------------------------------
}


