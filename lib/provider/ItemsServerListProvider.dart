import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/models/ModelImageUpload.dart';
import 'package:bwc/models/ModelItemDelete.dart';
import 'package:bwc/models/ModelItemListServer.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:flutter/cupertino.dart';

class ItemsServerListProvider extends ChangeNotifier{
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  ModelItemListServer modelitemListServer;
  bool isLoading = true;

  fetchServerList(context) async {
    modelitemListServer = await _contactRepository.fetchServerItemList();
   // print("loginnnn " + _modelImageUpload.status.toString());

    if (modelitemListServer.status.toString() != 'true') {
      show(modelitemListServer.message,context,red);
    }
    isLoading = false;
    notifyListeners();
  }

  deleteServerItem(id,context) async {
   ModelItemDelete model = await _contactRepository.deleteItem(id);
   if (model.status.toString() != 'true') {
     show(model.message,context,red);
   }else{
     fetchServerList(context);
   }

  }

}