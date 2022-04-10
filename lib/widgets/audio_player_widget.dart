import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'play_pause_button.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  final bool isAsset;
  const AudioPlayerWidget({
    Key? key,
    required this.url,
    this.isAsset = false,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _audioPlayer;
  late AudioCache _audioCache;

  PlayerState _playerState = PlayerState.STOPPED;

  bool get _isPlaying => _playerState == PlayerState.PLAYING;
  bool get _isLocal => !widget.url.contains('https');
  int maxduration = 100;
  int currentpos = 0;
  String currentpostlabel = "00:00";

  @override
  void initState() {
    _audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    _audioCache = AudioCache(fixedPlayer: _audioPlayer);
    _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.STOPPED;
      });
    });
    Future.delayed(Duration.zero, () async {
      // ByteData bytes =
      //     await rootBundle.load(audioasset); //load audio from assets
      // audiobytes =
      //     bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      // //convert ByteData to Uint8List

      _audioPlayer.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration = d.inMilliseconds;
        setState(() {});
      });

      _audioPlayer.onAudioPositionChanged.listen((Duration p) {
        currentpos =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos).inHours;
        int sminutes = Duration(milliseconds: currentpos).inMinutes;
        int sseconds = Duration(milliseconds: currentpos).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel = "$rhours:$rminutes:$rseconds";

        setState(() {
          //refresh the UI
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: Slider(
          value: double.parse(currentpos.toString()),
          min: 0,
          max: double.parse(maxduration.toString()),
          divisions: maxduration,
          label: currentpostlabel,
          onChanged: (double value) async {
            int seekval = value.round();
            int result =
                await _audioPlayer.seek(Duration(milliseconds: seekval));
            if (result == 1) {
              //seek successful
              currentpos = seekval;
            } else {
              print("Seek unsuccessful.");
            }
          },
        )),
        PlayPauseButton(isPlaying: _isPlaying, onPlay: () => _playPause()),
        IconButton(
          onPressed: () => _stop(),
          icon: Icon(
            Icons.stop,
            size: 32,
            color: Colors.red,
          ),
        ),
      ],
    );
  }

  _playPause() async {
    if (_playerState == PlayerState.PLAYING) {
      final playerResult = await _audioPlayer.pause();
      if (playerResult == 1) {
        setState(() {
          _playerState = PlayerState.PAUSED;
        });
      }
    } else if (_playerState == PlayerState.PAUSED) {
      final playerResult = await _audioPlayer.resume();
      if (playerResult == 1) {
        setState(() {
          _playerState = PlayerState.PLAYING;
        });
      }
    } else {
      if (widget.isAsset) {
        _audioPlayer = await _audioCache.play(widget.url);
        setState(() {
          _playerState = PlayerState.PLAYING;
        });
      } else {
        final playerResult =
            await _audioPlayer.play(widget.url, isLocal: _isLocal);
        if (playerResult == 1) {
          setState(() {
            _playerState = PlayerState.PLAYING;
          });
        }
      }
    }
  }

  _stop() async {
    final playerResult = await _audioPlayer.stop();
    if (playerResult == 1) {
      setState(() {
        _playerState = PlayerState.STOPPED;
      });
    }
  }
}
