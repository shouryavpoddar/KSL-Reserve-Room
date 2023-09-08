import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Display();
  }

}

class _Display extends State<SignInPage>{
  @override
  Widget build(BuildContext context) {
    return getScaffold();
  }

  final _formKey = GlobalKey<FormState>();
  String _name = '';

  Widget getScaffold(){
    return  Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/Display.jpeg"), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const DefaultTextStyle(
            child: Text(
              "Kelvin Smith Library",
            ),
            style: TextStyle(
                fontStyle: FontStyle.normal,
                fontFamily: "Lato",
                color:  Colors.white,  //Color(0xFF0e42a1),
                fontSize: 40
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 350,
                width: 300,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 240,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Enter your First name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Enter your Last name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: 250,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Enter your Case Id',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Case Id';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, do something with the data
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInPage())
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ],
      ),
    );
  }

}