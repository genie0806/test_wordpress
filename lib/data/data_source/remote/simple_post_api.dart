import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:test_virtue/core/result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
<<<<<<< HEAD
import 'package:test_virtue/domain/model/simple_post/simple_post_model.dart';
=======
import 'package:test_virtue/domain/model/simple_post_model/simple_post_model.dart';
>>>>>>> b4b3f698e9ba488e26ab344686aeef26d8b021e0

String baseUrl = dotenv.get('BASE_URL');

class SimplePostApi {
  Future<List<SimplePostModel>> fetchData() async {
    final response = await http.get(Uri.parse(baseUrl + 'latest-posts'));
    Iterable jsonResponse = convert.jsonDecode((response.body));
    List<SimplePostModel> simplePostApi =
        jsonResponse.map((e) => SimplePostModel.fromJson(e)).toList();
    return simplePostApi;
  }
}