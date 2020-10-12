import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:logger/logger.dart';
import 'package:window_size/window_size.dart';
import 'package:process_run/process_run.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    // Feature currently broken, will make an issue on Dart SDK GitHub
    // lineLength: io.stdout.terminalColumns,
    lineLength: 80,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

void main() {
  runApp(OpenAFK());
}

class OpenAFK extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open AFK',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Open AFK Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static String apiURL = 'https://chocolatey.org/api/v2';
  io.ProcessResult _output;
  String _outputString;

  void _installTest() async {
    await run('.\\scripts\\chocolatey_installer.bat', [''], verbose: true);
    _output = await run(
        r'choco upgrade',
        [
          'blender',
          '--confirm',
          '--source=$apiURL',
        ],
        commandVerbose: true);
    _output = await run('powershell', ['.\\scripts\\ShowDesktopIcons.ps1'],
        verbose: true);
    print(_output.exitCode);
    setState(() {
      _outputString = _output.stdout;
    });
  }

  @override
  void initState() {
    super.initState();
    setWindowTitle('Open AFK');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Output:',
            ),
            Text(
              '$_outputString',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _installTest,
        tooltip: 'Install',
        child: Icon(Icons.add),
      ),
    );
  }
}
