// package imports
import 'package:flutter/material.dart';
import 'package:qrcodeapp/homescreen.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//..

class Setup extends StatefulWidget {
  // Text Field Controllers
  @override
  _SetupState createState() => _SetupState();
}

class _SetupState extends State<Setup> {
  // Variables
  final controller = TextEditingController();
  final controller1 = TextEditingController();
  var isChecked = false;
  var _page1Visible = true;
  var _page2Visible = false;
  var _page3Visible = false;
  var _previousVis = false;
  var _nextVis = true;
  var _submitVis = false;
  bool _validate = false;
  bool _validate1 = false;
  // ..

  void dipose() {
    controller.dispose();
    controller1.dispose();
    super.dispose();
  }

  // Page Controllers
  final _stages = 3;

  int _currentStage = 0;

  int _validPosition(int position) {
    if (position >= _stages) return 0;
    if (position < 0) return _stages - 1;
    return position;
  }

  void _updatePosition(int position) {
    setState(() => _currentStage = _validPosition(position));
    if (_currentStage == 0) {
      _page1Visible = true;
      _page2Visible = false;
      _page3Visible = false;
      _previousVis = false;
      _nextVis = true;
      _submitVis = false;
    }
    if (_currentStage == 1) {
      _page1Visible = false;
      _page2Visible = true;
      _page3Visible = false;
      _previousVis = true;
      _nextVis = true;
      _submitVis = false;
    } else if (_currentStage == 2) {
      _page1Visible = false;
      _page2Visible = false;
      _page3Visible = true;
      _previousVis = true;
      _nextVis = false;
      _submitVis = true;
    }
  }

  String currentPagePresentable() {
    return ((_currentStage + 1).ceil()).toString();
  }

  checkIfEmpty(object) {
    if (object.isEmpty) {
      print('empty');
      return 'Field cannot be empty!';
    } else {
      return null;
    }
  }

  // ..

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w200,
        fontSize: 18,
      ),
    );
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: [
          Visibility(
            // Page 1
            visible: _page1Visible,
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: 510,
                  child: Align(
                    child: Container(
                      width: 340,
                      child: Text(
                        'Unique ID Code Entry',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 380,
                  child: Align(
                    child: Container(
                      width: 340,
                      child: Text(
                        'Enter your unique identification code in the text field.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 70,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 330,
                      child: TextFormField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          errorText:
                              _validate ? 'Field cannot be empty!' : null,
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your ID code',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            // Page 2
            visible: _page2Visible,
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: 510,
                  child: Align(
                    child: Container(
                      width: 340,
                      child: Text(
                        'Enter a Friendly Name',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 350,
                  child: Align(
                    child: Container(
                      width: 340,
                      child: Text(
                        'Enter your friendly name in the text field given below. A friendly name is also known as a username or nickname.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 70,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 330,
                      child: TextFormField(
                        controller: controller1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          errorText:
                              _validate1 ? 'Field cannot be empty!' : null,
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your friendly name',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            // Page 3
            visible: _page3Visible,
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: 530,
                  child: Align(
                    child: Container(
                      width: 340,
                      child: Text(
                        'Finalising your Setup',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 240,
                  child: Align(
                    child: Container(
                      width: 340,
                      child: Text(
                        'Go back and make sure that everything has the correct information in it.\n If you are not connected to the internet, you will recieve an error as your phone needs to contact the server.\n\n It is recommended that you always stay connected to the internet when using this application to display correct information about doors — however, it is not neeeded.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 80,
                  child: Align(
                    child: Container(
                      width: 340,
                      child: Text(
                        'Press the checkbox below to affirm that you have read the above.',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 170,
                  child: Align(
                    child: Container(
                      width: 340,
                      child: Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 330,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: _previousVis,
                  child: Padding(
                    padding: EdgeInsets.all(35),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: buttonStyle,
                        child: Text('Previous'),
                        onPressed: () {
                          _currentStage = _currentStage.ceil();
                          _updatePosition(max(--_currentStage, 0));
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _nextVis,
                  child: Padding(
                    padding: EdgeInsets.all(35),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: buttonStyle,
                        child: Text('Next'),
                        onPressed: () {
                          if (_page2Visible) {
                            if (controller1.text.isNotEmpty) {
                              setState(() {
                                _validate1 = false;
                              });
                              _currentStage = _currentStage.ceil();
                              _updatePosition(min(
                                ++_currentStage,
                                _stages - 1,
                              ));
                            } else {
                              setState(() {
                                _validate1 = true;
                              });
                              print(_validate);
                            }
                          }
                          if (_page1Visible) {
                            if (controller.text.isNotEmpty) {
                              setState(() {
                                _validate = false;
                              });
                              _currentStage = _currentStage.ceil();
                              print('a');
                              _updatePosition(min(
                                ++_currentStage,
                                _stages - 1,
                              ));
                            } else {
                              setState(() {
                                _validate = true;
                              });
                              print(_validate);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _submitVis,
                  child: Padding(
                    padding: EdgeInsets.all(35),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: buttonStyle,
                        child: Text('Finish'),
                        onPressed: () async {
                          if (isChecked) {
                            print('Submit');
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('introductionScreenDone', false);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) =>
                                    HomeScreen(), // push to Setup widget after introductionScreen done button pressed
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(children: [
            Positioned.fill(
              top: 640,
              child: Align(
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentStage,
                  count: _stages,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    spacing: 10.0,
                    dotHeight: 11,
                    dotWidth: 11,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: 705,
              child: Align(
                child: Text(
                  currentPagePresentable() + ' of ' + _stages.toString(),
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ]),
        ]),
      ),
    );
  }
}
