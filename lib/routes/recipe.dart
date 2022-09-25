import 'package:flutter/material.dart';
import 'package:tagEat/routes/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
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
                      "Recipes",
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
                    RecipeItem(
                      imageData: "assets/images/veg_korma.png",
                      name: "Veg Korma",
                      url: "https://www.vegrecipesofindia.com/hotel-style-veg-kurma-recipe/",
                    ),
                    RecipeItem(
                      imageData: "assets/images/noodles.png",
                      name: "Chilli Garlic Noodles",
                      url: "https://www.vegrecipesofindia.com/chilli-garlic-noodles-recipe/",
                    ),
                    RecipeItem(
                      imageData: "assets/images/bisibelle.png",
                      name: "Bisibelle Bath",
                      url: "https://www.indianhealthyrecipes.com/bisi-bele-bath/",
                    ),
                    RecipeItem(
                      imageData: "assets/images/mushroom.png",
                      name: "Mushroom Do Pyaza",
                      url: "https://www.vegrecipesofindia.com/mushroom-do-pyaza-recipe/",
                    ),
                    RecipeItem(
                      imageData: "assets/images/fruit_smoothie.png",
                      name: "Fruit Smoothie",
                      url: "https://www.thespruceeats.com/fresh-fruit-smoothies-youll-love-760382",
                    ),
                    RecipeItem(
                      imageData: "assets/images/spaghetti.png",
                      name: "Spaghetti",
                      url: "https://www.archanaskitchen.com/spaghetti-pasta-recipe-in-creamy-tomato-sauce-kids-recipes-made-with-del-monte/amp",
                    ),
                    RecipeItem(
                      imageData: "assets/images/sauteed_veg.png",
                      name: "Sauteed Veg",
                      url: "https://www.acouplecooks.com/sauteed-vegetables/",
                    ),
                    RecipeItem(
                      imageData: "assets/images/aloo_mutter.png",
                      name: "Aloo Mutter",
                      url: "https://www.indianhealthyrecipes.com/aloo-matar-recipe-aloo-mutter-recipe/",
                    ),
                    RecipeItem(
                      imageData: "assets/images/corn_veg_salad.png",
                      name: "Corn Veg Salad",
                      url: "https://www.vegrecipesofindia.com/sweet-corn-salad-recipe/",
                    ),
                    RecipeItem(
                      imageData: "assets/images/banana_cake.png",
                      name: "Banana Cake",
                      url: "https://www.vegrecipesofindia.com/eggless-banana-cake-recipe/",
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class RecipeItem extends StatefulWidget {
  String imageData = "image";
  String name = "Name";
  String url = "https://example.com";
  RecipeItem({
    Key? key,
    required this.imageData,
    required this.name,
    required this.url,
  }) : super(key: key);

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!await launch(widget.url)) throw 'Could not launch URL';
      },
      child: Container(
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
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ClipRRect(
                  child: Image.asset(
                    widget.imageData,
                  ),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.name}",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
