import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  static const String routeName = '/Notification';

  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 240,
                  width: 120,
                  child: Image.asset(
                    "images/checkmark-512x512.png",
                    height: 160,
                    width: 160,
                  ),
                ),
              ),
              const Text(
                "SİPARİŞİNİZ ALINDI,",
                style: TextStyle(
                  fontFamily: "Dongle",
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "AFİYET OLSUN :)",
                style: TextStyle(
                  fontFamily: "Dongle",
                  fontSize: 44,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
