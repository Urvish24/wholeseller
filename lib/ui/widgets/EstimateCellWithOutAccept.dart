import 'dart:io';
import 'package:bwc/res/strings.dart';
import 'package:bwc/ui/pages/ClassicWebBrowserPage.dart';
import 'package:bwc/ui/pages/CreateEstimateCustomer.dart';
import 'package:bwc/ui/pages/WebBrowserPage.dart';
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
import 'package:path/path.dart' as p;
import 'package:flutter_pdfview/flutter_pdfview.dart';

class EstimateCellWithOutAccept extends StatefulWidget {
  var wSellerArray;
  int i;
  GestureTapCallback onTap;
  Function apiReload;

  EstimateCellWithOutAccept({this.wSellerArray, this.i, this.apiReload});

  @override
  _EstimateCellWithOutAcceptState createState() =>
      _EstimateCellWithOutAcceptState();
}

class _EstimateCellWithOutAcceptState extends State<EstimateCellWithOutAccept> {
  bool _isLoading = false;
  bool _isLoadinginvoice = false;

  File file = null;

  ModelImageUpload modelImageUpload;

  ContactRepository _contactRepository = ContactRepository(ContactDataSource());

  showAlertRejectDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Rejection reason"),
      content: Text(
        widget.wSellerArray['est_reject_reason'],
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
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
                  widget.wSellerArray['est_number'],
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

  chooseFile(context) async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null) {
      file = File(result.files.single.path);
      //uploadFile(file);

      String extension = p.extension(file.toString());

      print('DTAT0 ' + extension);
      if (extension == ".jpg'" ||
          extension == ".jpg" ||
          extension == ".jpeg'" ||
          extension == ".jpeg" ||
          extension == ".png'" ||
          extension == ".png") {
        showDialog1(context, file);
      } else {
        uploadImg(file, context);
      }
      // uploadImg(file, context);
    }
  }

  Future<void> showDialog1(context, file) async {
    BuildContext dialogContext;
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: context,
      pageBuilder: (c, __, ___) {
        dialogContext = c;
        return Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 400,
              child: SizedBox.expand(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.file(
                      file,
                      height: 250,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Do you want to upload this?",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: RisedButtonuv(
                                title: 'Upload',
                                textSize: 13,
                                color: green,
                                onTap: () => {
                                      Navigator.pop(dialogContext),
                                      uploadImg(file, context),
                                    },
                                loading: _isLoadinginvoice),
                          ),
                          Expanded(
                            child: RisedButtonuv(
                                title: 'Cancel',
                                textSize: 13,
                                color: red,
                                onTap: () => Navigator.pop(dialogContext),
                                loading: _isLoading),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
              margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
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

        show(_responseMap['message'], context, green);

        setState(() {
          _isLoading = false;
        });
        widget.apiReload();
      } else {
        show(_List.message, context, red);
        setState(() {
          _isLoading = false;
        });
      }
    });
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

    if (_responseMap['data'].length != 0) {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return ClassicWebBrowserPage(
            url: _responseMap['data']['invoice_url'], fromEstimate: false);
      }));
    } else {
      show("Can't get invoice", context, red);
    }
  }

  Widget _button(context) {
    if (widget.wSellerArray['est_proof_status'] == 'Pending') {
      if (widget.wSellerArray.containsKey('est_proof_url')) {
        return Row(
          children: [
            Expanded(
              child: RisedButtonuv(
                  title: 'View Proof',
                  textSize: 13,
                  onTap: () => Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return WebBrowserPage(
                          url: widget.wSellerArray['est_proof_url'],
                          id: widget.wSellerArray['_id'],
                        );
                      })),
                  loading: _isLoading),
            ),
            RisedButtonuv(
                title: 'Edit',
                textSize: 13,
                onTap: () => {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return CreateEstimateCustomer(
                            isfromedit: true,
                            estId: widget.wSellerArray['_id']);
                      }))
                    }),
          ],
        );
      } else {
        return Row(
          children: [
            Expanded(
              child: RisedButtonuv(
                  title: 'Upload Proof',
                  textSize: 13,
                  onTap: () => chooseFile(context),
                  loading: _isLoading),
            ),
            RisedButtonuv(
              title: 'Edit',
              textSize: 13,
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return CreateEstimateCustomer(
                      isfromedit: true, estId: widget.wSellerArray['_id']);
                }))
              },
            ),
          ],
        );
      }
    } else if (widget.wSellerArray['est_proof_status'] == 'Approved') {
      /*return Padding(
        padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
        child: Text('In Progress',style: list_title,),
      );*/
      return SizedBox();
    } else if (widget.wSellerArray['est_proof_status'] == 'Rejected') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RisedButtonuv(
              title: 'View reason',
              textSize: 13,
              margin: false,
              onTap: () => showAlertRejectDialog(context)),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: RisedButtonuv(
                      title: 'Upload Proof',
                      textSize: 13,
                      margin: false,
                      onTap: () => chooseFile(context),
                      loading: _isLoading),
                ),
                RisedButtonuv(
                  title: 'Edit',
                  textSize: 13,
                  margin: false,
                  onTap: () => {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return CreateEstimateCustomer(
                          isfromedit: true, estId: widget.wSellerArray['_id']);
                    }))
                  },
                ),
              ],
            ),
          )
        ],
      );
    } else if (widget.wSellerArray['est_proof_status'] == 'Dispatched') {
      return Row(
        children: [
          Expanded(
            child: RisedButtonuv(
                title: 'Invoice',
                textSize: 13,
                onTap: () => _invoiceClicked(
                    context, widget.wSellerArray['est_invoice_id']),
                loading: _isLoadinginvoice),
          ),
          Expanded(
            child: RisedButtonuv(
                title: 'Track Order',
                textSize: 13,
                onTap: () =>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return ClassicWebBrowserPage(
                        url: widget.wSellerArray['est_awb_number'],
                        fromEstimate: false,
                        noDownload: true,
                      );
                    })),
                loading: _isLoading),
          ),
        ],
      );
    }
  }
}
