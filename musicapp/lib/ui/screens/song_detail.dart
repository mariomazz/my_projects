import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class SongDetail extends StatelessWidget {
  const SongDetail({Key? key, required this.songReference}) : super(key: key);
  final File songReference;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(basenameWithoutExtension(songReference.path)),
      ),
      body: SizedBox.expand(
        child: Center(
          child: Text(songReference.path),
        ),
      ),
    );
  }
}
