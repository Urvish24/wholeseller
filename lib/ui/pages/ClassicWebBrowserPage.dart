import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/PdfViewer.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';


const _chars = '1234567890';

class ClassicWebBrowserPage extends StatefulWidget {
  String url;
  bool fromEstimate;
  bool noDownload;


  ClassicWebBrowserPage({this.url, this.fromEstimate = true,this.noDownload = false});

  @override
  _ClassicWebBrowserPageState createState() => _ClassicWebBrowserPageState();
}

class _ClassicWebBrowserPageState extends State<ClassicWebBrowserPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  bool _isSuccess = false;
  String filepath = "";
  String _progress = "-";
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  StreamSubscription<ReceivedAction> notificationsActionStreamSubscription;

  @override
  void initState() {
    super.initState();
    print("ACTUAL URL " + widget.url);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final initSettings = InitializationSettings(android, iOS);

    flutterLocalNotificationsPlugin.initialize(initSettings, onSelectNotification: _onSelectNotification);

    /*  AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelKey: 'basic_channel12',
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Colors.white,
              importance: NotificationImportance.Max,
              ledColor: Colors.white)
        ]);*/

   /* notificationsActionStreamSubscription  =  AwesomeNotifications().actionStream.listen((receivedNotification) {
      if(_isSuccess){
        OpenFile.open(filepath);
      }
    });*/
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  Future<void> _onSelectNotification(String json) async {
    final obj = jsonDecode(json);

    if (obj['isSuccess']) {
      //OpenFile.open(obj['filePath']);

      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return PdfViewer(obj["filePath"]);
      }));
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('${obj['error']}'),
        ),
      );
    }
  }
  Future<void> _showNotification(Map<String, dynamic> downloadStatus) async {
    final android = AndroidNotificationDetails(
        'channel id',
        'channel name',
        'channel description',
        priority: Priority.High,
        importance: Importance.Max
    );
    final iOS = IOSNotificationDetails();
    final platform = NotificationDetails(android, iOS);
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'];

    await flutterLocalNotificationsPlugin.show(
        0, // notification id
        isSuccess ? 'Success' : 'Failure',
        isSuccess ? 'File has been downloaded successfully!' : 'There was an error while downloading the file.',
        platform,
        payload: json
    );
  }
  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      setState(() {
        _progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
    }
  }

  Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
    }

    return permission == PermissionStatus.granted;
  }

  Future<void> _downloadFile() async {
    var fromEstimate = "";
    if (widget.fromEstimate != null) {
      if (widget.fromEstimate == true) {
        fromEstimate = "clientestimates";
      } else {
        fromEstimate = "clientinvoices";
      }
    }
    String download_url = (widget.url).replaceAll("#/clientestimate", "");
    download_url = download_url.replaceAll(
        "https://zohosecurepay.in/books/myfitnesssportsprivatelimited/secure?",
        "");
    download_url =
        "https://zohosecurepay.in/books/myfitnesssportsprivatelimited/api/v3/$fromEstimate/secure?" +
            download_url.trim() +
            "&accept=pdf";
    print("download_url " + download_url);
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath'; // 3
    final isPermissionStatusGranted = await _requestPermissions();

    if (isPermissionStatusGranted) {
      _startDownload(appDocumentsPath + "/1.pdf", download_url);
    }

    // downloadFile(download_url, appDocumentsPath);
    // print(await downloadFile(download_url, appDocumentsPath));
  }

  final Dio _dio = Dio();

  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> _startDownload(String savePath, String _fileUrl) async {
    final dir = await DownloadsPathProvider.downloadsDirectory;

    final savePath =
        path.join(dir.path, "MyFitness_invoice${getRandomString(10)}.pdf");
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
    };

    try {
      final response = await _dio.download(_fileUrl, savePath,
          onReceiveProgress: _onReceiveProgress);
      result['isSuccess'] = response.statusCode == 200;
      result['filePath'] = savePath;
    } catch (ex) {
      result['error'] = ex.toString();
    } finally {
      print(result);
      await _showNotification(result);
      if (result["isSuccess"]) {
       /*  AwesomeNotifications().createNotification(
            content: NotificationContent(
                id: 10,
                channelKey: 'basic_channel',
                displayOnBackground: true,
                displayOnForeground: true,
                title: "My Fitness",
                body: "Pdf downloaded successfully"));*/
        filepath = result["filePath"];
        setState(() {
          _isSuccess = true;
        });
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return PdfViewer(result["filePath"]);
        }));

      }
      // await _showNotification(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("object " + p.extension(widget.url));
    String url = widget.url;
    if (p.extension(widget.url) == '.heic') {
      var pos = url.lastIndexOf('.');
      url = (pos != -1) ? url.substring(0, pos) : url;
      url = url + '.png';
      //url = url.substring(url.lastIndexOf('.')).substring(0) +'.png';

    } else if (p.extension(widget.url) == '.pdf') {
      url = 'https://docs.google.com/gview?embedded=true&url=${widget.url}';
    }
    print("object" + url);
    return WebviewScaffold(
      resizeToAvoidBottomInset: true,
      url: url,
      withJavascript: true,
      allowFileURLs: true,
      withZoom: false,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        title: const Text('MyFitness'),
        actions: [
          (!widget.noDownload)?GestureDetector(
              onTap: () => (!_isSuccess) ? _downloadFile() : {},
              child: appIcon(
                  iconData: (!_isSuccess)
                      ? Icons.download_rounded
                      : Icons.download_done_rounded)):SizedBox()
        ],
      ),
      withLocalStorage: false,
      hidden: true,
      initialChild: Container(
        color: appSecondColorOpecity,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    );
  }
}
