part of truecollaboration.json_ex;

abstract class JsonArrayEx<T> extends ListBase<T> implements IJsonEx {
  // CONSTRUCTORS
  //----------------------------------------------------------------------------
  static JsonArrayEx<T> empty<T>() {
    return new _WrappedJsonArray<T>(
      rawJson: [],
    );
  }

  static JsonArrayEx<T> fromJson<T>(
    String json, {
      bool autoParse = true,
  }) {
    final data = jsonDecode(json);
    if(!(data is List<T>))
      throw(const InputIsNotArrayException());
    return new _WrappedJsonArray<T>(
      rawJson: data,
      autoParse: autoParse,
    );
  }

  static JsonArrayEx<T>? tryFromJson<T>(
    String json, {
      bool autoParse = true,
  }) {
    try { return fromJson<T>(json, autoParse: autoParse); }
    on InputIsNotArrayException { return null; }
    on FormatException { return null; }
  }

  static JsonArrayEx<T> fromList<T>(
    List<T> list, {
      bool autoParse = true,
  }) {
    return new _WrappedJsonArray<T>(
      rawJson: list,
      autoParse: autoParse,
    );
  }
  //----------------------------------------------------------------------------








  
  //----------------------------------------------------------------------------
  late final bool autoParse;
  
  bool isNull(int index);

  // bool setValue(int index, dynamic value);
  // bool pushValue(dynamic value);


  dynamic getDynamic(int index);

  bool? getBoolean(int index);

  int? getInteger(int index);

  double? getDouble(int index);

  String? getString(int index);

  List<T>? getArray<T>(int index);

  JsonObjectEx? getJsonObject(int index);

  JsonArrayEx<T>? getJsonArray<T>(int index);


  List<T> tryCast<T>();

  JsonArray toJson();


  String serialize();
  String stringify();


  bool tryGetBoolean(int index, bool def);
  int tryGetInteger(int index, int def);
  double tryGetDouble(int index, double def);
  String tryGetString(int index, String def);
  JsonObjectEx tryGetJsonObject(int index, JsonObjectEx def);
  JsonArrayEx<T> tryGetJsonArray<T>(int index, JsonArrayEx<T> def);
  //----------------------------------------------------------------------------






  // void forEach<T>(void Function(T e) func);

  // void forEachObject(void f(JsonObjectEx e));

  // void forEachInteger(void f(int e));

  // void forEachString(void f(String e));
  //for realization
  //----------------------------------------------------------------------------
  // Iterator<T> toIterator<T>() {
  //   return new _ArrayIterator<T>(this);
  // }
  //----------------------------------------------------------------------------
}






// class _ArrayIterator<T> implements Iterator<T> {
//   NeonJsonArray _jsonArray;
//   int _index = 0;

//   _ArrayIterator(this._jsonArray);

//   bool moveNext() {
//     if(_index < _jsonArray.rawJson.length) {
//       _index++;
//       return true;
//     } return false;
//   }

//   T get current => (_index < 0) ? null : _jsonArray.rawJson[_index];
// }