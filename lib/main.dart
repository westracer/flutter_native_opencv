import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_opencv_example/native_opencv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

const title = 'Native OpenCV Example';

late Directory tempDir;

String get tempPath => '${tempDir.path}/temp.jpg';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getTemporaryDirectory().then((dir) => tempDir = dir);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isProcessed = false;
  bool _isWorking = false;

  Future<void> takeImageAndProcess() async {
    final _picker = ImagePicker();
    PickedFile? image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 100);

    if (image == null) {
      return;
    }

    setState(() {
      _isWorking = true;
    });

    // Creating a port for communication with isolate and arguments for entry point
    final port = ReceivePort();
    final args = ProcessImageArguments(image.path, tempPath);

    // Spawning an isolate
    Isolate.spawn<ProcessImageArguments>(processImage, args,
        onError: port.sendPort, onExit: port.sendPort);

    // Making a variable to store a subscription in
    StreamSubscription? sub;

    // Listening for messages on port
    sub = port.listen((_) async {
      // Cancel a subscription after message received called
      await sub?.cancel();

      setState(() {
        _isProcessed = true;
        _isWorking = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.help),
            onPressed: () => showAboutDialog(
                context: context,
                applicationName: title,
                applicationLegalese: 'OpenCV version: ${opencvVersion()}')),
      ]),
      floatingActionButton: _isWorking
          ? null
          : FloatingActionButton(
              // isExtended: true,
              child: Icon(Icons.folder_open),
              onPressed: takeImageAndProcess,
            ),
      body: Stack(
        children: <Widget>[
          Center(
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                if (_isProcessed && !_isWorking)
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 3000, maxHeight: 300),
                    child: Image.file(
                      File(tempPath),
                      alignment: Alignment.center,
                    ),
                  ),
              ],
            ),
          ),
          if (_isWorking)
            Positioned.fill(
                child: Container(
              color: Colors.black.withOpacity(.7),
              child: Center(child: CircularProgressIndicator()),
            )),
        ],
      ),
    );
  }
}
