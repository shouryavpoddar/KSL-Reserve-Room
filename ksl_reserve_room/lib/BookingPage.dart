import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ksl_reserve_room/HomePage.dart';

class BookingPage extends StatefulWidget{

  late String roomName;

  BookingPage(this.roomName, {super.key}){
    createState();
  }

  @override
  State<StatefulWidget> createState() {
    return _Display(roomName);
  }

}

String? dropdownValue;

class _Display extends State<BookingPage>{

  List<String> dropDownOptions= <String>['30 min', '1 hour', '1.5 hours', '2 hours', "2.5 hours", "3 hours"];

  late List<bool> isSelected;

  late List<Widget> children;

  late String roomName;

  List<String> waitingJokes = [
    "Did you know Craigslist’s founder is a Case Western alumni? Craig Newmark graduated with a bachelor of science degree in 1975.",
    "Edward Morley determined the atomic weight of oxygen in a laboratory at Case Western Reserve University",
  "The infamous 2020 Presidential debate between then President Donald J.Trump and then Senator Joe R.Biden was held at the Severance Hall.",
  "Case Western’s Adelbert Gymnasium was built between 1918 and 1919. It was originally built to be used as an armory for WWI, but the war ended before it was even finished",
  "The Hudson Relay is a celebrated university event. Starting in 1910, the Hudson Relay has been run every year with a few exceptions. Teams are divided up into graduating classes, and team sizes can vary from 24 to 52.",
  "CWRU's last Nobel laureate was Richard Thaler in 2017 for his work in Behavorial ECON",
  "Can you imagine what your life would be like without Gmail? Thank Paul Buccheit, the creator and lead developer of Gmail, who is also a CWRU alumni! (Bonus fun fact: He rowed crew at college!)"
  ];

  _Display(String name){
    roomName = name;
    dropdownValue = "30 min";
  }

