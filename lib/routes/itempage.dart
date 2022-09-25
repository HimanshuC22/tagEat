import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:battery_indicator/battery_indicator.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:tagEat/API.dart';
import 'package:tagEat/constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

final qtyController = TextEditingController();
final initQtyController = TextEditingController();
final nameTextController = TextEditingController();

String? _chosenValue = 'KGS';
String qty_units = "KGS";
int daysValue = 0;
int hrsValue = 0;

class ItemPage extends StatefulWidget {
  Image image = Image.asset(
    "assets/images/tomatoes.png",
  );
  double qty = 0;
  double initialQty = 1;
  double initialTime = 1;
  double time = 0;
  String name = "Name";
  String qtyUnit = "kg";
  String timeUnit = "days";
  double battery = 100;
  String id;

  ItemPage({
    Key? key,
    required this.image,
    required this.qty,
    required this.time,
    required this.name,
    required this.qtyUnit,
    required this.timeUnit,
    required this.initialQty,
    required this.initialTime,
    required this.battery,
    required this.id,
  }) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late WebSocketChannel channel;

  Map<String, Color?> ringColor = {
    "0": Colors.green,
    "1": Colors.yellow[700],
    "2": Colors.red
  };

  @override
  void initState() {
    qtyController.text = widget.qty.toString();
    initQtyController.text = widget.initialQty.toString();
    nameTextController.text = widget.name;

    channel = WebSocketChannel.connect(
      Uri.parse("ws://10.196.27.87:8000/ws/devices/${widget.id}/"),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var regexp = r'^[0-9]*\.[0-9]{2}';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = jsonDecode(snapshot.data!.toString());
                var device = data["device"];
                print(device);
                print(formatTime(device["endTime"]));
                double life = formatTime(device['endTime'])
                        .difference(DateTime.now())
                        .inMinutes
                        .toDouble() /
                    (device['initTimerMins']);
                int timeDiff =  (formatTime(device['endTime'])
                        .difference(DateTime.now())
                        .inHours/24.0).round();
                print(life);
                life = life < 0 ? 0 : life;
                var qtyval = ((device['qty'] - device['qty_used']) *
                    100 /
                    device['qty']);

                return Container(
                  padding: EdgeInsets.all(15),
                  // padding: EdgeInsets.fromLTRB(
                  //     10, MediaQuery.of(context).size.height * 0.04, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Hero(
                              tag: "${widget.id}_NAME",
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  device['type'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Dialog errorDialog = Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20)), //this right here
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromARGB(
                                                  255, 102, 181, 196),
                                              Color.fromARGB(255, 39, 91, 105),
                                            ]),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      child: SingleChildScrollView(
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(top: 15),
                                              child: Text(
                                                "Edit Device",
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              margin: EdgeInsets.only(
                                                  top: 10, left: 15, right: 15),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Color(0xFFa2c7cd),
                                              ),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Name",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFF425053),
                                                        fontSize: 16),
                                                    // contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                    isDense: true),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF425053),
                                                ),
                                                textAlign: TextAlign.start,
                                                textAlignVertical:
                                                    TextAlignVertical.center,
                                                controller: nameTextController,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {
                                                      if (nameTextController
                                                          .text.isNotEmpty) {
                                                        var res = updateName(
                                                            device['id'],
                                                            nameTextController
                                                                .text);
                                                        print(res);
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        errorDialog);
                              },
                              icon: Icon(Icons.edit_outlined)),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 18),
                        child: Row(
                          children: [
                            Hero(tag: "${widget.id}_IMAGE", child: widget.image)
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                        ),
                        alignment: Alignment.center,
                        // padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        height: MediaQuery.of(context).size.width * 0.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Dialog errorDialog = Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20)), //this right here
                                child: StatefulBuilder(
                                    builder: (context, setState) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromARGB(255, 102, 181, 196),
                                            Color.fromARGB(255, 39, 91, 105),
                                          ]),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 15),
                                            child: Text(
                                              "Edit Quantity",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            height: 15,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 150,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 15,
                                                    right: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Color(0xFFa2c7cd),
                                                ),
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter
                                                  //       .allow(
                                                  //       RegExp(regexp)),
                                                  // ],
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      label: Text(
                                                          "Remaining Quantity"),
                                                      hintText: "Quantity",
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Color(0xFF425053),
                                                          fontSize: 16),
                                                      // contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                      isDense: true),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF425053),
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  controller: qtyController,
                                                ),
                                              ),
                                              Container(
                                                child:
                                                    DropdownButtonHideUnderline(
                                                  child: DropdownButton2(
                                                    buttonDecoration:
                                                        BoxDecoration(
                                                            color: Colors
                                                                .transparent),
                                                    hint: Text(
                                                      'Select Item',
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    items: ["KGS", "UNITS"]
                                                        .map((item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                              value: item,
                                                              child: Text(
                                                                item,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    value: _chosenValue,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _chosenValue =
                                                            value as String;
                                                      });
                                                    },
                                                    dropdownWidth: 80,
                                                    dropdownDecoration:
                                                        BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      gradient: LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                            Color.fromARGB(255,
                                                                70, 137, 149),
                                                            Color.fromARGB(255,
                                                                39, 91, 105)
                                                          ]),
                                                    ),
                                                    customButton: Row(
                                                      children: [
                                                        Text(
                                                          "$_chosenValue",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Icon(
                                                          Icons.expand_more,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 150,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 15,
                                                    right: 15),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Color(0xFFa2c7cd),
                                                ),
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  // inputFormatters: [
                                                  //   FilteringTextInputFormatter
                                                  //       .allow(
                                                  //           RegExp(regexp)),
                                                  // ],
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      label: Text(
                                                          "Total Quantity"),
                                                      hintText:
                                                          "Initial Quantity",
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Color(0xFF425053),
                                                          fontSize: 16),
                                                      // contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                      isDense: true),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF425053),
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  textAlignVertical:
                                                      TextAlignVertical.center,
                                                  controller: initQtyController,
                                                ),
                                              ),
                                              Container(
                                                width: 64,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  onPressed: () {
                                                    var res = updateQty(
                                                        device['id'],
                                                        double.parse(
                                                            initQtyController
                                                                .text),
                                                        double.parse(
                                                                initQtyController
                                                                    .text) -
                                                            double.parse(
                                                                qtyController
                                                                    .text),
                                                        qty_units);
                                                    print(res);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      errorDialog);
                            },
                            child: CircularPercentIndicator(
                              radius: 70.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: ((device['qty'] - device['qty_used']) /
                                  device['qty']),
                              center: Text(
                                "${((device['qty'] - device['qty_used']) * 100 / device['qty']).toStringAsFixed(2)}%",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              footer: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "QUANTITY",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: Colors.blue,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Dialog errorDialog = Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20)), //this right here
                                child: StatefulBuilder(
                                    builder: (context, setState) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color.fromARGB(255, 102, 181, 196),
                                            Color.fromARGB(255, 39, 91, 105),
                                          ]),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height *
                                        0.475,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(top: 15),
                                            child: Text(
                                              "Edit Time",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            height: 15,
                                          ),
                                          Text(
                                            "TIME",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "DAYS",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          HorizontalPicker(
                                            height: 80,
                                            initialPosition:
                                                InitialPosition.center,
                                            minValue: 0,
                                            maxValue: 30,
                                            divisions: 30,
                                            showCursor: false,
                                            backgroundColor: Colors.transparent,
                                            activeItemTextColor: Colors.white,
                                            passiveItemsTextColor:
                                                Color.fromARGB(
                                                    255, 167, 167, 167),
                                            onChanged: (value) {
                                              daysValue = value.round();
                                            },
                                          ),
                                          Text(
                                            "HOURS",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          HorizontalPicker(
                                            height: 80,
                                            initialPosition:
                                                InitialPosition.start,
                                            minValue: 0,
                                            maxValue: 24,
                                            divisions: 24,
                                            showCursor: false,
                                            backgroundColor: Colors.transparent,
                                            activeItemTextColor: Colors.white,
                                            passiveItemsTextColor:
                                                Color.fromARGB(
                                                    255, 167, 167, 167),
                                            onChanged: (value) {
                                              hrsValue = value.round();
                                            },
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  onPressed: () {
                                                    var res = updateTime(
                                                        device['id'],
                                                        daysValue,
                                                        hrsValue,
                                                        0);
                                                    print(res);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      errorDialog);
                            },
                            child: CircularPercentIndicator(
                              radius: 70.0,
                              lineWidth: 13.0,
                              animation: true,
                              percent: life,
                              center: Text(
                                "${timeDiff} D",
                                // "Hiiii",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              footer: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "SHELF LIFE",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              circularStrokeCap: CircularStrokeCap.round,
                              progressColor: ringColor[device['food_status'].toString()],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "TEMP.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                              ),
                              Center(
                                  child: Text(
                                device['temp']?.toStringAsFixed(0) ?? "0",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w500),
                              )),
                              Text(
                                "CELCIUS",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 8),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "HUMIDITY",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                              ),
                              Center(
                                  child: Text(
                                device['humidity']?.toStringAsFixed(1) ?? "0.0",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w500),
                              )),
                              Text(
                                "%",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 8),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "DEVICE BATTERY STATUS",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 10),
                              ),
                              Container(
                                child: BatteryIndicator(
                                  batteryFromPhone: false,
                                  batteryLevel: device['battery']?.round() ?? 0,
                                  style: BatteryIndicatorStyle.values[0],
                                  colorful: true,
                                  showPercentNum: true,
                                  mainColor: primaryColor,
                                  size: 55,
                                  ratio: 3.0,
                                  showPercentSlide: true,
                                  percentNumSize: 35,
                                ),
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: RawMaterialButton(
                              fillColor: Colors.red,
                              onPressed: () {
                                print("${widget.name} reported stale");
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  child: Text("Report Stale",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RawMaterialButton(
                              fillColor: Colors.red,
                              onPressed: () {
                                Dialog errorDialog = Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          20)), //this right here
                                  child: StatefulBuilder(
                                      builder: (context, setState) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromARGB(
                                                  255, 102, 181, 196),
                                              Color.fromARGB(255, 39, 91, 105),
                                            ]),
                                      ),
                                      padding: EdgeInsets.all(10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            // margin: EdgeInsets.only(top: 15),
                                            child: Text(
                                              "Are you sure?",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            // margin: EdgeInsets.only(top: 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  onPressed: () {
                                                    var res = deleteDevice(
                                                        device['id']);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        errorDialog);
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                  child: Text("Unregister",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16))),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}

class Battery extends StatefulWidget {
  var _styleIndex = 1;

  var _colorful = true;

  var _showPercentSlide = true;
  var _showPercentNum = true;

  var _size = 90.0;

  var _ratio = 3.0;
  int batteryLevel = 100;

  Color _color = primaryColor;

  Battery({Key? key, required this.batteryLevel}) : super(key: key);

  @override
  State<Battery> createState() => _BatteryState();
}

class _BatteryState extends State<Battery> {
  @override
  Widget build(BuildContext context) {
    return BatteryIndicator(
      batteryFromPhone: false,
      batteryLevel: widget.batteryLevel,
      style: BatteryIndicatorStyle.values[widget._styleIndex],
      colorful: widget._colorful,
      showPercentNum: widget._showPercentNum,
      mainColor: widget._color,
      size: widget._size,
      ratio: widget._ratio,
      showPercentSlide: widget._showPercentSlide,
    );
  }
}

DateTime formatTime(String time) {
  DateTime endTime = DateTime(
      int.parse(time.substring(0, 4)),
      int.parse(time.substring(5, 7)),
      int.parse(time.substring(8, 10)),
      int.parse(time.substring(11, 13)),
      int.parse(time.substring(14, 16)));
  return endTime;
}
