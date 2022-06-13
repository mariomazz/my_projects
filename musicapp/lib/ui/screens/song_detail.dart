import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class SongDetail extends StatefulWidget {
  const SongDetail({Key? key, required this.songReference}) : super(key: key);
  final File songReference;

  @override
  State<SongDetail> createState() => _SongDetailState();
}

class _SongDetailState extends State<SongDetail> {
  // ignore: unused_field
  late String? _songUrl;

  final AudioPlayer _audioPlayer = AudioPlayer(
    mode: PlayerMode.LOW_LATENCY,
    playerId: UniqueKey().toString(),
  );

  int _progress = 0;
  int _duration = 0;
  //int _playerProgress = 0;
  PlayerState _playerState = PlayerState.STOPPED;

  @override
  void initState() {
    _audioPlayer.onPlayerStateChanged.listen((data) {
      setState(() {
        _playerState = data;
      });
    });

    _audioPlayer.onDurationChanged.listen((data) {
      setState(() {
        _duration = data.inMilliseconds;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((data) {
      setState(() {
        _progress = data.inMilliseconds;
      });
    });

    _audioPlayer.onPlayerCompletion.listen((event) async {
      setState(() {
        _progress = _duration;
      });
      await Future.delayed(const Duration(milliseconds: 100),
          () => Navigator.of(this.context).pop());
    });

    _audioPlayer.onPlayerError.listen((error) {
      setState(() {
        _duration = 0;
        _progress = 0;
      });
    });

    _fetchSongUrl();
    super.initState();
  }

  @override
  void dispose() {
    _songUrl = null;
    _audioPlayer.release();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  void setState(event) {
    if (mounted) {
      super.setState(event);
    }
  }

  void _fetchSongUrl() async =>
      await _getSongUrl().then((value) => setState(() => _songUrl = value));

  Future<String?> _getSongUrl() async {
    try {
      return await FirebaseStorage.instance
          .ref(widget.songReference.path)
          .getDownloadURL();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('errore loadSongs => ${e.message}');
      }
      return null;
    }
  }

  Future<void> _playerAction(PlayerState action) async {
    if (_songUrl != null) {
      if (action == PlayerState.PLAYING) {
        if (_playerState != PlayerState.PLAYING) {
          if (_playerState == PlayerState.PAUSED) {
            await _audioPlayer.resume();
          } else {
            await _audioPlayer.play(_songUrl!);
          }
        }
      } else if (action == PlayerState.PAUSED) {
        if (_playerState != PlayerState.PAUSED) {
          await _audioPlayer.pause();
        }
      } else if (action == PlayerState.STOPPED) {
        if (_playerState != PlayerState.STOPPED) {
          await _audioPlayer.stop();
        }
      } else if (action == PlayerState.COMPLETED) {
        if (_playerState != PlayerState.COMPLETED) {}
      }
    }
  }

  String _getTimeString(int milliseconds) {
    String minutes =
        "${(milliseconds / 60000).floor() < 10 ? 0 : ''}${(milliseconds / 60000).floor()}";
    String seconds =
        "${(milliseconds / 1000).floor() % 60 < 10 ? 0 : ''}${(milliseconds / 1000).floor() % 60}";
    return "$minutes:$seconds";
  }

  double _progressConvert() {
    var progress = (_progress / _duration).toDouble();

    if (progress.isNaN || progress.isInfinite) {
      return 0.0;
    } else {
      return progress;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(basenameWithoutExtension(widget.songReference.path)),
      ),
      body: SizedBox.expand(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      basenameWithoutExtension(widget.songReference.path),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _button(
                          () async => await _playerAction(PlayerState.PLAYING),
                          PlayerState.PLAYING,
                        ),
                        _button(
                          () async => await _playerAction(PlayerState.PAUSED),
                          PlayerState.PAUSED,
                        ),
                        _button(
                          () async => await _playerAction(PlayerState.STOPPED),
                          PlayerState.STOPPED,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_getTimeString(_progress)),
                        Text(_getTimeString(_duration)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: LinearProgressIndicator(
                      value: _progressConvert(),
                    ),
                    /* child: Slider.adaptive(
                      // max: _duration.toDouble(),
                      onChanged: (double value) async {
                        await _audioPlayer
                            .seek(Duration(milliseconds: value.toInt()));
                      },
                      value: _progressConvert(),
                    ), */
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(Function event, PlayerState type) {
    return IconButton(
      color: _playerState == type ? Colors.grey.shade300 : null,
      onPressed: () async => await event.call(),
      icon: _iconFromType(type),
    );
  }

  Icon _iconFromType(PlayerState type) {
    switch (type) {
      case PlayerState.PLAYING:
        return const Icon(Icons.play_arrow);
      case PlayerState.PAUSED:
        return const Icon(Icons.pause);
      case PlayerState.STOPPED:
        return const Icon(Icons.stop);
      default:
        return const Icon(Icons.alarm);
    }
  }
}
