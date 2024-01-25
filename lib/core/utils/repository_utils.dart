import 'package:dartz/dartz.dart';
import 'package:readmock/core/errors/failure.dart';
import 'package:readmock/core/networks/network_info.dart';
import 'package:readmock/core/errors/exceptions.dart';

class RepositoryUtils {
  static Future<Either<Failure, T>> execute<T>(
    NetworkInfo networkInfo,
    Future<T> Function() requestFunction,
  ) async {
    if (!(await networkInfo.isConnected())) {
      return const Left(NoInternetFailure());
    }

    try {
      final response = await requestFunction();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
