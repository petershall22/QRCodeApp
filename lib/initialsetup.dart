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
  final page1Visible = true;
  final page2Visible = false;
  final page3Visible = false;

  void dipose() {
    controller.dispose();
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
  }

  String currentPagePresentable() {
    return ((_currentStage + 1).ceil()).toString();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: [
          Visibility(
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
                  bottom: 170,
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
