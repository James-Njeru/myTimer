import 'package:flutter/material.dart';
import './widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Settings(),
    );
  }
}

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = const TextStyle(fontSize: 24);
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;

  static const String WORKTIME = 'workTime';
  static const String SHORTBREAK = 'shortBreak';
  static const String LONGBREAK = 'longBreak';

  /*late int workTime;
  late int shortBreak;
  late int longBreak;*/
  late SharedPreferences preferences;

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text(
            'Work',
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
           SettingButton(
              color: Color(0xff455A64),
              text: '-',
              value: -1,
              setting: WORKTIME,
              callback: updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
           SettingButton(
              color: Color(0xff009688),
              text: '+',
              value: 1,
              setting: WORKTIME,
              callback: updateSetting),
          Text(
            'Short',
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
           SettingButton(
              color: Color(0xff455A64),
              text: '-',
              value: -1,
              setting: SHORTBREAK,
              callback: updateSetting),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
           SettingButton(
              color: Color(0xff009688),
              text: '+',
              value: 1,
              setting: SHORTBREAK,
              callback: updateSetting),
          Text(
            'Long',
            style: textStyle,
          ),
          const Text(''),
          const Text(''),
           SettingButton(
            color: Color(0xff455A64),
            text: '-',
            value: -1,
            setting: LONGBREAK,
            callback: updateSetting,
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
          ),
           SettingButton(
              color: Color(0xff009688),
              text: '+',
              value: 1,
              setting: LONGBREAK,
              callback: updateSetting),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }

  //read from shared pref
  readSettings() async {
    preferences = await SharedPreferences.getInstance();
    int? workTime = preferences.getInt(WORKTIME);
    if (workTime == null) {
      await preferences.setInt(WORKTIME, int.parse('30'));
    }
    int? shortBreak = preferences.getInt(SHORTBREAK);
    if (shortBreak == null) {
      await preferences.setInt(SHORTBREAK, int.parse('5'));
    }
    int? longBreak = preferences.getInt(LONGBREAK);
    if (longBreak == null) {
      await preferences.setInt(LONGBREAK, int.parse('20'));
    }

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  //write to shared pref
  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = preferences.getInt(WORKTIME);
          workTime = (workTime! + value);
          if (workTime >= 1 && workTime <= 180) {
            preferences.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = preferences.getInt(SHORTBREAK);
          short = short! + value;
          if (short >= 1 && short <= 120) {
            preferences.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = preferences.getInt(LONGBREAK);
          long = long! + value;
          if (long >= 1 && long <= 180) {
            preferences.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }
}
