import 'package:dartz/dartz.dart';

import '../core/errors/failure.dart';

typedef EitherData<T> = Future<Either<Failure, T>>;
