import 'package:clean_dart_github_search/app/search/domain/errors/erros.dart';
import 'package:clean_dart_github_search/app/search/domain/entities/result.dart';
import 'package:clean_dart_github_search/app/search/domain/repositories/search_repository.dart';
import 'package:clean_dart_github_search/app/search/infra/datasources/search_datasource.dart';
import 'package:clean_dart_github_search/app/search/infra/models/result_model.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<Failure, List<Result>>> getUsers(String searchText) async {
    List<ResultModel> list;

    try {
      list = await datasource.searchText(searchText);
    } catch (e) {
      return left(ErrorSearch());
    }

    return list == null ? left(DatasourceResultNull()) : right(list);
  }
}
