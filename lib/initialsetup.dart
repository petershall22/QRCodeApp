// package imports
import 'package:flutter/material.dart';
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
  final controller = TextEditingController();
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  var page1Visible = true;
  var page2Visible = false;
  var page3Visible = false;
  var previousVis = false;
  var nextVis = true;
  var submitVis = false;

  void dipose() {
    controller.dispose();
    controller1.dispose();
    controller2.dispose();
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
      page1Visible = true;
      page2Visible = false;
      page3Visible = false;
      previousVis = false;
      nextVis = true;
      submitVis = false;
    }
    if (_currentStage == 1) {
      page1Visible = false;
      page2Visible = true;
      page3Visible = false;
      previousVis = true;
      nextVis = true;
      submitVis = false;
    } else if (_currentStage == 2) {
      page1Visible = false;
      page2Visible = false;
      page3Visible = true;
      previousVis = true;
      nextVis = false;
      submitVis = true;
    }
  }

  String currentPagePresentable() {
    return ((_currentStage + 1).ceil()).toString();
  }

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
            visible: page1Visible,
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
                      child: TextField(
                        controller: controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
            visible: page2Visible,
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
                      child: TextField(
                        controller: controller1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
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
          Positioned.fill(
            top: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: previousVis,
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
                  visible: nextVis,
                  child: Padding(
                    padding: EdgeInsets.all(35),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: buttonStyle,
                        child: Text('Next'),
                        onPressed: () {
                          _currentStage = _currentStage.ceil();
                          _updatePosition(min(
                            ++_currentStage,
                            _stages - 1,
                          ));
                        },
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: submitVis,
                  child: Padding(
                    padding: EdgeInsets.all(35),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: buttonStyle,
                        child: Text('Submit'),
                        onPressed: () {
                          _currentStage = _currentStage.ceil();
                          _updatePosition(min(
                            ++_currentStage,
                            _stages - 1,
                          ));
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
