import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // scroll controller
  late ScrollController _scrollController;

  @override
  void initState() {
    // initiallizing the scroll controller
    _scrollController = ScrollController()
      ..addListener(() {
        _onScoll();
      });
    super.initState();
  }

  double _scrollOffset = 0.0;

  void _onScoll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      print(_scrollOffset);
    });
  }

  // layer speeds

  double layer1Speed = 0.3; // layer-1 will be last , behind all layers
  double layer2Speed = 0.4;
  double layer3Speed = 0.5;
  double layer4Speed = 0.5;

  double sunSpeed = 0.18;
  double containerSpeed = 0.5;
  double textSpeed = -1;

  // layer Horizontal values -/ used to increase height/size of the Layers, while scrolling
  double layer1HSpeed = 0.1; // slow
  double layer2HSpeed = 0.08;
  double layer3HSpeed = 0.075;
  double layer4HSpeed = 0.07; // fast - top layers will have more resizing speed

  //can show lottie birds
  bool iconColor() {
    if (_scrollOffset > 600) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // some screen-size values
    var screenSize = MediaQuery.of(context).size;
    var layoutHeight = screenSize.height * 2;

    return Scaffold(
      body: Container(
        // container used for giving a gradient sky background
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.yellow.shade200,
              Colors.deepPurple.shade200,
              Colors.blueGrey.withOpacity(0.7),
            ])),
        child: Stack(children: [
          /*  image Layers  /  bottomLast  to TopFirst */
          // sun
          Positioned(
              bottom: screenSize.height * 0.7 + _scrollOffset * sunSpeed,
              left: _scrollOffset * layer1HSpeed * -1,
              right: 150 + _scrollOffset * layer1HSpeed * -1,
              child: Image.asset("assets/images/sun.png")),
          // layer 1
          Positioned(
              bottom: screenSize.height * 0.5 + _scrollOffset * layer1Speed,
              left: _scrollOffset * layer1HSpeed * -1,
              right: _scrollOffset * layer1HSpeed * -1,
              child: Image.asset(
                "assets/images/mount2.png",
              )),
          Positioned(
              bottom: screenSize.height * 0.5 + _scrollOffset * layer2Speed,
              left: _scrollOffset * layer2HSpeed * -1,
              right: _scrollOffset * layer2HSpeed * -1,
              child: Image.asset("assets/images/backgnd1.png")),
          // Text Layer
          Positioned(
              bottom: screenSize.height * 0.54 + _scrollOffset * textSpeed,
              left: 0,
              right: 0,
              child: _buildTextSection()),
          //*/ some flying birds
          Positioned(
              bottom: screenSize.height * 0.7 + _scrollOffset * layer2Speed,
              left: 0,
              right: 0,
              child: Lottie.asset("assets/json/birds.json")),
          // */
          Positioned(
              bottom: screenSize.height * 0.5 + _scrollOffset * layer3Speed,
              left: _scrollOffset * layer3HSpeed * -1,
              right: _scrollOffset * layer3HSpeed * -1,
              child: Image.asset("assets/images/backgnd2.png")),

          Positioned(
              bottom: screenSize.height * 0.5 + _scrollOffset * layer4Speed,
              left: _scrollOffset * layer4HSpeed * -1,
              right: _scrollOffset * layer4HSpeed * -1,
              height: screenSize.height * 0.15,
              child: Image.asset("assets/images/couples.png")),

          /*
              A Black Container at Last
          */
          Positioned(
              bottom: -screenSize.height * 0.5 +
                  (_scrollOffset * containerSpeed) +
                  3,
              left: 0,
              right: 0,
              height: screenSize.height,
              child: Container(
                color: Colors.deepPurple,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: screenSize.width / 2, left: screenSize.width / 2.5),
                  child: const Text("Parallax Effect"),
                ),
              )),

          // some navigation buttons
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: _buildNavigationBar(),
          ),

          // this below Widget with( Positioned.fill) helps to make the screen scrollable ,
          // and also the height : represents the whole layoutHeight of the page .
          Positioned.fill(
              child: SingleChildScrollView(
            controller: _scrollController,
            child: SizedBox(
              height: layoutHeight,
            ),
          )),
        ]),
      ),
    );
  }

  // NAME
  Text _buildTextSection() {
    return const Text(
        "MINATO", // I need to use GoogleFonts & TextStroke Paackages //
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 55,
        ));
  }

// nav bar
  Padding _buildNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.menu_sharp,
            color: iconColor() ? Colors.black : Colors.white,
          ),
        ],
      ),
    );
  }
}
