import 'dart:io';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/ModelImageUpload.dart';
import 'package:bwc/models/ModelItemCreate.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/res/strings.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProviderItemCreate extends ChangeNotifier {
  File file = null;
  ModelImageUpload modelImageUpload;
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());

  chooseFile() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      file = File(result.files.single.path);
      notifyListeners();
      //uploadFile(file);
    }
  }
  imageApiCall(map,context){

    //print(map.toString());
    uploadImg(file,map,context);

  }

  void dis() {
    file = null;
  }

  Future<void> uploadImg(File file,var map,var context) async {

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
      print("response " + data.toString());
      ModelImageUpload _List = ModelImageUpload.fromJson(data);
      if(_List.status == true){
        map["itm_image_name"] = _List.data;
        print("map "+map.toString());
        var mapjson = {
          "items":[{
            "itm_name":map["itm_name"],
            "itm_id":map["itm_id"],
            "itm_image_type":"type",
            "itm_image_name":_List.data,
            "itm_price":map["itm_price"]

          }]
        };
        print(mapjson.toString());

      ModelItemCreate _model  = await _contactRepository.createItem(mapjson);
        if (_model.status == true) {
          Navigator.of(context).pop();
        } else {
          show(_model.message,context,red);
        }
      }

    });
  }
}
