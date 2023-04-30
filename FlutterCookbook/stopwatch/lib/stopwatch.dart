import 'dart:async';

import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  bool isTicking = false;
  int seconds = 0;
  late Timer timer;

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$seconds ${_secondsTex()}',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () => _startTimer(),
                child: const Text('Start'),
              ),
              const SizedBox(
                width: 20,
              ),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () => _stopTimer(),
                  child: const Text('Stop'))
            ],
          )
        ],
      ),
    );
  }

  void _startTimer() {
    if (isTicking) return;

    timer = Timer.periodic(const Duration(seconds: 1), _onTick);

    setState(() {
      seconds = 0;
      isTicking = true;
    });
  }

  void _stopTimer() {
    if (!isTicking) return;

    timer.cancel();

    setState(() {
      isTicking = false;
    });
  }

  String _secondsTex() => seconds == 1 ? 'second' : 'seconds';

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
