import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yemek_siparis_uygulamasi/cubit/detail_page_cubit.dart';
import 'package:yemek_siparis_uygulamasi/entities/food_detail.dart';
import 'package:yemek_siparis_uygulamasi/entities/food.dart';
import 'package:yemek_siparis_uygulamasi/repository/endpoints.dart';

class DetailPage extends StatefulWidget {
  static const String routeName = '/Detail';

  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Food food;
  late String userName;
  int orderedQantity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var foodDetail = ModalRoute.of(context)!.settings.arguments as FoodDetail;

    if (ModalRoute.of(context)!.isCurrent) {
      food = foodDetail.food;
      userName = foodDetail.userWhoOrdered;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0, right: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  elevation: 8.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: SizedBox(
                    height: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              food.name,
                              style: const TextStyle(
                                fontFamily: "Dongle",
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${food.price} ₺",
                              style: const TextStyle(
                                fontFamily: "Dongle",
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Image.network(
                          EndPoints.domain +
                              EndPoints.getImageOfFood +
                              food.imageName,
                          height: 160,
                          width: 160,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 32, color: Colors.amber, thickness: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "SİPARİŞ ADETİ:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontFamily: "Dongle",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (orderedQantity > 1) {
                              orderedQantity--;
                            }
                          });
                        },
                        color: Colors.red,
                      ),
                      Text(
                        orderedQantity.toString(),
                        style: const TextStyle(
                          fontFamily: "Dongle",
                          fontSize: 44,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            orderedQantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32, color: Colors.amber, thickness: 4.0),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.amber),
                  onPressed: () {
                    var orderedFoodName = food.name;
                    var orderedFoodImageName = food.imageName;
                    var orderedFoodPrice = food.price;
                    var orderedQuantity = orderedQantity.toString();
                    var orderedByUser = userName;

                    context.read<DetailPageCubit>().addFoodToShoppingCart(
                        orderedFoodName,
                        orderedFoodImageName,
                        orderedFoodPrice,
                        orderedQuantity,
                        orderedByUser);

                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Text(
                      "SEPETE EKLE",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 26.0,
                          fontFamily: "Dongle",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
