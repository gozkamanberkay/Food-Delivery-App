import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yemek_siparis_uygulamasi/entities/food_in_shoppingcart.dart';
import 'package:yemek_siparis_uygulamasi/repository/food_in_shoppingcart_dao_repo.dart';

class ShoppingCartPageCubit extends Cubit<List<FoodInShoppingCart>> {
  ShoppingCartPageCubit() : super(<FoodInShoppingCart>[]);

  var repository = FoodInShoppingCardDaoRepository();

  Future<void> getAllFoodsInShoppingCart(String userName) async {
    var foodsInShoppingCard =
        await repository.getAllFoodsInShoppingCart(userName);

    emit(foodsInShoppingCard);
  }

  Future<void> removeFoodFromShoppingCart(
      String idOfFoodInShoppingCart, String userName) async {
    await repository.removeFoodFromShoppingCart(
        idOfFoodInShoppingCart, userName);
    await getAllFoodsInShoppingCart(userName);
  }
}
