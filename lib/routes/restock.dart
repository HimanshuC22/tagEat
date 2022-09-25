import 'package:flutter/material.dart';
import 'package:tagEat/routes/base.dart';
import 'package:tagEat/routes/profile.dart';

class RestockPage extends StatefulWidget {
  const RestockPage({Key? key}) : super(key: key);

  @override
  State<RestockPage> createState() => _RestockPageState();
}

class _RestockPageState extends State<RestockPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "tagEat",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Center(
                        child: Text(
                      "Restock",
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFa2c7cd),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Color(0xFF425053),
                          size: 24,
                        ),
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle:
                            TextStyle(color: Color(0xFF425053), fontSize: 16),
                        contentPadding: EdgeInsets.zero,
                        isDense: true),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF425053),
                    ),
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RestockItem(name: "Potatoes", price: 120, uri: "assets/images/potatoes.png", text: "Blinkit"),
                  RestockItem(name: "Tomatoes", price: 145, uri: "assets/images/tomatoes.png", text: "Blinkit"),
                  RestockItem(name: "Cucumber", price: 70, uri: "assets/images/cucumber.png", text: "BigBasket"),
                  RestockItem(name: "Onion", price: 100, uri: "assets/images/onion.png", text: "BigBasket"),
                  RestockItem(name: "Tomatoes", price: 95, uri: "assets/images/tomatoes.png", text: "Swiggy"),
                  RestockItem(name: "Potatoes", price: 90, uri: "assets/images/potatoes.png", text: "Swiggy"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RestockItem extends StatefulWidget {
  String name = "Name";
  int price = 50;
  String uri = "assets/images/potatoes.png";
  String text = "Blinkit";

  RestockItem({
    Key? key,
    required this.name,
    required this.price,
    required this.uri,
    required this.text,
  }) : super(key: key);

  @override
  State<RestockItem> createState() => _RestockItemState();
}

class _RestockItemState extends State<RestockItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 75,
            width: 75,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ClipRRect(
                child: Image.asset(
                  widget.uri,
                ),
                borderRadius: BorderRadius.circular(10)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "50% off on 2+ kg of ${widget.name}",
                  style: TextStyle(
                      fontSize: 12, color: Colors.black.withOpacity(0.4)),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            width: 100,
            decoration: BoxDecoration(
                color: Color(0XFFfd7f63),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "MRP",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                  Text(
                    "${widget.price}",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                  Text(
                    "PER KG",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
