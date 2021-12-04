import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/NoData.dart';
import 'package:bwc/ui/widgets/ReportCell.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:intl/intl.dart';

class ReportList extends StatefulWidget {
  const ReportList({Key key}) : super(key: key);

  @override
  _ReportListState createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  var _reportData = [];
  var _sallesData = [];
  var _salesId = "0";
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());
  var data = <DropdownMenuItem<int>>[];
  DateTime selectedStrDate = DateTime.now().subtract(Duration(days: 1));
  DateTime selectedEndDate = DateTime.now();
  int _value = 0;

  @override
  void initState() {
    _newInit();
  }
  Future<void> _newInit() async {
    Map<String, dynamic> _responseMapSeller =
        await _contactRepository.getSellesList() as Map<String, dynamic>;
    _sallesData = _responseMapSeller['data'];
    data = [];
    data.add(new DropdownMenuItem(
      child: new Text("All"),
      value: 0,
    ));
    for (int i = 0; i < _sallesData.length; i++) {
      data.add(new DropdownMenuItem(
        child: new Text(_sallesData[i]['usr_name']),
        value: i + 1,
      ));
    }
    setState(() {
      isLoading = false;
    });
    _showFilterDialog(context);
  }

  Future<void> initApi(map) async {
    Map<String, dynamic> _responseMap =
        await _contactRepository.fetchReports(map) as Map<String, dynamic>;

    setState(() {
      _reportData = _responseMap['data'];
      isLoading = false;
    });
  }

  void done() {
    if(selectedStrDate.isAfter(selectedEndDate)){
     show("Start date is bigger then end date",context,red);
    }else if(_salesId == "0"){
      Navigator.of(context).pop();
      setState(() {
        isLoading = true;
      });
      var map = {
        "start_date": DateFormat('yyyy-MM-dd').format(selectedStrDate),
        "end_date": DateFormat('yyyy-MM-dd').format(selectedEndDate)
      };
      print("data " + map.toString());
      initApi(map);
    }else{
      Navigator.of(context).pop();
      setState(() {
        isLoading = true;
      });
      var map = {
        "start_date": DateFormat('yyyy-MM-dd').format(selectedStrDate),
        "end_date": DateFormat('yyyy-MM-dd').format(selectedEndDate),
        "sales_id": _salesId
      };
      print("data " + map.toString());
      initApi(map);
    }

  }

  void _showdateDatePicker(context, fromStart, updateState) async {
    // selectedDate = DateTime.now();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedStrDate && fromStart)
      updateState(() {
        selectedStrDate = picked;
      });

    if (picked != null && picked != selectedEndDate && !fromStart)
      updateState(() {
        selectedEndDate = picked;
      });
  }

  _showFilterDialog(context) async {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter updateState) {
            return Container(
                height: 300,
                margin: EdgeInsets.only(top: 60),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child:
                    /*GestureDetector(
                  onTap: () => {
                    updateState(() {
                      text = ""+index.toString();
                    })},
                ),*/
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filter",
                            style: TextStyle(
                                fontSize: 20,
                                color: appSecondColor,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                            onTap: () => done(),
                            child: Text(
                              "Done",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w800),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Start Date",
                      style: TextStyle(
                          color: appSecondColor, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: () =>
                            _showdateDatePicker(context, true, updateState),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.only(left: 10),
                          width: double.infinity,
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(selectedStrDate),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1)),
                          height: 40,
                        )),
                    SizedBox(height: 8),
                    Text(
                      "End Date",
                      style: TextStyle(
                          color: appSecondColor, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                        onTap: () =>
                            _showdateDatePicker(context, false, updateState),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.only(left: 10),
                          width: double.infinity,
                          child: Center(
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(selectedEndDate),
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1)),
                          height: 40,
                        )),
                    SizedBox(height: 8),
                    Text(
                      "Saler",
                      style: TextStyle(
                          color: appSecondColor, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.only(left: 10),
                      width: double.infinity,
                      child: DropdownButton(
                        value: _value,
                        items: data,
                        onChanged: (int value) {
                          updateState(() {
                            _value = value;
                            _salesId = (value != 0)? _sallesData[value - 1]['_id']:"0";
                          });
                        },
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                                  5.0) //                 <--- border radius here
                              ),
                          border: Border.all(
                              color: Colors.black.withOpacity(0.5), width: 1)),
                      height: 40,
                    ),
                  ],
                ));
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: My_Drawer(),
      appBar: AppBar(
        title: Text("Reports List",
            style:
                TextStyle(color: appSecondColor, fontWeight: FontWeight.w800)),
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Container(
            width: 20,
            height: 20,
            child: appIcon(iconData: Icons.menu),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => _showFilterDialog(context),
            child: Container(
                margin: EdgeInsets.only(right: 5),
                child: appIcon(iconData: Icons.filter_alt_outlined)),
          )
        ],
      ),
      body: isLoading
          ? Loader()
          : (_reportData.length == 0)
              ? NoData()
              : AnimationLimiter(
                  child: ListView.builder(
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 500),
                            child: SlideAnimation(
                              horizontalOffset: 500.0,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: ReportCell(
                                      wSellerArray: _reportData[index],
                                      i: index,sId: _salesId,),
                                ),
                              ),
                            ),
                          ),
                      itemCount: _reportData.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true),
                ),
    );
  }
}
