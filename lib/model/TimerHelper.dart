import 'dart:async';

class TimerHelper {
  int seconds;

  late Timer _timer;

  void Function()? onCount;

  TimerHelper({this.onCount}) : seconds = 0 {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds++;
      if (onCount != null)
        onCount!.call();
    });
  }

  void stop() {
    _timer.cancel();
  }

  String getPrettyTime() {
    int minutes = (seconds / 60).truncate();
    return minutes.toString().padLeft(2, '0') +
        ":" +
        (seconds - minutes * 60).toString().padLeft(2, '0');
  }
}
