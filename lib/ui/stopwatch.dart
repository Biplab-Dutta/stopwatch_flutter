import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch_flutter/ui/reset_button.dart';
import 'package:stopwatch_flutter/ui/start_stop_button.dart';
import 'package:stopwatch_flutter/ui/stopwatch_renderer.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({Key? key}) : super(key: key);

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch>
    with SingleTickerProviderStateMixin {
  Duration _previouslyElapsed = Duration.zero;
  Duration _currentlyElapsed = Duration.zero;
  Duration get _elapsed => _previouslyElapsed + _currentlyElapsed;
  late final Ticker _ticker;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(
      (elapsed) {
        setState(() => _currentlyElapsed = elapsed);
      },
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _togglRunning() {
    setState(
      () {
        _isRunning = !_isRunning;
        if (_isRunning) {
          _ticker.start();
        } else {
          _ticker.stop();
          _previouslyElapsed += _currentlyElapsed;
          _currentlyElapsed = Duration.zero;
        }
      },
    );
  }

  void _reset() {
    _ticker.stop();
    setState(
      () {
        _isRunning = false;
        _previouslyElapsed = _currentlyElapsed = Duration.zero;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Stack(
        children: [
          StopwatchRenderer(
            elapsed: _elapsed,
            radius: constraints.maxWidth / 2,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: 80,
              height: 80,
              child: ResetButton(
                onPressed: _reset,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 80,
              height: 80,
              child: StartStopButton(
                isRunning: _isRunning,
                onPressed: _togglRunning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
