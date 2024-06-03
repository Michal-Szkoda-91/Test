import 'package:better_open_file/better_open_file.dart';
import 'package:cross_file/cross_file.dart';

extension XfileOpen on XFile {
  Future<void> open() => OpenFile.open(path);
}
