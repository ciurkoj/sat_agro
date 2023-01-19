import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:satagro/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>?> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class Params extends Equatable {
  final int id;

  const Params({required this.id});

  @override
  List<int> get props => [id];

  int get getId => id;
}