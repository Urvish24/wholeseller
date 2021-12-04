import 'dart:io';
import 'package:bwc/res/strings.dart';
import 'package:bwc/ui/pages/ClassicWebBrowserPage.dart';
import 'package:bwc/ui/pages/WebBrowserPage.dart';
import 'package:bwc/ui/pages/dispatchPage.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:http/http.dart' as http;
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/ModelImageUpload.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'button.dart';

class EstimatesCellAdmin extends StatefulWidget {
  var wSellerArray;
  int i;
  GestureTapCallback onTap;
  Function apiReload;

  EstimatesCellAdmin({this.wSellerArray, this.i, this.apiReload});

  @override
  _EstimatesCellAdminState createState() =>
      _EstimatesCellAdminState();
}

class _EstimatesCellAdminState extends State<EstimatesCellAdmin> {
  bool _isLoading = false;
  bool _isLoadinginvoice = false;
  TextEditingController _controllerEmail = TextEditingController();
  final _focusEmail = FocusNode();
  File file = null;
  ModelImageUpload modelImageUpload;
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());


  showAlertRejectDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK",style: TextStyle(fontWeight: FontWeight.w700),),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Rejection reason"),
      content: Text(widget.wSellerArray['est_reject_reason'],style: TextStyle(fontWeight: FontWeight.w600),),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("object ${widget.wSellerArray.toString()}");
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.wSellerArray['est_proof_status']}",
                  style: list_title,
                ),
                Text(
                  '₹' + widget.wSellerArray['est_total'],
                  style: list_title,
                ),
              ],
            ),
            sizedBoxUv,
            Container(
              height: 2,
              color: appSecondColor,
            ),
            sizedBoxUv,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.wSellerArray['usr_name'],
                  style: list_titleblack,
                ),
                Text(
                  widget.wSellerArray['est_date'],
                  style: list_normal,
                ),
              ],
            ),
            sizedBoxlightUv,
            Row(
              children: [
                Expanded(
                  child: _button(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  chooseFile() async {
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
                .estimateUpdate(map, widget.wSellerArray['_id'])
            as Map<String, dynamic>;

        show(_responseMap['message'],context,green);
        setState(() {
          _isLoading = false;
        });
        widget.apiReload();
      } else {
        show(_List.message,context,red);
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
  Future<void> _navigation(context) async {
    /*final information =  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return WebBrowserPage(url: widget.wSellerArray['est_proof_url'],admin: true,id: widget.wSellerArray['_id'],);
    }));*/
    var result = await Navigator.push(context, new MaterialPageRoute(
      builder: (BuildContext context) =>  WebBrowserPage(url: widget.wSellerArray['est_proof_url'],admin: true,id: widget.wSellerArray['_id'],),
      fullscreenDialog: true,)
    );
    print("NAVVVV "+result.toString());
    if(result){
      ApiCalling(true,context);
    }else if(!result){
      _showDialog(context);
    }
  }
  _showDialog(context) async {
    await showDialog<String>(
      context: context,
        builder: (BuildContext c)
        {
          return new AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                autofocus: true,
                controller: _controllerEmail,
                decoration: new InputDecoration(
                    labelText: 'Reason of Rejection', hintText: 'message'),
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(c);
              }),
          new FlatButton(
              child: const Text('SUBMIT'),
              onPressed: () {
                ApiCalling(false,context);
                Navigator.pop(c);

              })
        ],
      );}
    );
  }

  Future<void> _invoiceClicked(context, id) async {
    setState(() {
      _isLoadinginvoice = true;
    });
    Map<String, dynamic> _responseMap =
    await _contactRepository.invoiceById(id) as Map<String, dynamic>;
    setState(() {
      _isLoadinginvoice = false;
    });
    if(_responseMap['data']['invoice_url'] != null){
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ClassicWebBrowserPage(url:_responseMap['data']['invoice_url'],fromEstimate: false);
      }));
    }else{
      show("Can't getting invoice", context, red);
    }

  }

  Future<void> ApiCalling(bool approve,BuildContext context) async {
    var map;
    if(approve){
      map  = {
        "est_proof_status":"Approved"
      };
    }else{

      map  = {
        "est_proof_status":"Rejected",
        "est_reject_reason":_controllerEmail.text
      };
    }

    Map<String, dynamic> _responseMap = await _contactRepository
        .estimateStatusChange(map, widget.wSellerArray['_id'])
    as Map<String, dynamic>;
    if (_responseMap['status'] == true) {
      widget.apiReload();
      show(_responseMap['message'],context,green);
    }else{
      show(_responseMap['message'],context,red);
    }

  }
  Widget _button(context) {
    if (widget.wSellerArray['est_proof_status'] == 'Pending') {
      if (widget.wSellerArray.containsKey('est_proof_url')) {
        return RisedButtonuv(
            title: 'View Proof',
            onTap: () =>
            _navigation(context),
            loading: _isLoading);
      }else{
        return Container();
      }
    } else if(widget.wSellerArray['est_proof_status'] == 'Approved') {
      return RisedButtonuv(
          title: 'Dispatch',
          onTap: () =>  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return dispatchPage(widget.wSellerArray);
          })),
          loading: _isLoading);
    } else if(widget.wSellerArray['est_proof_status'] == 'Rejected') {
      return RisedButtonuv(
          title: 'View reason',
          onTap: () => showAlertRejectDialog(context),
          loading: _isLoading);
    } else if(widget.wSellerArray['est_proof_status'] == 'Dispatched') {
      return RisedButtonuv(
          title: 'Invoice',
          onTap: () => _invoiceClicked(
              context, widget.wSellerArray['est_invoice_id']),
          loading: _isLoadinginvoice);
    }
  }
}
