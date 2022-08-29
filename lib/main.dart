import 'package:flutter/material.dart';
import 'package:flutterapp/settings.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './widgets.dart';
import './timermodel.dart';
import './timer.dart';
//import './settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Work Timer',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  TimerHomePage({Key? key}) : super(key: key);
  final CountDownTimer timer = CountDownTimer();

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(const PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));

    timer.startWork();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Work Timer'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return menuItems.toList();
            },
            onSelected: (s){
              if(s == 'Settings'){
                goToSettings(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;
          return Center(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(5.0)),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                      child: ProductivityButton(
                        color: const Color(0xff009688),
                        text: 'Work',
                        onPressed: () => timer.startWork(),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                      child: ProductivityButton(
                        color: const Color(0xff607D8B),
                        text: 'Short Break',
                        onPressed: () => timer.startBreak(true),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                      child: ProductivityButton(
                        color: const Color(0xff455A64),
                        text: 'Long Break',
                        onPressed: () => timer.startBreak(false),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                  ],
                ),
                StreamBuilder(
                    initialData: '00:00',
                    stream: timer.stream(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      TimerModel timerModel = (snapshot.data == '00:00')
                          ? TimerModel('00:00', 1)
                          : snapshot.data;
                      return Expanded(
                        child: CircularPercentIndicator(
                          radius: availableWidth / 2,
                          lineWidth: 10,
                          percent: timerModel.percent,
                          center: Text(
                            timerModel.time,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          progressColor: const Color(0xff009688),
                        ),
                      );
                    }),
                const Padding(padding: EdgeInsets.all(5.0)),
                Row(
                  children: [
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                      child: ProductivityButton(
                        color: const Color(0xff212121),
                        text: 'Stop',
                        onPressed: () => timer.stopTimer(),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                      child: ProductivityButton(
                        color: const Color(0xff009688),
                        text: 'Restart',
                        onPressed: () => timer.startTimer(),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(5.0)),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void goToSettings(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }
}
