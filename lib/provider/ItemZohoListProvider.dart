import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/ModelItemCreate.dart';
import 'package:bwc/models/ModelItemZoho.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:flutter/cupertino.dart';

class ItemZohoListProvider extends ChangeNotifier{
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  ModelItemZoho modelItemZoho;
  bool isLoading = true;

  initApiCall(context) async {
    modelItemZoho = await _contactRepository.itemByZOho();
    print("loginnnn " + modelItemZoho.status.toString());

    if (modelItemZoho.status.toString() != 'true') {
      show(modelItemZoho.message,context,red);
    }
    isLoading = false;
    notifyListeners();
  }

  changeModelValue(int i){
     modelItemZoho.data[i].selected = !modelItemZoho.data[i].selected;
     notifyListeners();
  }

  doneApiCall(context) async {
    isLoading = true;
    notifyListeners();
   List<dynamic> array = [];
   var dataa = modelItemZoho.data;
   for(int i = 0; i<dataa.length; i++){
     if(dataa[i].selected){
       array.add({
         "itm_name":dataa[i].name,
         "itm_id":dataa[i].itemId,
         "itm_image_type":dataa[i].imageType+"",
         "itm_image_name":dataa[i].imageName+"",
         "itm_no_of_pack":dataa[i].pack.toString(),
         "itm_price":dataa[i].rate.toString()
       });

     }
   }

   var map = {
       "items":array
   };
   print("ARRRAYY "+ map.toString());

   ModelItemCreate itemCreate = await _contactRepository.createItem(map);
    if (itemCreate.status.toString() != 'true') {
      show(itemCreate.message,context,red);
    }else{
      show(itemCreate.message,context,green);
    }

    isLoading = false;
    Navigator.of(context).pop();
  }
}