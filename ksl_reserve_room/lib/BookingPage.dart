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

  List<bool> isSelected = List.generate(map.getTimeKey()!.length, (index){
    return false;
  });

  late List<Widget> children;

  late String roomName;

  _Display(String name){
    roomName = name;
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
    dropdownValue = "30 min";
  }

  @override
  Widget build(BuildContext context) {
    return getScaffold();
  }

  void changeButtonStatus(int index){
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

  Widget getScaffold() {
    return
      Scaffold(
      appBar: getAppBar(),
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
          padding: const EdgeInsets.only(bottom: 80),
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
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(10),
                    selectedColor: Colors.amber,
                    selectedBorderColor: Colors.blueGrey,
                    fillColor: Colors.blueGrey,
                    isSelected: isSelected,
                    color: Colors.white,
                    onPressed: (int index) {
                      setState(() {
                        changeButtonStatus(index);
                      });
                    },
                    borderColor: Colors.blueGrey,
                    direction: Axis.vertical,
                    constraints: const BoxConstraints(
                      minHeight: 90,
                      minWidth: 200
                    ),
                    children: children,
                  ),
                ),
              )
            ),
          ),
        ),
        SizedBox(width: 350 ,child: ElevatedButton(onPressed: (){print("Submited");}, child: Text("Submit"),))
        ],
      ),
      backgroundColor: Colors.blueGrey,
    );
  }

  AppBar getAppBar(){
    return AppBar(
      backgroundColor: const Color(0xFF08016e),
      actions: [getDropdown()],
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

  List<String> getdropDownOptions(){
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
  
  Widget getDropdown(){
    var list = getdropDownOptions();
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
              changeButtonStatus(isSelected.indexOf(true));
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
              changeButtonStatus(isSelected.indexOf(true));
            });
          },
        ),
      );
    }
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
