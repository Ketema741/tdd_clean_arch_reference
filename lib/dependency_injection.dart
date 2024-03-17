// Creating a new instance of GetIt
import 'package:tdd_clean_architecture/core/network/network_info.dart';
import 'package:tdd_clean_architecture/features/blog/data/data_source/local_data_source/blog_local_data_source.dart';
import 'package:tdd_clean_architecture/features/blog/data/data_source/remote_data_source/blog_remote_data_source.dart';
import 'package:tdd_clean_architecture/features/blog/data/repository/blog_repository_impl.dart';
import 'package:tdd_clean_architecture/features/blog/domain/repositories/blog_repository.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/create_blog.dart';
import 'package:tdd_clean_architecture/features/blog/domain/usecases/get_blog.dart';
import 'package:tdd_clean_architecture/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

void init() {
  // Registering the BlogUseCase as a lazy singleton
  sl.registerLazySingleton(() => GetBlog(sl()));
  sl.registerLazySingleton(() => CreateBlog(sl()));

  // Registering the BlogRepositoryImpl as a lazy singleton
  sl.registerLazySingleton<BlogRepository>(() => BlogRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
        localDataSource: sl(),
      ));

  // Registering the BlogRemoteDataSourceImpl as a lazy singleton
  sl.registerLazySingleton<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(client: sl()));

  // Registering the BlogLocalDataSourceImpl as a lazy singleton
  sl.registerLazySingleton<BlogLocalDataSource>(
      () => BlogLocalDataSourceImpl());

  // Registering the LoginBloc as a factory
  sl.registerFactory(() => BlogBloc(getBlogUseCase: sl(), createBlogUseCase: sl()));

  // Registering the NetworkInfoImpl as a lazy singleton
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        InternetConnectionChecker(),
      ));

  // Registering the http client as a lazy singleton
  sl.registerLazySingleton(() => http.Client());
}
