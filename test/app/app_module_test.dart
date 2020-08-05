import 'dart:convert';

import 'package:clean_dart_github_search/app/app_module.dart';
import 'package:clean_dart_github_search/app/search/domain/entities/result.dart';
import 'package:clean_dart_github_search/app/search/domain/usecases/search_by_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class DioMock extends Mock implements Dio {}

main() {
  var dio = DioMock();

  startModule(dio);

  test('deve executar usecase search_by_text', () async {
    when(dio.get(any)).thenAnswer(
        (_) async => Response(data: jsonDecode(jsonResponse), statusCode: 200));

    var usecase = GetIt.I.get<SearchByText>();
    var result = await usecase("jacob");
    expect(result.isRight(), true);
    expect(result | null, isA<List<Result>>());
  });
}

var jsonResponse = r'''{
  "total_count": 27920,
  "incomplete_results": false,
  "items": [
    {
      "login": "jacob",
      "id": 3121,
      "node_id": "MDQ6VXNlcjMxMjE=",
      "avatar_url": "https://avatars1.githubusercontent.com/u/3121?v=4",
      "gravatar_id": "",
      "url": "https://api.github.com/users/jacob",
      "html_url": "https://github.com/jacob",
      "followers_url": "https://api.github.com/users/jacob/followers",
      "following_url": "https://api.github.com/users/jacob/following{/other_user}",
      "gists_url": "https://api.github.com/users/jacob/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/jacob/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/jacob/subscriptions",
      "organizations_url": "https://api.github.com/users/jacob/orgs",
      "repos_url": "https://api.github.com/users/jacob/repos",
      "events_url": "https://api.github.com/users/jacob/events{/privacy}",
      "received_events_url": "https://api.github.com/users/jacob/received_events",
      "type": "User",
      "site_admin": false,
      "score": 1.0
    }
  ]
}''';
