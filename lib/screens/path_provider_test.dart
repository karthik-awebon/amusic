import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PathProviderTest extends StatefulWidget {
  static const routeName = './path-provider_test';
  const PathProviderTest({Key? key}) : super(key: key);

  @override
  State<PathProviderTest> createState() => _PathProviderTestState();
}

class _PathProviderTestState extends State<PathProviderTest> {
  Future<Directory?>? _tempDirectory;
  Future<Directory?>? _appSupportDirectory;
  Future<Directory?>? _appLibraryDirectory;
  Future<Directory?>? _appDocumentsDirectory;
  Future<Directory?>? _externalDocumentsDirectory;
  Future<List<Directory>?>? _externalStorageDirectories;
  Future<List<Directory>?>? _externalCacheDirectories;
  Future<Directory?>? _downloadsDirectory;

  void _requestTempDirectory() {
    setState(() {
      _tempDirectory = getTemporaryDirectory();
    });
  }

  Widget _buildDirectory(
      BuildContext context, AsyncSnapshot<Directory?> snapshot) {
    Text text = const Text('', style: TextStyle(color: Colors.black));
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error: ${snapshot.error}',
            style: TextStyle(color: Colors.black));
      } else if (snapshot.hasData) {
        text = Text('path: ${snapshot.data!.path}',
            style: TextStyle(color: Colors.black));
      } else {
        text = const Text('path unavailable',
            style: TextStyle(color: Colors.black));
      }
    }
    return Padding(padding: const EdgeInsets.all(16.0), child: text);
  }

  Widget _buildDirectories(
      BuildContext context, AsyncSnapshot<List<Directory>?> snapshot) {
    Text text = const Text('', style: TextStyle(color: Colors.black));
    if (snapshot.connectionState == ConnectionState.done) {
      if (snapshot.hasError) {
        text = Text('Error: ${snapshot.error}',
            style: TextStyle(color: Colors.black));
      } else if (snapshot.hasData) {
        final String combined =
            snapshot.data!.map((Directory d) => d.path).join(', ');
        text = Text('paths: $combined', style: TextStyle(color: Colors.black));
      } else {
        text = const Text('path unavailable',
            style: TextStyle(color: Colors.black));
      }
    }
    return Padding(padding: const EdgeInsets.all(16.0), child: text);
  }

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  void _requestAppSupportDirectory() {
    setState(() {
      _appSupportDirectory = getApplicationSupportDirectory();
    });
  }

  void _requestAppLibraryDirectory() {
    setState(() {
      _appLibraryDirectory = getLibraryDirectory();
    });
  }

  void _requestExternalStorageDirectory() {
    setState(() {
      _externalDocumentsDirectory = getExternalStorageDirectory();
    });
  }

  void _requestExternalStorageDirectories(StorageDirectory type) {
    setState(() {
      _externalStorageDirectories = getExternalStorageDirectories(type: type);
    });
  }

  void _requestExternalCacheDirectories() {
    setState(() {
      _externalCacheDirectories = getExternalCacheDirectories();
    });
  }

  void _requestDownloadsDirectory() {
    setState(() {
      _downloadsDirectory = getDownloadsDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Path Provider'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _requestTempDirectory,
                    child: const Text(
                      'Get Temporary Directory',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                FutureBuilder<Directory?>(
                  future: _tempDirectory,
                  builder: _buildDirectory,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _requestAppDocumentsDirectory,
                    child: const Text('Get Application Documents Directory',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                FutureBuilder<Directory?>(
                  future: _appDocumentsDirectory,
                  builder: _buildDirectory,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: _requestAppSupportDirectory,
                    child: const Text(
                      'Get Application Support Directory',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                FutureBuilder<Directory?>(
                  future: _appSupportDirectory,
                  builder: _buildDirectory,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed:
                        Platform.isAndroid ? null : _requestAppLibraryDirectory,
                    child: Text(
                        Platform.isAndroid
                            ? 'Application Library Directory unavailable'
                            : 'Get Application Library Directory',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                FutureBuilder<Directory?>(
                  future: _appLibraryDirectory,
                  builder: _buildDirectory,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: !Platform.isAndroid
                        ? null
                        : _requestExternalStorageDirectory,
                    child: Text(
                        !Platform.isAndroid
                            ? 'External storage is unavailable'
                            : 'Get External Storage Directory',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                FutureBuilder<Directory?>(
                  future: _externalDocumentsDirectory,
                  builder: _buildDirectory,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: !Platform.isAndroid
                        ? null
                        : () {
                            _requestExternalStorageDirectories(
                              StorageDirectory.music,
                            );
                          },
                    child: Text(
                        !Platform.isAndroid
                            ? 'External directories are unavailable'
                            : 'Get External Storage Directories',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                FutureBuilder<List<Directory>?>(
                  future: _externalStorageDirectories,
                  builder: _buildDirectories,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: !Platform.isAndroid
                        ? null
                        : _requestExternalCacheDirectories,
                    child: Text(
                        !Platform.isAndroid
                            ? 'External directories are unavailable'
                            : 'Get External Cache Directories',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                FutureBuilder<List<Directory>?>(
                  future: _externalCacheDirectories,
                  builder: _buildDirectories,
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: Platform.isAndroid || Platform.isIOS
                        ? null
                        : _requestDownloadsDirectory,
                    child: Text(
                        Platform.isAndroid || Platform.isIOS
                            ? 'Downloads directory is unavailable'
                            : 'Get Downloads Directory',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                FutureBuilder<Directory?>(
                  future: _downloadsDirectory,
                  builder: _buildDirectory,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
