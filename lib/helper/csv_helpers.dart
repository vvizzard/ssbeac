import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:path_provider/path_provider.dart';


class CsvHelper {

  bool _allowWriteFile = false;
 
  // CsvHelper() {
  //   requestWritePermission();
  // }
 
  // Platform messages are asynchronous, so we initialize in an async method.
  Future requestWritePermission() async {
    return SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    // print("permission status authorized:");
    // print(PermissionStatus.authorized.toString());
    // if (permissionStatus == PermissionStatus.authorized) {
    //   _allowWriteFile = true;
    // }
  }

  Future get _localPath async {
    // Application documents directory: /data/user/0/{package_name}/{app_name}
    final applicationDirectory = await getApplicationDocumentsDirectory();
 
    // External storage directory: /storage/emulated/0
    final externalDirectory = await getExternalStorageDirectory();
 
    // Application temporary directory: /data/user/0/{package_name}/cache
    final tempDirectory = await getTemporaryDirectory();
 
    return externalDirectory.path;
  }

  Future _localFile(String name) async {
    final path = await _localPath;
    return File('$path/$name');
  }

  Future _writeToFile(String name, String text) async {
    if (!_allowWriteFile) {
      print("not allowed");
      // return null;
      requestWritePermission().then((value) => {
        if(value == PermissionStatus.authorized) {
          _allowWriteFile = true,
          _writeToFile(name, text)
        }
      });
    }
    final file = await _localFile(name);
 
    // Write the file
    // File result = await file.writeAsString(utf8.decode(latin1.encode(text), allowMalformed: true));
    File result = await file.writeAsString(text, encoding: Latin1Codec());
    print(result.path);
  }

  generateCsv(String name, List<List<String>> data) async {
    String csvData = ListToCsvConverter().convert(data,fieldDelimiter: ";");
    print(csvData);
    _writeToFile(name, csvData);
  }

  
}