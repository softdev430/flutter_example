import 'package:flutter/material.dart';
import 'package:test_project/utils/localizations.dart';

class AboutPage extends StatefulWidget {
  static const String routeName = "/about";
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<AboutPage> with TickerProviderStateMixin {
  AnimationController _animationController;

  double _containerPaddingLeft = 20.0;
  double _animationValue;
  double _translateX = 0;
  double _translateY = 0;
  double _rotate = 0;
  double _scale = 1;

  bool show;
  bool sent = false;
  Color _color = Colors.lightBlue;

  List _fruits = ["Apple", "Banana", "Pineapple", "Mango", "Grapes"];

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedFruit;

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_fruits);
    _selectedFruit = _dropDownMenuItems[0].value;
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1300));
    show = true;
    _animationController.addListener(() {
      setState(() {
        show = false;
        _animationValue = _animationController.value;
        if (_animationValue >= 0.2 && _animationValue < 0.4) {
          _containerPaddingLeft = 100.0;
          _color = Colors.green;
        } else if (_animationValue >= 0.4 && _animationValue <= 0.5) {
          _translateX = 80.0;
          _rotate = -20.0;
          _scale = 0.1;
        } else if (_animationValue >= 0.5 && _animationValue <= 0.8) {
          _translateY = -20.0;
        } else if (_animationValue >= 0.81) {
          _containerPaddingLeft = 20.0;
          sent = true;
        }
      });
    });
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = List();
    for (String fruit in fruits) {
      items.add(DropdownMenuItem(value: fruit, child: Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedFruit = selectedFruit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("DropDown Button Example"),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/w_002.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(AppLocalizations.of(context).chooseFruit),
                DropdownButton(
                  value: _selectedFruit,
                  items: _dropDownMenuItems,
                  onChanged: changedDropDownItem,
                ),
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop('/about');
                    Navigator.of(context).pushNamed('/');
                  },
                  iconSize: 80.0,
                ),

                 GestureDetector(
               
                  onTap: () {
                    _animationController.forward();
                  },
                  child: AnimatedContainer(
                      decoration: BoxDecoration(
                        color: _color,
                        borderRadius: BorderRadius.circular(100.0),
                        boxShadow: [
                          BoxShadow(
                            color: _color,
                            blurRadius: 21,
                            spreadRadius: -15, 
                            offset: Offset(
                              0.0, 
                              20.0,
                            ),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(
                          left: _containerPaddingLeft,
                          right: 20.0,
                          top: 10.0,
                          bottom: 10.0),
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          (!sent)
                              ? AnimatedContainer(
                                  duration: Duration(milliseconds: 400),
                                  child: Icon(Icons.send),
                                  curve: Curves.fastOutSlowIn,
                                  transform: Matrix4.translationValues(
                                      _translateX, _translateY, 0)
                                    ..rotateZ(_rotate)
                                    ..scale(_scale),
                                )
                              : Container(),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 600),
                            child: show ? SizedBox(width: 10.0) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: show ? Text("Send") : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: sent ? Icon(Icons.done) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            alignment: Alignment.topLeft,
                            duration: Duration(milliseconds: 600),
                            child: sent ? SizedBox(width: 10.0) : Container(),
                          ),
                          AnimatedSize(
                            vsync: this,
                            duration: Duration(milliseconds: 200),
                            child: sent ? Text("Done") : Container(),
                          ),
                        ],
                      )))


              ],
            ),

          ),
        ),
      ),
    );
  }
}
