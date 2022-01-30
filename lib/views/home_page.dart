import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yemek_siparis_uygulamasi/cubit/home_page_cubit.dart';
import 'package:yemek_siparis_uygulamasi/entities/food_detail.dart';
import 'package:yemek_siparis_uygulamasi/entities/food.dart';
import 'package:yemek_siparis_uygulamasi/entities/user.dart';
import 'package:yemek_siparis_uygulamasi/repository/endpoints.dart';
import 'package:yemek_siparis_uygulamasi/views/detail_page.dart';
import 'package:yemek_siparis_uygulamasi/views/shoppingcart_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/Home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedBottomNavBarItemIndex = 0;
  bool isSearching = false;
  late User user;

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().getAllFoods();
  }

  @override
  Widget build(BuildContext context) {
    var userArgument = ModalRoute.of(context)!.settings.arguments as User;

    if (ModalRoute.of(context)!.isCurrent) {
      user = userArgument;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: isSearching
            ? TextField(
                decoration: const InputDecoration(
                  hintText: "Yemek Ara",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 32.0,
                    fontFamily: "Dongle",
                  ),
                ),
                onChanged: (search) {
                  context.read<HomePageCubit>().getFoodsByKeyword(search);
                },
              )
            : const Text(""),
        leading: isSearching
            ? IconButton(
                icon: const Icon(Icons.cancel),
                color: Colors.white,
                onPressed: () {
                  context.read<HomePageCubit>().getAllFoods();
                  setState(
                    () {
                      isSearching = false;
                    },
                  );
                })
            : IconButton(
                icon: const Icon(Icons.search),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    isSearching = true;
                  });
                }),
        actions: [
          IconButton(
            icon: const Icon(IconData(0xe59c, fontFamily: 'MaterialIcons')),
            onPressed: () {
              setState(() {
                Navigator.pushNamed(
                  context,
                  ShoppingCartPage.routeName,
                  arguments: user,
                );
              });
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Yemek Menüsü",
                style: TextStyle(
                    fontSize: 48.0,
                    fontFamily: "Dongle",
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: BlocBuilder<HomePageCubit, List<Food>>(
                  builder: (context, foods) {
                    if (foods.isNotEmpty) {
                      return GridView.builder(
                        itemCount: foods.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 10 / 12,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          var food = foods[index];

                          return GestureDetector(
                            onTap: () {
                              FoodDetail foodDetail = FoodDetail(
                                food: food,
                                userWhoOrdered: user.name,
                              );

                              Navigator.pushNamed(
                                context,
                                DetailPage.routeName,
                                arguments: foodDetail,
                              ).then((value) {
                                context.read<HomePageCubit>().getAllFoods();
                              });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Card(
                                  elevation: 12.0,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                  child: Image.network(
                                    EndPoints.domain +
                                        EndPoints.getImageOfFood +
                                        food.imageName,
                                    height: 140,
                                    width: 140,
                                  ),
                                ),
                                Text(
                                  food.name,
                                  style: const TextStyle(
                                    fontFamily: "Dongle",
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
