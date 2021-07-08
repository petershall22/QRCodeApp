// package imports
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
// external class imports
import './initialsetup.dart';
// ..

void main() {
  runApp(
    App(),
  );
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool introductionScreen = false;

  @override
  void initState() {
    super.initState();
    checkFirstScreen();
  }

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool introductionScreenDone = (pref.getBool('introductionScreenDone') ??
        false); // if bool exists then true else false (null)
    if (introductionScreenDone) {
      setState(() {
        introductionScreen = true;
      });
    } else {
      setState(() {
        introductionScreen = false;
      });
    }
  }

  Widget build(BuildContext context) {
    print(introductionScreen);
    return MaterialApp(
      title: 'Introduction Screen',
      theme: ThemeData(fontFamily: 'NunitoSans'),
      home: !introductionScreen
          ? MainApp()
          : MainApp(), // if bool is true, home is HomeScreen else home is MainApp
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  void _onDonePressed(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('introductionScreenDone', false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            Setup(), // push to Setup widget after introductionScreen done button pressed
      ),
    );
  }

  late Image idCard;
  late Image internetIcon;
  late Image keys;
  late Image thumbsUp;

  @override
  void initState() {
    super.initState();
    idCard = Image.asset(
      "images/idcard.png",
      height: 125.0,
    );
    internetIcon = Image.asset(
      "images/interneticon.png",
      height: 175.0,
    );
    keys = Image.asset(
      "images/keys.png",
      height: 135.0,
    );
    thumbsUp = Image.asset(
      "images/thumbsup.png",
      height: 135.0,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(idCard.image, context);
    precacheImage(internetIcon.image, context);
    precacheImage(keys.image, context);
    precacheImage(thumbsUp.image, context);
  }

  // images precached

  @override
  Widget build(BuildContext context) {
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.w800, fontSize: 26, fontFamily: 'NunitoSans'),
      bodyTextStyle: TextStyle(
          fontWeight: FontWeight.w400, fontSize: 19, fontFamily: 'NunitoSans'),
    );
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Welcome',
          body:
              'Please ensure that you have your unique ID code with you given by an administrator.',
          image: Center(
            child: idCard,
            heightFactor: .9,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Internet Connection Needed',
          body:
              'An internet connection is needed for the initial setup to connect with the server.',
          image: Center(
            child: internetIcon,
            heightFactor: .7,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Permissions',
          body:
              'Your unique ID code will have set permissions to go with it. When you generate a QR Code, this ID is sent to the server. If your door does not open, please contact an administrator.',
          image: Center(
            child: keys,
            heightFactor: .85,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'We\'re all set!',
          body: 'Click done to proceed to your initial setup.',
          image: Center(
            child: thumbsUp,
            heightFactor: .85,
          ),
          decoration: pageDecoration,
        )
      ],
      showDoneButton: true,
      showNextButton: true,
      showSkipButton: true,
      next: const Icon(Icons.navigate_next),
      skip: const Text(
        'Skip',
        style: TextStyle(
          fontFamily: 'Monsterrat',
          fontWeight: FontWeight.w700,
        ),
      ),
      done: const Text(
        "Done",
        style: TextStyle(
          fontFamily: 'Monsterrat',
          fontWeight: FontWeight.w600,
        ),
      ),
      onDone: () => _onDonePressed(context),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      curve: Curves.easeInOutSine,
    );
  }
}
