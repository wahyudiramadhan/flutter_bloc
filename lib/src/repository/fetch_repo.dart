// ignore_for_file: non_constant_identifier_names

import '../model/user.dart';
import '../base/api_base.dart';

class RepositoryFetchData {
  final String _key = "/articles";
  final ApiBase _apiBase = ApiBase();
  Future<List<User>> FetchUsers() async {
    final response = await _apiBase.getData(_key);
    List<User> user =
        (response as List).map((data) => User.fromJson(data)).toList();
    print(user);
    return user;
  }
}
