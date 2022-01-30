import 'package:flutter/material.dart';

import 'package:yemek_siparis_uygulamasi/entities/user.dart';
import 'package:yemek_siparis_uygulamasi/views/home_page.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = '/Welcome';

  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late User user;
  var tfUserName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text("Yemek Sipariş Uygulaması"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Merhaba, \nSize nasıl hitap etmemizi istersiniz?",
                    style: TextStyle(
                        fontSize: 32.0,
                        fontFamily: "Dongle",
                        fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: tfUserName,
                    decoration:
                        const InputDecoration(hintText: "Adınızı giriniz"),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.amber),
                onPressed: () {
                  User user = User(name: tfUserName.text);

                  Navigator.pushNamed(
                    context,
                    HomePage.routeName,
                    arguments: user,
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    "KAYDET",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 26.0,
                        fontFamily: "Dongle",
                        fontWeight: FontWeight.bold),
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
