import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final emailController = TextEditingController();
  final phoneTextController = TextEditingController();

  void initState() {
    emailController.text = "saanvi@example.com";
    phoneTextController.text = "9876543210";
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    phoneTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 102, 181, 196),
              Color.fromARGB(255, 39, 91, 105)
            ])),
        padding: EdgeInsets.only(top: 55, left: 15, right: 15, bottom: 15),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    size: 30, color: Colors.white,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                  width: 15,
                ),
                Text(
                  "Profile",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white,),
                )
              ],
            ),
            Hero(
              tag: "PROFILE_IMG_SETTINGS",
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/profile.jpg") as ImageProvider,
                  radius: 100,
                ),
              ),
            ),
            Hero(
              tag: "PROFILE_NAME_SETTINGS",
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "Saanvi",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Hero(
              tag: "PROFILE_EMAIL_SETTINGS",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFa2c7cd),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.alternate_email_outlined,
                          color: Color(0xFF425053),
                          size: 24,
                        ),
                        border: InputBorder.none,
                        hintText: "Email",
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
              ),
            ),
            Container(
              height: 15,
            ),
            Hero(
              tag: "PROFILE_PHONE_SETTINGS",
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFa2c7cd),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 22, vertical: 5),
                  child: TextField(
                    controller: phoneTextController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          color: Color(0xFF425053),
                          size: 24,
                        ),
                        border: InputBorder.none,
                        hintText: "Phone",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
