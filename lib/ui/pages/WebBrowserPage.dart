import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/ModelImageUpload.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/res/strings.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';


class WebBrowserPage extends StatefulWidget {
  String url;
  bool admin;
  String id;


  WebBrowserPage({this.url,this.admin = false,this.id="0"});

  @override
  _WebBrowserPageState createState() => _WebBrowserPageState();
}

class _WebBrowserPageState extends State<WebBrowserPage> {

  final flutterWebViewPlugin = FlutterWebviewPlugin();
  bool _isLoading = false;
  bool _isLoadingapp = false;
  bool _isLoadingrej = false;
  TextEditingController _controllerEmail = TextEditingController();
  final _focusEmail = FocusNode();
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  File file = null;
  ModelImageUpload modelImageUpload;

  @override
  void initState() {
    super.initState();
    print("URL "+widget.url);
   // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  chooseFile(context) async {
    FilePickerResult result =
    await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      file = File(result.files.single.path);
      //uploadFile(file);
      uploadImg(file, context);
    }
  }

  Future<void> uploadImg(File file, var context) async {
    setState(() {
      _isLoading = true;
    });
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length(); //imageFile is your image file
    var uri = Uri.parse(AppStrings.uploadImage);
    var request = new http.MultipartRequest("POST", uri);
    var multipartFileSign = new http.MultipartFile('updDocs', stream, length,
        filename: basename(file.path));
    request.files.add(multipartFileSign);
    request.fields['updType'] = 'image';
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) async {
      print(value);
      /*if (response.statusCode == 200) {*/
      var data = json.decode(value);
      print("response Image" + data.toString());
      ModelImageUpload _List = ModelImageUpload.fromJson(data);
      if (_List.status == true) {
        var data = json.decode(value);
        ModelImageUpload _List = ModelImageUpload.fromJson(data);
        //_List.data;
        var map = {"est_proof_url": _List.data};
        Map<String, dynamic> _responseMap = await _contactRepository
            .estimateUpdate(map, widget.id)
        as Map<String, dynamic>;

        show(_responseMap['message'],context,green);

        Navigator.of(context).pop();
      } else {
        show(_List.message,context,red);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    print("object "+p.extension(widget.url));
    String url =widget.url;
    if(p.extension(widget.url) == '.heic'){
      var pos = url.lastIndexOf('.');
       url = (pos != -1)? url.substring(0, pos): url;
       url = url +'.png';
      //url = url.substring(url.lastIndexOf('.')).substring(0) +'.png';

    }
    else if(p.extension(widget.url) == '.pdf'){
      url = 'https://docs.google.com/gview?embedded=true&url=${widget.url}';
    }
    print("object"+url);
     if(p.extension(widget.url) == '.jpg' || p.extension(widget.url) == '.png')
       {
         return Scaffold(
           appBar: AppBar(
             title: const Text('MyFitness'),
           ),
           body: Center(
             child: PhotoView(imageProvider:  NetworkImage(url)),
           ),
           bottomNavigationBar: (widget.admin)?BottomAppBar(
             child: Row(
               children: <Widget>[
                 Expanded(child:
                 RisedButtonuv(title: "Accept",onTap: ()=>Navigator.pop(context, true),color: Colors.lightGreen,loading: _isLoadingapp,)),
                 Expanded(child:
                 RisedButtonuv(title: "Reject",onTap: ()=> Navigator.pop(context, false),color: Colors.red,loading: _isLoadingrej,)),
               ],
             ),
           ):BottomAppBar(
             child: Expanded(child:
             RisedButtonuv(title: "Re-upload Proof",onTap: ()=>chooseFile(context),loading: _isLoading,)),
           ),
         );
       }else{
       return  WebviewScaffold(
         resizeToAvoidBottomInset: true,
         url: url,
         withJavascript: true,
         mediaPlaybackRequiresUserGesture: false,
         appBar: AppBar(
           title: const Text('MyFitness'),
         ),
         withLocalStorage: false,
         hidden: true,
         withZoom: true,
         displayZoomControls: true,
         initialChild: Container(
           color: appSecondColorOpecity,
           child: const Center(
             child: Text('Waiting.....'),
           ),
         ),
         bottomNavigationBar: (widget.admin)?BottomAppBar(
           child: Row(
             children: <Widget>[
               Expanded(child:
               RisedButtonuv(title: "Accept",onTap: ()=>Navigator.pop(context, true),color: Colors.lightGreen,loading: _isLoadingapp,)),
               Expanded(child:
               RisedButtonuv(title: "Reject",onTap: ()=> Navigator.pop(context, false),color: Colors.red,loading: _isLoadingrej,)),
             ],
           ),
         ):BottomAppBar(
           child: Expanded(child:
           RisedButtonuv(title: "Re-upload Proof",onTap: ()=>chooseFile(context),loading: _isLoading,)),
         ),
       );
     }


  }
}
