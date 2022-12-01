part of truecollaboration.json_ex;

abstract class JsonSerializable {
  const JsonSerializable.constructor();
  const JsonSerializable.fromJson(JsonObjectEx json);

  JsonObjectEx toJson();
}