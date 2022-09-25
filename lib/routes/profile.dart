import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tagEat/routes/myProfile.dart';
import 'package:tagEat/routes/settingsPage.dart';
import 'settings.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 65, left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(255, 102, 181, 196), Color.fromARGB(255, 39, 91, 105)])),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    size: 35,
                    color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  child: Text(
                    "Menu",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  margin: EdgeInsets.only(left: 15),
                )
              ],
            ),
            Container(height: 20,),
            RawMaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfile()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 15),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "PROFILE_IMG_SETTINGS",
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/profile.jpg")
                        as ImageProvider,
                        radius: 38,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Hero(
                                tag: "PROFILE_NAME_SETTINGS",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    "Saanvi",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "PROFILE_EMAIL_SETTINGS",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    "saanvi@example.com",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Hero(
                                tag: "PROFILE_PHONE_SETTINGS",
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    "91+ 9876543210",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Expanded(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Settings()));
                    },
                    child: SettingsListItem(
                      tabName: "Settings",
                      icon: Icons.settings,
                    ),
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.black.withOpacity(0.2),
                    indent: 25,
                    endIndent: 40,
                  ),
                  SettingsListItem(
                    tabName: "Terms & Conditions",
                    icon: Icons.book,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.black.withOpacity(0.2),
                    indent: 25,
                    endIndent: 40,
                  ),
                  SettingsListItem(
                    tabName: "Privacy Policy",
                    icon: Icons.privacy_tip,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.black.withOpacity(0.2),
                    indent: 25,
                    endIndent: 40,
                  ),
                  SettingsListItem(
                    tabName: "Contact Us",
                    icon: Icons.call,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "LOG OUT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16, color: Color(0XFF2e6675)),
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
    
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingsListItem extends StatefulWidget {
  String tabName = "Settings";
  IconData icon = Icons.settings;
  SettingsListItem({Key? key, required this.tabName, required this.icon})
      : super(key: key);

  @override
  State<SettingsListItem> createState() => _SettingsListItemState();
}

class _SettingsListItemState extends State<SettingsListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              widget.icon,
              size: 30,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
                color: Color(0XFF6f9ba5),
                borderRadius: BorderRadius.circular(10)),
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              widget.tabName,
              style: TextStyle(
                fontSize: 19,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
