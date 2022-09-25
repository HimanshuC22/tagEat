Map<String,String> imagesMap = {
  'cucumber':"assets/images/cucumber.png",
  'cucumbers':"assets/images/cucumber.png",
  'onion':"assets/images/onion.png",
  'onions':"assets/images/onion.png",
  'potato':"assets/images/potatoes.png",
  'potatoes':"assets/images/potatoes.png",
  'tomato':"assets/images/tomatoes.png",
  'tomatoes':"assets/images/tomatoes.png",
};

class DeviceData{
  String name = "Potatoes" ;
  int initQty = 10;
  int qty = 6;
  String qtyUnit = "Kgs";
  int initTime = 40 ;
  int time = 7;
  String timeUnit = "days";
  int battery = 46;
  String imageLink = "assets/images/def_fruits.png";
  String id = 'dev1';

  DeviceData({
    required this.name,
    required this.initQty,
    required this.qty,
    required this.qtyUnit,
    required this.initTime,
    required this.time,
    required this.timeUnit,
    required this.battery,
    required this.id,
  }): imageLink = imagesMap[name.toLowerCase()]??"assets/images/def_fruits.png";
}

//     "name": "Potatoes",
//     "initQty": 40,
//     "qty": 32,
//     "qtyUnit": "kgs",
//     "initTime": 40,
//     "time": 35,
//     "timeUnit": "days",
//     "battery": 46,
//     "imageLink": "assets/images/potatoes.png"