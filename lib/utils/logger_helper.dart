import 'package:logger/logger.dart';

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