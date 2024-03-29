import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_clean_architecture/core/errors/exception.dart';
import 'package:tdd_clean_architecture/core/errors/failures.dart';
import 'package:tdd_clean_architecture/core/network/network_info.dart';
import 'package:tdd_clean_architecture/features/blog/data/data_source/data_source.dart';
import 'package:tdd_clean_architecture/features/blog/data/models/blog_model.dart';
import 'package:tdd_clean_architecture/features/blog/data/repository/repository.dart';
import 'package:dartz/dartz.dart';

class MockBlogRemoteDataSrc extends Mock implements BlogRemoteDataSource {}

class MockBlogLocalDataSrc extends Mock implements BlogLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late BlogRemoteDataSource remoteDataSource;
  late BlogLocalDataSource localDataSource;
  late NetworkInfo networkInfo;
  late BlogRepositoryImpl repository;

  setUp(() {
    remoteDataSource = MockBlogRemoteDataSrc();
    localDataSource = MockBlogLocalDataSrc();
    networkInfo = MockNetworkInfo();
    // Provide a mock implementation for the isConnected property
    when(() => networkInfo.isConnected).thenAnswer((_) async => true);

    // Provide a mock implementation for the saveBlogs method
    when(() => localDataSource.saveBlogs(any()))
        .thenAnswer((_) async => Future.value());

    repository = BlogRepositoryImpl(
      localDataSource: localDataSource,
      networkInfo: networkInfo,
      remoteDataSource: remoteDataSource,
    );
  });

  const title = "blog 1";
  const body = "body 1";
  const userId = 1;

  group('getBlogs', () {
    final tBlogList = [const BlogModel.empty()];

    test('should check if the device is online', () async {
      // Arrange
      when(() => networkInfo.isConnected).thenAnswer((_) async => true);
      when(() => remoteDataSource.getBlogs())
          .thenAnswer((_) async => tBlogList);

      // Act
      repository.getBlogs();

      // Assert
      verify(() => networkInfo.isConnected);
    });

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // Arrange
      when(() => remoteDataSource.getBlogs())
          .thenAnswer((_) async => tBlogList);

      // Act
      final result = await repository.getBlogs();

      // Assert
      expect(result, Right(tBlogList));
      verify(() => remoteDataSource.getBlogs()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // Arrange
      when(() => remoteDataSource.getBlogs())
          .thenThrow(const ServerException());

      // Act
      final result = await repository.getBlogs();

      // Assert
      expect(result,
          const Left(ServerFailure(message: 'Error while fetching blogs')));
      verify(() => remoteDataSource.getBlogs()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // Arrange
      when(() => remoteDataSource.createBlogs(
            title: any(named: "title"),
            body: any(named: "body"),
            userId: any(named: "userId"),
          )).thenAnswer((_) async => Future.value());

      // Act
      final result = await repository.createBlogs(
        title: title,
        body: body,
        userId: userId,
      );

      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => remoteDataSource.createBlogs(
            title: title,
            body: body,
            userId: userId,
          )).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // Arrange
      when(() => remoteDataSource.createBlogs(
            title: any(named: "title"),
            body: any(named: "body"),
            userId: any(named: "userId"),
          )).thenThrow(const ServerException());

      // Act
      final result = await repository.createBlogs(
        title: title,
        body: body,
        userId: userId,
      );

      // Assert
      expect(result,
          const Left(ServerFailure(message: 'Error while creating blogs')));
      verify(() => remoteDataSource.createBlogs(
            title: title,
            body: body,
            userId: userId,
          )).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
