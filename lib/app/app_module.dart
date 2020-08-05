import 'package:clean_dart_github_search/app/search/presenter/search_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'search/domain/repositories/search_repository.dart';
import 'search/domain/usecases/search_by_text.dart';
import 'search/external/github/github_search_datasource.dart';
import 'search/infra/datasources/search_datasource.dart';
import 'search/infra/repositories/search_repository_impl.dart';

final sl = GetIt.I;

startModule([Dio dio]) {
  sl.registerFactory<SearchByText>(
      () => SearchByTextImpl(sl<SearchRepository>()));
  sl.registerFactory<SearchRepository>(
      () => SearchRepositoryImpl(sl<SearchDatasource>()));
  sl.registerFactory<SearchDatasource>(() => GithubSearchDatasource(sl()));
  sl.registerFactory(() => dio ?? Dio());

  //singleton
  sl.registerLazySingleton(() => SearchCubit(sl<SearchByText>()));
}

disposeModule() {
  sl.get<SearchCubit>().close();
  sl.unregister<SearchCubit>();
}
