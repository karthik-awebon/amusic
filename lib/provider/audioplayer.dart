import 'package:flutter/material.dart';

class AudioPlayer with ChangeNotifier {
  bool _isPlaying = false;

  bool get isPlaying {
    return _isPlaying;
  }

  void setIsPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
    notifyListeners();
  }
}