  void initChildern(MultiKeyMap map) {
    children = List.generate(map.getTimeKey()!.length, (index){
      return Container(
        height: 75,
        width: 300,
        color: (map.getValue(roomName, map.getTimeKey()![index])  != "Unavailable")? const Color(0xff0b37b0): Colors.red ,
        child: Center(
          child: Text(map.getTimeKey()![index], style: const TextStyle(
              fontFamily: "Lato",
              fontSize: 20
          ),
          ),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return getFutureScaffold();
  }

  void initTimeSlots(MultiKeyMap map) {
    initChildern(map);
    initIsSelected(map);
  }

  void initIsSelected(MultiKeyMap map){
    isSelected = List.generate(map.getTimeKey()!.length, (index){
      return false;
    });
  }

  Widget getTimeSlots(MultiKeyMap map){
    return ToggleButtons(
      borderRadius: BorderRadius.circular(10),
      selectedColor: Colors.amber,
      selectedBorderColor: Colors.blueGrey,
      fillColor: Colors.blueGrey,
      isSelected: isSelected,
      color: Colors.white,
      onPressed: (int index) {
        setState(() {
          changeButtonStatus(index, map);
        });
      },
      borderColor: Colors.blueGrey,
      direction: Axis.vertical,
      constraints: const BoxConstraints(
          minHeight: 90,
          minWidth: 200
      ),
      children: children,
    );
  }

  void changeButtonStatus(int index, MultiKeyMap map){
    for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
      if (buttonIndex >= index && buttonIndex <= index +dropdownValueIndex() && map.getValue(roomName, map.getTimeKey()![buttonIndex])  != "Unavailable") {
        isSelected[buttonIndex] = true;
        children[buttonIndex] = Container(
          height: 75,
          width: 300,
          color: Colors.amber,
          child: Center(
            child: Text(map.getTimeKey()![buttonIndex], style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 20,
                color: Colors.black
            ),
            ),
          ),
        );
      } else if(map.getValue(roomName, map.getTimeKey()![buttonIndex])  != "Unavailable") {
        isSelected[buttonIndex] = false;
        children[buttonIndex] = Container(
          height: 75,
          width: 300,
          color: const Color(0xff0b37b0),
          child: Center(
            child: Text(map.getTimeKey()![buttonIndex], style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 20
            ),
            ),
          ),
        );
      }
    }
  }

  Widget getScaffold(MultiKeyMap map) {
    return
      Scaffold(
      appBar: getAppBar(map),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
          "Time Slots",
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "Lato"
          ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Center(
            child: SizedBox(
              height: 500,
              width: 500,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: getTimeSlots(map),
                ),
              )
            ),
          ),
        ),
        SizedBox(width: 350, height: 60 ,child: ElevatedButton(onPressed: (){print("Submited");}, child: Text("Submit", style: TextStyle(fontFamily: "Lato"),), style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF08016e)),))
        ],
      ),
      backgroundColor: Colors.blueGrey,
    );
  }

  AppBar getAppBar(MultiKeyMap map){
    return AppBar(
      backgroundColor: const Color(0xFF08016e),
      actions: [getDropdown(map)],
      title: Text(roomName),
      titleTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: "impact",
          fontSize: 20,
      ),
    );
  }

  String intToWeekday(int i){
    int currentDay = DateTime.now().weekday;
    switch((i+currentDay)% 7){
      case 0:
        return "Sunday";
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      default:
        return "Saturday";
    }
  }

  List<String> getDropDownOptions(MultiKeyMap map){
    int count = 0;
    for(int index = isSelected.indexOf(true); (index> -1 && index < isSelected.length) && map.getValue(roomName,map.getTimeKey()![index])  != "Unavailable"; index++){
      count++;
    }
    if(count >= 6 || count == 0){
      return dropDownOptions;
    } else{
      return dropDownOptions.sublist(0,count);
    }
  }
  
  Widget getDropdown(MultiKeyMap map){
    var list = getDropDownOptions(map);
    if(list.contains(dropdownValue)){
      return Container(
        color: const Color(0xFF08016e),
        child: DropdownButton<String>(
          value: dropdownValue ??= "30 min",
          dropdownColor: const Color(0xff0b37b0),
          iconEnabledColor: Colors.white,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontFamily: "impact",
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              if(isSelected.contains(true)){
                changeButtonStatus((isSelected.indexOf(true)), map);
              }
            });
          },
        ),
      );
    } else{
      dropdownValue = list[list.length-1];
      return Container(
        color: const Color(0xFF08016e),
        child: DropdownButton<String>(
          value: dropdownValue ??= "30 min",
          dropdownColor: const Color(0xff0b37b0),
          iconEnabledColor: Colors.white,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontFamily: "impact",
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
              changeButtonStatus(isSelected.indexOf(true), map);
            });
          },
        ),
      );
    }
  }

  Widget getFutureScaffold(){
    return FutureBuilder<MultiKeyMap>(
      future: map,
      builder: (BuildContext context, AsyncSnapshot<MultiKeyMap> map) {
        if (map.connectionState == ConnectionState.waiting) {
          return Scaffold(
              body: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/Display.jpeg"), fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Dialog(
                      child: SizedBox(
                        height: 170,
                        width: 30,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircularProgressIndicator(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(waitingJokes[Random().nextInt(waitingJokes.length)], textAlign: TextAlign.center,),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              )
            ); // Show a loading indicator
        } else if (map.hasError) {
          return Text('Error: ${map.error}');
        } else {
          initTimeSlots(map.data!);
          return getScaffold(map.data!);
        }
      },
    );
  }

}

int dropdownValueIndex(){
  switch(dropdownValue){
    case '30 min':
      return 0;
    case '1 hour':
      return 1;
    case '1.5 hours':
      return 2;
    case '2 hours':
      return 3;
    case "2.5 hours":
      return 4;
    default:
      return 5;
  }
}
