import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tagEat/constants.dart';
import 'package:tagEat/routes/itempage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'myProfile.dart';
import 'package:tagEat/routes/profile.dart';
import '../API.dart';
import '../DeviceData.dart';

// var deviceList = [
//   {
// //     "name": "Tomatoes",
// //     "initQty": 15,
// //     "qty": 12,
// //     "qtyUnit": "kgs",
// //     "initTime": 20,
// //     "time": 7,
// //     "timeUnit": "days",
// //     "battery": 76,
// //     "imageLink": "assets/images/tomatoes.png",
// //   },
//   {
//     "name": "Potatoes",
//     "initQty": 40,
//     "qty": 32,
//     "qtyUnit": "kgs",
//     "initTime": 40,
//     "time": 35,
//     "timeUnit": "days",
//     "battery": 46,
//     "imageLink": "assets/images/potatoes.png",
//   },
//   {
//     "name": "Cucumber",
//     "initQty": 50,
//     "qty": 9,
//     "qtyUnit": "kgs",
//     "initTime": 10,
//     "time": 7,
//     "timeUnit": "days",
//     "battery": 70,
//     "imageLink": "assets/images/cucumber.png",
//   },
//   {
//     "name": "Onion",
//     "initQty": 45,
//     "qty": 24,
//     "qtyUnit": "kgs",
//     "initTime": 20,
//     "time": 18,
//     "timeUnit": "days",
//     "battery": 66,
//     "imageLink": "assets/images/onion.png",
//   },
// ];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List deviceList = [];
  List<DeviceData> tempDeviceList = [];

  Future<void> getDeviceData() async {
    deviceList = await fetchDeviceData();
    setState(() {
      tempDeviceList = [];
      deviceList.forEach((element) {
        DateTime endTime = DateTime(
            int.parse(element["endTime"].substring(0, 4)),
            int.parse(element["endTime"].substring(5, 7)),
            int.parse(element["endTime"].substring(8, 10)));
        tempDeviceList.add(
          DeviceData(
            battery: (element["battery"] ?? 0).round(),
            id: element["id"],
            name: element["type"],
            initQty: element["qty"].round(),
            qty: (element["qty"] - element["qty_used"]).round(),
            qtyUnit: "Kgs",
            initTime: element["initTimerMins"],
            time: (endTime.difference(DateTime.now()).inDays).round(),
            timeUnit: "days",
          ),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDeviceData();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getDeviceData,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 102, 181, 196),
                        Color.fromARGB(255, 39, 91, 105)
                      ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              padding: EdgeInsets.only(top: 70, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "tagEat",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Center(
                      child: Text(
                    "Home",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => ProfilePage()));
                    },
                    child: Hero(
                      tag: "PROFILE_IMG_SETTINGS",
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* Container(
              margin: EdgeInsets.all(15),
              child: Text(
                "Home",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15, left: 15, right: 15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => ProfilePage()));
                    },
                    child: Hero(
                      tag: "PROFILE_PIC",
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person_outline),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Hero(
                          tag: "PROFILE_NAME",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "Himanshu Choudhary",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ), */
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Text("Your Inventory", style: TextStyle(fontSize: 30)),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: GridView.count(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    children: List.generate(
                        tempDeviceList.length,
                        (index) => Device(
                              image: Image.asset(
                                  tempDeviceList[index].imageLink.toString()),
                              qty: double.parse(
                                  tempDeviceList[index].qty.toString()),
                              time: double.parse(
                                  tempDeviceList[index].time.toString()),
                              name: tempDeviceList[index].name.toString(),
                              qtyUnit: tempDeviceList[index].qtyUnit.toString(),
                              timeUnit:
                                  tempDeviceList[index].timeUnit.toString(),
                              initialQty: double.parse(
                                  tempDeviceList[index].initQty.toString()),
                              initialTime: double.parse(
                                  tempDeviceList[index].initTime.toString()),
                              id: tempDeviceList[index].id.toString(),
                              getDeviceData: getDeviceData,
                            ))),
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Suggested Recipies",
                        style: TextStyle(
                            fontSize: 16, color: Colors.black.withOpacity(0.5)),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Recepie(
                            image:
                                const AssetImage("assets/images/veg_korma.png"),
                            name: "Veg Korma",
                            url:
                                "https://www.vegrecipesofindia.com/hotel-style-veg-kurma-recipe/",
                          ),
                          Recepie(
                            image:
                                const AssetImage("assets/images/noodles.png"),
                            name: "Chilli Garlic Noodles",
                            url:
                                "https://www.vegrecipesofindia.com/chilli-garlic-noodles-recipe/",
                          ),
                          Recepie(
                            image:
                                const AssetImage("assets/images/bisibelle.png"),
                            name: "Bisibelle Bath",
                            url:
                                "https://www.indianhealthyrecipes.com/bisi-bele-bath/",
                          ),
                          Recepie(
                            image:
                                const AssetImage("assets/images/mushroom.png"),
                            name: "Mushroom Do Pyaza",
                            url:
                                "https://www.vegrecipesofindia.com/mushroom-do-pyaza-recipe/",
                          ),
                          Recepie(
                            image: const AssetImage(
                                "assets/images/fruit_smoothie.png"),
                            name: "Fruit Smoothie",
                            url:
                                "https://www.thespruceeats.com/fresh-fruit-smoothies-youll-love-760382",
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class Recepie extends StatelessWidget {
  ImageProvider image = AssetImage("assets/images/pizza.png");
  String name;
  String url;
  Recepie({
    Key? key,
    required this.image,
    required this.name,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!await launch(url)) throw 'Could not launch URL';
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 40,
              backgroundImage: image,
            ),
            Container(
              child: Text(
                name,
                textAlign: TextAlign.center,
              ),
              width: 80,
              alignment: Alignment.topCenter,
            ),
          ],
        ),
      ),
    );
  }
}

class Device extends StatefulWidget {
  Image image = Image.asset(
    "assets/images/tomatoes.png",
  );
  double qty = 0;
  double time = 0;
  String name = "Name";
  String qtyUnit = "kg";
  String timeUnit = "days";
  double initialQty = 1;
  double initialTime = 1;
  String id;
  Function getDeviceData;
  Device({
    Key? key,
    required this.image,
    required this.qty,
    required this.time,
    required this.name,
    required this.qtyUnit,
    required this.timeUnit,
    required this.initialQty,
    required this.initialTime,
    required this.id,
    required this.getDeviceData,
  }) : super(key: key);

  @override
  State<Device> createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      splashColor: Colors.green.withOpacity(0.35),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey.withOpacity(0.15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "${widget.id}_IMAGE",
              child: Container(
                height: 100,
                width: 100,
                child: widget.image,
              ),
            ),
            Container(
              // margin: EdgeInsets.symmetric(vertical: 5),
              child: Hero(
                tag: "${widget.id}_NAME",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "${widget.qty} ${widget.qtyUnit}",
                    style: TextStyle(fontSize: 16),
                  ),
                  margin: EdgeInsets.only(right: 10),
                ),
                Text(
                  "${widget.time} ${widget.timeUnit}",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
      onPressed: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemPage(
                      image: widget.image,
                      qty: widget.qty,
                      time: widget.time,
                      name: widget.name,
                      qtyUnit: widget.qtyUnit,
                      timeUnit: widget.timeUnit,
                      initialQty: widget.initialQty,
                      initialTime: widget.initialTime,
                      battery: 70.0,
                      id: widget.id,
                    )));
        widget.getDeviceData();
      },
    );
  }
}
