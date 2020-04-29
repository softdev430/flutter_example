import 'package:flutter/material.dart';
import 'package:test_project/pages/about.dart';
import 'package:test_project/utils/animated_button.dart';
import 'package:test_project/utils/localizations.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
        backgroundColor: Colors.red,
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/w_004.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                AppLocalizations.of(context).hello,
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              IconButton(
                icon: Icon(Icons.info),
                // initialText: "confirm",
                // finalText: "submit",
                // iconData: Icons.info,
                // iconSize: 32.0,
                // buttonStyle: ButtonStyle(
                //   primaryColor: Colors.green.shade600,
                //   secondaryColor: Colors.white,
                //   elevation: 20.0,
                //   initialTextStyle: TextStyle(
                //     fontSize: 24.0,
                //     color: Colors.white,
                //   ),
                //   finalTextStyle: TextStyle(
                //     fontSize: 24.0,
                //     color: Colors.green.shade600,
                //   ),
                //   borderRadius: 10.0
                // ),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigator.of(context).pushNamed('/about');
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return AboutPage();
                        },
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return SlideTransition(
                            position: new Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: new SlideTransition(
                              position: new Tween<Offset>(
                                begin: Offset.zero,
                                end: const Offset(1.0, 0.0),
                              ).animate(secondaryAnimation),
                              child: child,
                            ),
                          );
                        },
                      ));
                },
                iconSize: 80.0,
              ),
            ],
          ))),
    );
  }
}
