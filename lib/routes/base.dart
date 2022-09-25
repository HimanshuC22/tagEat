import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:tagEat/routes/blank.dart';
import 'package:tagEat/routes/recipe.dart';
import 'package:tagEat/routes/restock.dart';
import 'package:tagEat/routes/scanner.dart';
import 'package:tagEat/routes/settings.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'home.dart';
import 'package:pandabar/pandabar.dart';
import 'package:tagEat/constants.dart';
import 'settingsPage.dart';
import 'profile.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:horizontal_picker/horizontal_picker.dart';

int selectedIndex = 0;
String? _chosenValue = 'KGS';
PageController pageController = PageController(initialPage: selectedIndex);

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_chosenValue);
    return Scaffold(
      backgroundColor: Color(0XFFe6f2f2),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          Home(),
          RecipePage(),
          RestockPage(),
          Settings(),
        ],
      ),
      bottomNavigationBar: PandaBar(
        fabIcon: Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.white,
        ),
        onFabButtonPressed: () async {
          String? result = await Navigator.push(
              context, MaterialPageRoute(builder: ((context) => QRScanner())));
          print("QR CODE RESULT = $result");
        },
        backgroundColor: Colors.black.withOpacity(0.05),
        buttonSelectedColor: primaryColor,
        fabColors: [primaryColor, Color.fromARGB(255, 102, 181, 196)],
        buttonData: [
          PandaBarButtonData(id: 0, icon: Icons.home_outlined, title: "Home"),
          PandaBarButtonData(
              id: 1, icon: Icons.dinner_dining_outlined, title: "Recepies"),
          PandaBarButtonData(
              id: 2, icon: Icons.inventory_2_outlined, title: "Restock"),
          PandaBarButtonData(
              id: 3, icon: Icons.settings_outlined, title: "Settings"),
        ],
        onChange: (index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeIn);
        },
      ),
    );
  }
}
