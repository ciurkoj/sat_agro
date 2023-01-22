import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  const Failure([List properties = const  <dynamic>[]]):super();

  @override
  List<Object> get props => [];
}

// General Failures
class ServerFailure extends Failure {
}

class CacheFailure extends Failure {
}

class FieldFailure extends Failure {
}