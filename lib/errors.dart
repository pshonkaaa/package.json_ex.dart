part of truecollaboration.json_ex;

class JsonFormatException implements Exception {
  final String message;
  const JsonFormatException(this.message);
}

class InputIsNotArrayException extends JsonFormatException {
  const InputIsNotArrayException() : super("Input must be stringified array");
}

class InputIsNotObjectException extends JsonFormatException {
  const InputIsNotObjectException() : super("Input must be stringified object");
}
