import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'song_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textFildResearchController = TextEditingController();

  List<File> _songs = [];
  bool _isLoadSongs = false;
  bool _isResearched = false;

  Future<List<File>> _loadSongs() async {
    try {
      final data = await FirebaseStorage.instance.ref('/songs/').list();
      return data.items.map((e) => File(e.fullPath)).toList();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('errore loadSongs => ${e.message}');
      }
      return [];
    }
  }

  void _fetchSongs() async {
    await _loadSongs().then(
      (e) => setState(() {
        _songs = e;
        _isLoadSongs = true;
      }),
    );
  }

  @override
  void initState() {
    _fetchSongs();
    super.initState();
  }

  @override
  void dispose() {
    _songs.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: _isResearched
            ? Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    onEditingComplete: () => setState(() {}),
                    onChanged: (e) => setState(() {}),
                    controller: _textFildResearchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _textFildResearchController.clear();
                            _isResearched = false;
                          });
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              )
            : const Text('Canzoni'),
        actions: [
          _isLoadSongs && _songs.isNotEmpty && !_isResearched
              ? IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => setState(() => _isResearched = true),
                )
              : Container(),
        ],
      ),
      body: _songs.isNotEmpty
          ? _buildSongsSection()
          : _isLoadSongs
              ? _songsEmpty()
              : _buildSongsSectionLoading(),
    );
  }

  Widget _buildSongsSection() {
    final filterSongs = _songs
        .where((e) => e.path.contains(_textFildResearchController.text))
        .toList();

    return SizedBox.expand(
      child: RefreshIndicator(
        onRefresh: () async => _fetchSongs(),
        child: ListView.builder(
          itemBuilder: (context, i) {
            return _tile(
                basenameWithoutExtension(filterSongs[i].path), i, context);
          },
          itemCount: filterSongs.length,
        ),
      ),
    );
  }

  Widget _buildSongsSectionLoading() {
    return SizedBox.expand(
      child: ListView.builder(
        itemBuilder: (context, i) {
          return _tile('', null, context);
        },
        itemCount: 10,
      ),
    );
  }

  Widget _tile(String text, int? index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () async => index != null
            ? await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SongDetail(songReference: _songs[index]),
                ),
              )
            : () {},
        tileColor: const Color(0xFFbeb7a4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(text),
      ),
    );
  }

  Widget _songsEmpty() {
    return const SizedBox.expand(
      child: Center(
        child: Text('Nessuna Canzone Disponibile'),
      ),
    );
  }
}
