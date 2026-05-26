import 'package:fpdart/fpdart.dart';
import 'package:grab_it/core/errors/failures.dart';

// Type parameters: 'Type' is what the usecase returns on Success.
// Params is what it requires to run.
abstract interface class Usecase<Type, Params> {
  Future<Either<Failures, Type>> call(Params params);
}

// this empty class when no parameters are needed
class NoParams {}
