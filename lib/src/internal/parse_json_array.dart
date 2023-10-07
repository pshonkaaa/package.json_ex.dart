import 'Util.dart';
import 'json_array_impl.dart';

class ParsedJsonArray<T> extends JsonArrayImpl<T> {
  ParsedJsonArray({
    required List<T> rawJson,
  }) : super(
    rawJson: rawJson,
    autoParse: false,
  );


  @override
  JsonArray toJson() {
    if(rawJson is List<JsonArrayImpl>)
      return (rawJson as List<JsonArrayImpl>).map((e) => e.toJson()).toList();
    return rawJson;
  }
}