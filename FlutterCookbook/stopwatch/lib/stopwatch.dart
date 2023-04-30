import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  late int seconds;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    seconds = 0;
    timer = Timer.periodic(Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer time) {
    setState(() {
      ++seconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
      ),
      body: Center(
        child: Text(
          '$seconds ${_secondsTex()}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  String _secondsTex() => seconds == 1 ? 'second' : 'seconds';

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
