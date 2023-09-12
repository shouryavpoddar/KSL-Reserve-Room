import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Display();
  }

}

class _Display extends State<LoadingPage>{

  List<String> waitingJokes = [
    "Did you know Craigslist’s founder is a Case Western alumni? Craig Newmark graduated with a bachelor of science degree in 1975.",
    "Edward Morley determined the atomic weight of oxygen in a laboratory at Case Western Reserve University",
    "The infamous 2020 Presidential debate between then President Donald J.Trump and then Senator Joe R.Biden was held at the Severance Hall.",
    "Case Western’s Adelbert Gymnasium was built between 1918 and 1919. It was originally built to be used as an armory for WWI, but the war ended before it was even finished",
    "The Hudson Relay is a celebrated university event. Starting in 1910, the Hudson Relay has been run every year with a few exceptions. Teams are divided up into graduating classes, and team sizes can vary from 24 to 52.",
    "CWRU's last Nobel laureate was Richard Thaler in 2017 for his work in Behavorial ECON",
    "Can you imagine what your life would be like without Gmail? Thank Paul Buccheit, the creator and lead developer of Gmail, who is also a CWRU alumni! (Bonus fun fact: He rowed crew at college!)"
  ];

  @override
  Widget build(BuildContext context) {
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
    );
  }

}