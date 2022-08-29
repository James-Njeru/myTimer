import 'package:flutter/material.dart';

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;

  //final double size;
  final VoidCallback onPressed;

  const ProductivityButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: onPressed,
      color: color,
      //minWidth: this.size,
    );
  }
}

//pointer to a function
typedef CallbackSetting = void Function(String, int);

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  //final double size;
  final int value;
  final String setting;
  final CallbackSetting callback;

  const SettingButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.value,
      required this.setting,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () => callback(setting, value),
      color: color,
      //minWidth: size,
    );
  }
}
