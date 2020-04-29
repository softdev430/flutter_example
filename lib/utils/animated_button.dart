import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String initialText, finalText;
  final ButtonStyle buttonStyle;
  final IconData iconData;
  final double iconSize;
  final Duration animationDuration;

  AnimatedButton(
      {this.initialText,
      this.finalText,
      this.iconData,
      this.iconSize,
      this.animationDuration,
      this.buttonStyle});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  ButtonState _currentState;
  @override
  void initState() {
    super.initState();
    _currentState = ButtonState.SHOW_ONLY_TEXT;
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.buttonStyle.elevation,
      child: InkWell(
        onTap: () {
          setState(() {
            _currentState = ButtonState.SHOW_ONLY_ICON;
          });
        },
        child: Container(
            height: widget.iconSize + 16,
            decoration: BoxDecoration(
              color: (_currentState == ButtonState.SHOW_ONLY_ICON)
                  ? widget.buttonStyle.secondaryColor
                  : widget.buttonStyle.primaryColor,
              border: Border.all(
                  color: (_currentState == ButtonState.SHOW_ONLY_ICON)
                      ? widget.buttonStyle.secondaryColor
                      : Colors.transparent),
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.buttonStyle.borderRadius)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 8.0),
            color: widget.buttonStyle.primaryColor,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (_currentState == ButtonState.SHOW_ONLY_ICON)
                    ? Icon(
                        widget.iconData,
                        size: widget.iconSize,
                        color: widget.buttonStyle.primaryColor,
                      )
                    : Container(),
                (_currentState == ButtonState.SHOW_ONLY_TEXT)
                    ? Text(
                        widget.initialText,
                        style: widget.buttonStyle.initialTextStyle,
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }
}

class ButtonStyle {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation, borderRadius;

  ButtonStyle(
      {this.primaryColor,
      this.secondaryColor,
      this.initialTextStyle,
      this.finalTextStyle,
      this.elevation,
      this.borderRadius});
}

enum ButtonState { SHOW_ONLY_TEXT, SHOW_ONLY_ICON, SHOW_TEXT_ICON }
