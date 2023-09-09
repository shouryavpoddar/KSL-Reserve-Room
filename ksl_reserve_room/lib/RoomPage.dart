import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ksl_reserve_room/BookingPage.dart';
import 'package:ksl_reserve_room/HomePage.dart';

class RoomPage extends StatefulWidget{
  const RoomPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return Display();
  }

}

class Display extends State<RoomPage>{

 List<String> roomNames = ["Room 301- B","Room 301- C","Room 301- D", "Room 301- E","Room 301- F","Room LL- 02","Room LL- 03","Room LL- 04","Room LL- 05","Room M-01","Room M-02","Room M-03"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:(context, innerBoxIsScrolled) =>[
              SliverAppBar(
                backgroundColor: const Color(0xFF08016e),
                pinned: true,
                expandedHeight: 150,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    "Kelvin Smith Library",
                    style: TextStyle(
                      fontFamily: "impact",
                    ),
                  ),
                  background: Image.asset("assets/images/BookingPage.jpeg", fit: BoxFit.cover,),
                ),
              )
            ],
            body: getScaffold()
        )
    );
  }

  Widget getScaffold(){
    return Scaffold(
      body: ListView(
      children: List.generate(12,(index){
        String roomName = roomNames[index];
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BookingPage(roomName))
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                height: 100,
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 75,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/images/Button Image ${index +1}.jpg"), fit: BoxFit.cover,),
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                roomName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "impact",
                                  fontSize: 18
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                        color: Colors.white
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
      ),
      backgroundColor: Colors.blueGrey,
    );
  }



}