part of truecollaboration.json_ex;

abstract class JsonSerializable {
  const JsonSerializable.create();
  const JsonSerializable.fromJson(JsonObjectEx json);

  JsonObjectEx toJson();
}