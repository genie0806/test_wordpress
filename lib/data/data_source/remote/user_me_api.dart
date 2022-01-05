import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:virtue_test/core/result.dart';
import 'package:virtue_test/domain/model/user_me_model/user_me_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

String baseUrl = dotenv.get('BASE_URL');
Map<String, String> _urlHeader = {
  'Authorization': '',
};

class UserMeApi {
  Future<Result<UserMeModel>> fetchUserMe() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl + '/users/me'),
        headers: _urlHeader,
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Result.success(
            UserMeModel.fromJson(convert.jsonDecode(response.body)));
      } else {
        return const Result.error('로그인 연결이 안되어있습니다.');
      }
    } catch (e) {
      return const Result.error('인터넷 연결이 되어있지않습니다.');
    }
  }
}