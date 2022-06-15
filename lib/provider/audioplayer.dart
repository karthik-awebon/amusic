import 'package:flutter/material.dart';

class AudioPlayer with ChangeNotifier {
  bool _isPlaying = false;

  bool get isPlaying {
    return _isPlaying;
  }

  void setIsPlaying(bool isPlaying, bool isNotifyListeners) {
    _isPlaying = isPlaying;
    if (isNotifyListeners) {
      notifyListeners();
    }
  }
}
