import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/InvoiceCell.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class dispatchPage extends StatefulWidget {
  var data;
  dispatchPage(this.data);

  @override
  _dispatchPageState createState() => _dispatchPageState();
}

class _dispatchPageState extends State<dispatchPage> {
  bool _isLoading = true;
  bool _isLoadingLink = false;
  //var data = [false,false,false,false];
  TextEditingController _controller = TextEditingController();
  var _id = "";
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  var data = [];
  var _invoiceId ="";
  var _estimateId ="";

  @override
  Future<void> initState()  {
    _id = widget.data['customer_id'];
    _estimateId = widget.data['_id'];
    initApi();
  }

  Future<void> ApiCalling() async {

    if(_controller.text.isEmpty){
      show("Enter AWB number",context,red);
    }else{
      setState(() {
        _isLoadingLink = true;
      });
      var map;
      map  = {
        "est_proof_status":"Dispatched",
        "est_awb_number":_controller.text,
        "est_invoice_id":_invoiceId
      };
      Map<String, dynamic> _responseMap = await _contactRepository
          .estimateStatusChange(map, _estimateId)
      as Map<String, dynamic>;

      setState(() {
        _isLoadingLink = false;
      });
      show(_responseMap['message'],context,green);
      Navigator.pop(context);
    }

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

  void _linkBtnClicked(){
    if(_invoiceId.isEmpty){
      show("Please select invoice first",context,red);
    }else{
      _showDialog(context);
    }

  }

  void Selected(index){

    for(int i =0; i<data.length ; i++){
      if(i == index){
        data[i]['clicked'] = true;
        _invoiceId = data[i]['invoice_id'];
      }else{
        data[i]['clicked'] = false;
      }
      print("object "+i.toString()+' = '+index.toString());
    }
    print(data.toString());
    setState(() {
    });
  }
  _showDialog(context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context)
        {
          return new AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextField(
                    autofocus: true,
                    controller: _controller,
                    decoration: new InputDecoration(
                        labelText: 'AWB Number', hintText: 'Enter AWB Number'),
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('SUBMIT'),
                  onPressed: () {
                    Navigator.pop(context);
                    ApiCalling();
                  })
            ],
          );}
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Select Invoice",
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
          : Stack(
        children: [
          AnimationLimiter(
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
                                InvoiceCell(data[index],()=>Selected(index)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                itemCount: data.length,
                scrollDirection: Axis.vertical),
          ),
          Positioned(
              bottom: 0,right: 0,left: 0,
              child: RisedButtonuv(onTap: ()=>_linkBtnClicked(),title: "Link",color: Colors.lightGreen,loading: _isLoadingLink,))
        ],
      ));
  }
}
