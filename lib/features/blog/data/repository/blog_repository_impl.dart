import 'dart:ffi';

import 'package:tdd_clean_architecture/core/errors/failures.dart';
import 'package:tdd_clean_architecture/core/network/network_info.dart';
import 'package:tdd_clean_architecture/core/utils/typedef.dart';
import 'package:tdd_clean_architecture/features/blog/data/models/blog_hive_model.dart';
import 'package:tdd_clean_architecture/features/blog/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/exception.dart';
import '../../domain/repositories/repositories.dart';
import '../data_source/data_source.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final BlogLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BlogRepositoryImpl({
    required this.localDataSource,
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<BlogEntity>>> getBlogs() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResult = await remoteDataSource.getBlogs();
        // Convert List<BlogEntity> to List<BlogModel> before saving to local data source
        final blogModels = remoteResult
            .map((entity) => BlogModel(
                  id: entity.id,
                  title: entity.title,
                  body: entity.body,
                  userId: entity.userId,
                ))
            .toList();
        await localDataSource.saveBlogs(blogModels);
        return Right(remoteResult);
      } on ServerException {
        return const Left(ServerFailure(message: 'Error while fetching blogs'));
      }
    } else {
      try {
        // Try to fetch data from the local data source if there's no internet connection
        final localResult = await localDataSource.getBlogs();
        final blogModels = localResult
            .map(
              (entity) => BlogEntity(
                id: entity.id,
                title: entity.title,
                body: entity.body,
                userId: entity.userId,
              ),
            )
            .toList();
        return Right(blogModels);
      } on CacheException {
        return const Left(
            CacheFailure(message: 'Error while fetching blogs from cache'));
      }
    }
  }

  @override
  ResultVoid createBlogs({
    required String title,
    required String body,
    required int userId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
         await remoteDataSource.createBlogs(
          title: title,
          body: body,
          userId: userId,
        );
        return const Right(null);
      } on ServerException {
        return const Left(ServerFailure(message: 'Error while creating blogs'));
      }
    } else {
       return const Left(ServerFailure(message: 'No connection'));
    }
  }
}
