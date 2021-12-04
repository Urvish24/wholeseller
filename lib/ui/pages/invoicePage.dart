import 'package:bwc/common/Common.dart';
import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/InvoiceCell.dart';
import 'package:bwc/ui/widgets/InvoiceCellCustomer.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class invoicePage extends StatefulWidget {
  String fromSeller;


  invoicePage({this.fromSeller = "0"});

  @override
  _invoicePageState createState() => _invoicePageState();
}

class _invoicePageState extends State<invoicePage> {
  bool _isLoading = true;
  bool _isLoadingLink = false;
  //var data = [false,false,false,false];
  TextEditingController _controller = TextEditingController();
  var _id = "";
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  var data = [];
  var _invoiceId ="";

  @override
  Future<void> initState()  {
    if(widget.fromSeller == "0"){
      _id = cId;
    }else{
      _id = widget.fromSeller;
    }
    initApi();
  }

  Future<void> initApi() async {
    print("_ID "+_id.toString());
    Map<String, dynamic> _responseMap = await _contactRepository
        .invoiceByCId(_id) as Map<String, dynamic>;
     var rowData = _responseMap['data'];
    for(int i =0 ; i<rowData.length;i++){
      data.add({
        "invoice_id":rowData[i]["invoice_id"],
        "customer_name":rowData[i]["customer_name"],
        "company_name":rowData[i]["company_name"],
        "status":rowData[i]["status"],
        "invoice_number":rowData[i]["invoice_number"],
        "date":rowData[i]["date"],
        "invoice_url":rowData[i]["invoice_url"],
        "created_by":rowData[i]["created_by"],
        "total":rowData[i]["total"],
        "clicked":false});

    }

    setState(() {
      _isLoading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Invoice",
              style: TextStyle(color: appSecondColor, fontWeight: FontWeight.w800)),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 20,
              height: 20,
              child: appIcon(iconData: Icons.arrow_back),
            ),
          )
      ),
      body:  (_isLoading)
          ? Loader()
          : AnimationLimiter(
            child: ListView.builder(
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      child: SlideAnimation(
                        verticalOffset: 500.0,
                        child: FadeInAnimation(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                ItemsCellCustomer(data[index]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                itemCount: data.length,
                scrollDirection: Axis.vertical),
          ));
  }
}
