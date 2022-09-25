import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tagEat/constants.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../API.dart';

String? _chosenValue = 'KGS';
bool flash = false;

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => QRScannerState();
}

class QRScannerState extends State<QRScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final nameTextController = TextEditingController();
  final qtyController = TextEditingController();
  int daysValue = 0;
  int hrsValue = 0;
  String qty_units = "KGS";
  Barcode? result;
  QRViewController? controller;

  get primaryColor => null;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                      borderColor: Colors.red,
                      borderRadius: 15,
                      borderWidth: 16,
                      borderLength: 40,
                      cutOutSize: 320),
                ),
              ),
              /* Expanded(
                flex: 1,
                child: Center(
                  child: (result != null)
                      ? Text('Data: ${result!.code}')
                      : Text('Scan a code'),
                ),
              ) */
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 55, left: 15, right: 15, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    Container(height: 15,),
                    ToggleSwitch(
                      minWidth: 160.0,
                      initialLabelIndex: 0,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: ['QR Code', 'Bill Scan'],
                      icons: [Icons.qr_code_2_outlined, Icons.receipt_outlined],
                      activeBgColors: [
                        [Colors.red],
                        [Colors.red]
                      ],
                      onToggle: (index) {
                        print('switched to: $index');
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            controller!.toggleFlash();
                          },
                          icon: Icon(
                            (!flash)
                                ? Icons.flashlight_on
                                : Icons.flashlight_off,
                            size: 30,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          controller.pauseCamera();
          controller.stopCamera();
          Dialog errorDialog = Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)), //this right here
            child: StatefulBuilder(builder: (context, setState) {
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
                height: MediaQuery.of(context).size.height * 0.65,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text(
                          "Add a Device",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color(0xFFa2c7cd),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  color: Color(0xFF425053), fontSize: 16),
                              // contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              isDense: true),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF425053),
                          ),
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          controller: nameTextController,
                        ),
                      ),
                      Container(
                        height: 15,
                      ),
                      Text(
                        "TIME",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("DAYS"),
                      HorizontalPicker(
                        height: 80,
                        initialPosition: InitialPosition.center,
                        minValue: 0,
                        maxValue: 30,
                        divisions: 30,
                        showCursor: false,
                        backgroundColor: Colors.transparent,
                        activeItemTextColor: Colors.white,
                        passiveItemsTextColor:
                            Color.fromARGB(255, 167, 167, 167),
                        onChanged: (value) {
                          daysValue = value.round();
                        },
                      ),
                      Text("HOURS"),
                      HorizontalPicker(
                        height: 80,
                        initialPosition: InitialPosition.start,
                        minValue: 0,
                        maxValue: 23,
                        divisions: 23,
                        showCursor: false,
                        backgroundColor: Colors.transparent,
                        activeItemTextColor: Colors.white,
                        passiveItemsTextColor:
                            Color.fromARGB(255, 167, 167, 167),
                        onChanged: (value) {
                          hrsValue = value.round();
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            margin:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFa2c7cd),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Quantity",
                                  hintStyle: TextStyle(
                                      color: Color(0xFF425053), fontSize: 16),
                                  // contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                  isDense: true),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF425053),
                              ),
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              controller: qtyController,
                            ),
                          ),
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                buttonDecoration:
                                    BoxDecoration(color: Colors.transparent),
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                items: ["KGS", "UNITS"]
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ))
                                    .toList(),
                                value: _chosenValue,
                                onChanged: (value) {
                                  setState(() {
                                    _chosenValue = value as String;
                                  });
                                },
                                dropdownWidth: 80,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 70, 137, 149),
                                        Color.fromARGB(255, 39, 91, 105)
                                      ]),
                                ),
                                customButton: Row(
                                  children: [
                                    Text(
                                      "$_chosenValue",
                                      style: TextStyle(color: Colors.white),
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
                      Container(
                        margin: EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () async {
                                // print("Random string");
                                // print(nameTextController.text);
                                // print('${result!.code!},${nameTextController.value.toString()},${daysValue}, $hrsValue, 0, ${int.parse(qtyController.value.toString())}, $qty_units');
                                updateDeviceData(
                                    result!.code!,
                                    nameTextController.text,
                                    daysValue,
                                    hrsValue,
                                    0,
                                    int.parse(qtyController.text),
                                    qty_units);
                                Navigator.pop(context);
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
              context: context, builder: (BuildContext context) => errorDialog);
        }
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

void updateDeviceData(String id, String type, int days, int hrs, int mins,
    int qty, String qty_units) async {
  var response_status =
      await updateDevice(id, type, days, hrs, mins, qty, qty_units);
  print(response_status);
}
