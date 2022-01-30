import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yemek_siparis_uygulamasi/entities/food.dart';
import 'package:yemek_siparis_uygulamasi/repository/food_dao_repo.dart';

class HomePageCubit extends Cubit<List<Food>> {
  HomePageCubit() : super(<Food>[]);

  var repository = FoodDaoRepository();

  Future<void> getAllFoods() async {
    var foods = await repository.getAllFoods();

    emit(foods);
  }

  Future<void> getFoodsByKeyword(String foodName) async {
    var foods = await repository.getAllFoods();
    var foundFoods = foods
        .where(
            (food) => food.name.toLowerCase().contains(foodName.toLowerCase()))
        .toList();

    emit(foundFoods);
  }
}
