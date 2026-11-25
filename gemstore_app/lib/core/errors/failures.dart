abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = "Server error occurred"]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = "No internet connection"]);
}

class ParseFailure extends Failure {
  const ParseFailure([super.message = "Data parsing error"]);
}
