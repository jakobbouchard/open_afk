import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:open_afk/utils/logger_helper.dart';
import 'package:window_size/window_size.dart';
import 'package:process_run/process_run.dart';

void main() {
  runApp(OpenAFK(title: 'Open AFK'));
}

class OpenAFK extends StatefulWidget {
  OpenAFK({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _OpenAFKState createState() => _OpenAFKState();
}

class _OpenAFKState extends State<OpenAFK> {
  @override
  void initState() {
    super.initState();
    setWindowTitle(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.yellow,
        accentColor: Colors.yellow[500],
        toggleableActiveColor: Colors.yellow[500],
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.yellow[200],
        ),
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
        'choco upgrade',
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
