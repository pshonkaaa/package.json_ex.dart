part of truecollaboration.json_ex;

class _ParsedJsonArray<T> extends _WrappedJsonArray<T> {
  _ParsedJsonArray({
    required List<T> rawJson,
  }) : super(
    rawJson: rawJson,
    autoParse: false,
  );


  @override
  JsonArray toJson() {
    if(rawJson is List<_WrappedJsonArray>)
      return (rawJson as List<_WrappedJsonArray>).map((e) => e.toJson()).toList();
    return rawJson;
  }
}