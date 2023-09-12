import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ksl_reserve_room/RoomPage.dart';
import 'package:ksl_reserve_room/SignInPage.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return Display();
  }
}

class MultiKeyMap {
  final Map<String, Map<String, String>> _data = {};

  List<String> getRoomKeys(){
    return _data.keys.toList();
  }

  void addValue(String key1, String key2, String value) {
    _data[key1] ??= {};
    _data[key1]?[key2] = value;
  }

  List<String>? getTimeKey(){
    return _data[_data.keys.toList()[0]]?.keys.toList();
  }

  String? getValue(String key1, String key2) {
    if (_data.containsKey(key1)) {
      return _data[key1]?[key2];
    }
    return null;
  }
}

MultiKeyMap dic = MultiKeyMap();

Future<MultiKeyMap> getData() async {
  var data =  await http.get(
      Uri.parse("http://127.0.0.1:5002/getData")
  );
  String inputString = data.body;
  MultiKeyMap map = MultiKeyMap();
  List<List<String>> dataList = parseInputString(inputString);
  for (List<String> data in dataList) {
    print(data);
    if (data.length == 3) {
      map.addValue(data[0], data[1], data[2]);
    }
  }
  // Test retrieving values
  return map;
}

List<List<String>> parseInputString(String input) {
  List<List<String>> dataList = [];

  // Match content between double quotes
  RegExp regExp = RegExp(r'"([^"]*)"');

  Iterable<Match> matches = regExp.allMatches(input);

  List<String> values = [];

  for (Match match in matches) {
    values.add(match.group(1)!);
    if (values.length == 3) {
      dataList.add(values);
      values = [];
    }
  }

  return dataList;
}

late Future<MultiKeyMap>? map;

class Display extends State<HomePage>{

  @override
  void initState()  {
    super.initState();
  }

  Future<void> initMap() async {
    map = getData();
    map!.then((value) => print(value._data.keys));
  }

  @override
  Widget build(BuildContext context) {
    initMap();
    return getScaffold();
  }

  Widget getSignIn(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Sign In by clinking",
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Lato",
          fontSize: 20
        ),),
        TextButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage())
          );
        }, child: const Text("here",
        style: TextStyle(
          fontFamily: "Lato",
            fontSize: 20
        ),))
      ],
    );
  }

  Widget getScaffold() {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/Display.jpeg"), fit: BoxFit.cover),
        ),
        child: Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            "Kelvin Smith Library",
            style: TextStyle(
                color:  Colors.white,  //Color(0xFF0e42a1),
              fontFamily: "Lato",
              fontSize: 40
            ),
          ),
          Column(
            children: [
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RoomPage())
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF08016e)
                  ),
                  child: const Text(
                    "Book A Room",
                  ),
                ),
              ),
              // getSignIn()
            ],
          ),
        ],
      ),
    ),
      ),
    );
  }

}