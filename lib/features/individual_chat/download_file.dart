import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:http/http.dart' as http;

import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';

void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort send =
  IsolateNameServer.lookupPortByName('downloader_send_port')!;
  send.send([id, status, progress]);
}

class DownloadFile {
  Future<void> downloadAndOpenFile(String url) async {
    // Get temporary directory for storing the downloaded file
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Extract file name from the URL
    List<String> urlSegments = url.split('/');
    String fileName = urlSegments.last;

    // Check and request storage permission
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // Download the file
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Save the file to the temporary directory
        File file = File('$tempPath/$fileName');
        await file.writeAsBytes(response.bodyBytes);

        // Open the file
        await OpenFile.open('$tempPath/$fileName');
      } else {
        print('Failed to download the file. Status code: ${response.statusCode}');
      }
    } else {
      print('Storage permission denied.');
    }
  }
  // DownloadPdf(str, {context}) async {
  //   FlutterDownloader.registerCallback(downloadCallback);
  //   var splitString = str.toString().split("/");
  //   var preString = splitString.last.split(".");
  //
  //   print("AAA" + splitString.toString() + " " + preString.toString());
  //
  //   String staticFileName = preString[0].toString() + DateTime.now().toString() + "." + preString[1].toString();
  //   Directory? documents;
  //   var isExist = false;
  //
  //   if (Platform.isAndroid) {
  //     documents = await getExternalStorageDirectory();
  //     var deviceInfo = PlatformDeviceId.deviceInfoPlugin;
  //     var androidDeviceInfo = await deviceInfo.androidInfo;
  //     if (androidDeviceInfo.version.sdkInt < 33
  //         ? await Permission.storage.request().isGranted
  //         : await Permission.photos.request().isGranted) {
  //       permissionGranted(isExist, staticFileName, str, documents!.path);
  //     }
  //   }
  //   //ios
  //   else {
  //     documents = await getApplicationDocumentsDirectory();
  //     if (await Permission.storage.request().isGranted) {
  //       isExist = await File(documents.path + '/$staticFileName').exists();
  //       permissionGranted(isExist, staticFileName, str, documents.path);
  //     }
  //   }
  // }
  //
  // permissionGranted(isExist, staticFileName, url, documentsPath) async {
  //   print("hello" + staticFileName + " " + documentsPath + " " + url);
  //   isExist = false;
  //   bool waitTask = true;
  //   if (!isExist) {
  //     while (waitTask) {
  //       final taskId = await FlutterDownloader.enqueue(
  //         url: url,
  //         fileName: staticFileName,
  //         savedDir: documentsPath,
  //         showNotification: true,
  //         // show download progress in status bar (for Android)
  //         openFileFromNotification:
  //         true, // click on notification to open downloaded file (for Android)
  //       ).then((value) async {
  //         print("KELA " + value.toString());
  //         while (waitTask) {
  //           String query =
  //               "SELECT * FROM task WHERE task_id='" + value.toString() + "'";
  //           var _tasks =
  //           await FlutterDownloader.loadTasksWithRawQuery(query: query);
  //           print("KKK " + _tasks.toString());
  //           String taskStatus = _tasks![0].status.toString();
  //           print("LLL " + taskStatus.toString());
  //           int taskProgress = _tasks[0].progress;
  //           print("MMM " + taskProgress.toString());
  //           if (taskProgress == 100 && taskStatus == "DownloadTaskStatus(3)") {
  //             waitTask = false;
  //             if (Platform.isIOS)
  //               await OpenFile.open(documentsPath + '/$staticFileName').then((value){
  //                 print("A");
  //                 print(staticFileName);
  //                 print("B");
  //               });
  //             else {
  //               print("EE");
  //               await OpenFile.open(documentsPath + '/$staticFileName').then((value){
  //                 print("A");
  //                 print(staticFileName);
  //                 print("B");
  //               });
  //             }
  //           }
  //         }
  //       });
  //     }
  //   }
  // }
}