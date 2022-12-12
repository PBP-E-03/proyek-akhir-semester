import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pbp_e_03_flutter/history/screens/history_screen.dart';
import 'package:pbp_e_03_flutter/home/screens/home_screen.dart';
import 'package:pbp_e_03_flutter/main.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarComponents extends StatelessWidget {
  const BottomNavigationBarComponents({super.key, required this.currentPage});

  final String currentPage;

  @override
  Widget build(BuildContext context) {
    var currentScreen = Provider.of<ScreenState>(context).getCurrentScreen;

    return Container(
      color: Colors.transparent.withOpacity(0),
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 80),
            painter: BottomNavigationBarComponentsPainter(),
          ),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
                elevation: 0.1,
                onPressed: () {
                  Navigator.of(context).pop();
                  if (currentPage != "Donation") {
                    Provider.of<ScreenState>(context, listen: false)
                        .setCurrentScreen(4);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const Counter7()));
                  }
                },
                child: const Icon(Icons.forest)),
          ),
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: currentScreen == 0
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  onPressed: () {
                    if (currentPage != "Home") {
                      Provider.of<ScreenState>(context, listen: false)
                          .setCurrentScreen(0);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  },
                  splashColor: Colors.white,
                ),
                IconButton(
                    icon: Icon(
                      Icons.leaderboard,
                      color: currentScreen == 1
                          ? Colors.green
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      if (currentPage != "Leaderboard") {
                        Provider.of<ScreenState>(context, listen: false)
                            .setCurrentScreen(0);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Counter7()));
                      }
                    }),
                Container(
                  width: MediaQuery.of(context).size.width * 0.20,
                ),
                IconButton(
                    icon: Icon(
                      Icons.store,
                      color: currentScreen == 2
                          ? Colors.green
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      if (currentPage != "Store") {
                        Provider.of<ScreenState>(context, listen: false)
                            .setCurrentScreen(0);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Counter7()));
                      }
                    }),
                IconButton(
                    icon: Icon(
                      Icons.history,
                      color: currentScreen == 3
                          ? Colors.green
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      if (currentPage != "History") {
                        Provider.of<ScreenState>(context, listen: false)
                            .setCurrentScreen(3);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HistoryScreen()));
                      }
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavigationBarComponentsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
