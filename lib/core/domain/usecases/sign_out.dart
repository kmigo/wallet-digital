import 'package:dartz/dartz.dart';


import '../erros/failure.dart';

abstract class SignOutUsecase {
  Future<Either<Failure,void>> call();
}