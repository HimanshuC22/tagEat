import 'package:flutter/material.dart';
import 'package:tagEat/routes/allDevices.dart';
import 'package:tagEat/routes/home.dart';
import 'package:tagEat/routes/profile.dart';
import '../API.dart';
import 'package:tagEat/constants.dart';
import '../DeviceData.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List deviceList = [];
  List<DeviceData> tempDeviceList = [];
  void getDeviceData() async {
    deviceList = await fetchDeviceData();
    setState(() {
      print(deviceList);
      deviceList.forEach((element) {
        DateTime endTime = DateTime(
            int.parse(element["endTime"].substring(0, 4)),
            int.parse(element["endTime"].substring(5, 7)),
            int.parse(element["endTime"].substring(8, 10)));
        tempDeviceList.add(DeviceData(
            battery: element["battery"] ?? 0,
            id: element["id"],
            name: element["type"],
            initQty: element["qty"].round(),
            qty: (element["qty"] - element["qty_used"]).round(),
            qtyUnit: "Kgs",
            initTime: element["initTimerMins"],
            time: (endTime.difference(DateTime.now()).inHours / 24).round(),
            timeUnit: "days"));
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
    return Scaffold(
      body: Container(
        child: Column(
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
                        "Settings",
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
                ],
              ),
            ),
            Container(
              height: 25,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SettingsItem(
                      onPressed: () {},
                      iconData: Icons.record_voice_over_outlined,
                      title: "Link Voice Assistant",
                      desc: "Google Assistant and Amazon Alexa",
                      color: Colors.blue,
                    ),
                    SettingsItem(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => AllDevicesPage(
                        //               devicesList: tempDeviceList,
                        //             )));
                      },
                      iconData: Icons.home_max_outlined,
                      title: "Manage Devices",
                      desc: "Manage all the paired devices",
                      color: Colors.orange,
                    ),
                    SettingsItem(
                      onPressed: () {},
                      iconData: Icons.person_add_outlined,
                      title: "Add People",
                      desc: "Give access to more people",
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsItem extends StatefulWidget {
  IconData iconData = Icons.settings_outlined;
  Color color = Colors.blue;
  String title = "Setting";
  String desc = "Description";
  Function onPressed = () {};
  SettingsItem({
    Key? key,
    required this.iconData,
    required this.color,
    required this.title,
    required this.desc,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.25),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                widget.iconData,
                size: 32,
                color: widget.color,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.title}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                  Text(
                    "${widget.desc}",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 12),
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
