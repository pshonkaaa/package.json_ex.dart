import 'json_object_ex.dart';

abstract class JsonSerializable {
  const JsonSerializable.create();
  const JsonSerializable.fromJson(JsonObjectEx json);

  JsonObjectEx toJson();
}