import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:yemek_siparis_uygulamasi/entities/food.dart';
import 'package:yemek_siparis_uygulamasi/entities/responses/food_response.dart';
import 'package:yemek_siparis_uygulamasi/repository/endpoints.dart';

class FoodDaoRepository {
  Future<List<Food>> getAllFoods() async {
    String uri = EndPoints.domain + EndPoints.getAllFoods;
    var url = Uri.parse(uri);

    var response = await http.get(url);
    var responseBody = FoodResponse.fromJson(json.decode(response.body));
    var foods = responseBody.foods;

    return foods;
  }
}
