import 'package:bwc/constant/constants.dart';
import 'package:bwc/datasource/fitness_data_source.dart';
import 'package:bwc/repositories/fitness_repository.dart';
import 'package:bwc/ui/pages/ClassicWebBrowserPage.dart';
import 'package:bwc/ui/pages/CreateEstimateCustomer.dart';
import 'package:bwc/ui/widgets/EstimateCell.dart';
import 'package:bwc/ui/widgets/EstimateCellAdmin.dart';
import 'package:bwc/ui/widgets/EstimateCellWithOutAccept.dart';
import 'package:bwc/ui/widgets/Loader.dart';
import 'package:bwc/ui/widgets/My_Drawer.dart';
import 'package:bwc/ui/widgets/NoData.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:bwc/ui/widgets/appIcon.dart';
import 'package:bwc/ui/widgets/margin.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class EstimatesAdmin extends StatefulWidget {
  bool direct;
  String cId;


  EstimatesAdmin(this.direct, {this.cId});

  @override
  _EstimatesAdminState createState() => _EstimatesAdminState();
}

class _EstimatesAdminState extends State<EstimatesAdmin> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _wSellerArray = [];
  int page = 1;
  bool _isLoading = true;
  bool _isLoadingcontent = false;
  bool dataFinish = false;
  int tab = 1;
  ContactRepository _contactRepository = ContactRepository(ContactDataSource());

  void _tab(i){
    setState(() {
      tab = i;
      _isLoading = true;
    });
    if(tab == 1){
      initiApi("Pending");
    }else if(tab == 2){
      initiApi("Approved");
    }else if(tab == 3){
      initiApi("Dispatched");
    }else if(tab == 4){
      initiApi("Rejected");
    }

  }
  Future _loadMore() async {
    if (dataFinish == false && _wSellerArray.length > 9) {
      setState(() {
        _isLoadingcontent = true;
      });
      await new Future.delayed(new Duration(seconds: 2));
      page = page + 1;
      var map;
      if(widget.direct){
        if(tab == 1){
          map = {"page": "$page", "est_proof_status": "Pending"};

        }else if(tab == 2){
          map = {"page": "$page", "est_proof_status": "Approved"};

        }else if(tab == 3){
          map = {"page": "$page", "est_proof_status": "Dispatched"};

        }else if(tab == 4){
          map = {"page": "$page", "est_proof_status": "Rejected"};

        }
      }else{
        if(tab == 1){
          map = {"page": "$page", "est_proof_status": "Pending", "usr_customer_id": "${widget.cId}"};

        }else if(tab == 2){
          map = {"page": "$page", "est_proof_status": "Approved", "usr_customer_id": "${widget.cId}"};

        }else if(tab == 3){
          map = {"page": "$page", "est_proof_status": "Dispatched", "usr_customer_id": "${widget.cId}"};

        }else if(tab == 4){
          map = {"page": "$page", "est_proof_status": "Rejected", "usr_customer_id": "${widget.cId}"};

        }
      }

      //var map = {"page": "$page"};
      Map<String, dynamic> _responseMap = await _contactRepository
          .estimateListForUser(map) as Map<String, dynamic>;
      if (_responseMap["data"].length > 0) {
        setState(() {
          _wSellerArray.addAll(_responseMap['data']);
          _isLoadingcontent = false;
        });
      } else {
        setState(() {
          _isLoadingcontent = false;
          dataFinish = true;
        });
      }
    }
  }
  @override
  void dispose() {
    super.dispose();
    /// remove all receivers from the environment
    FBroadcast.instance().unregister(this);
  }
  Future<void> initiApi(status) async {
    if(widget.direct){
      var map = {"page": "$page", "est_proof_status": status};
      Map<String, dynamic> _responseMap = await _contactRepository
          .estimateListForUser(map) as Map<String, dynamic>;

      setState(() {
        _wSellerArray = _responseMap['data'];
        _isLoading = false;
      });
    }else{
      var map = {"page": "$page", "est_proof_status": status, "usr_customer_id": "${widget.cId}"};
      Map<String, dynamic> _responseMap = await _contactRepository
          .estimateListForUser(map) as Map<String, dynamic>;

      setState(() {
        _wSellerArray = _responseMap['data'];
        _isLoading = false;
      });
    }

  }
  Future<void> initiApinormal() async {
    if(tab == 1){
      initiApi("Pending");
    }else if(tab == 2){
      initiApi("Approved");
    }else if(tab == 3){
      initiApi("Dispatched");
    }else if(tab == 4){
      initiApi("Rejected");
    }

  }
  @override
  Widget build(BuildContext context) {
    FBroadcast.instance().register(
      "Key_Color",
          (value, callback) {
        /// refresh ui
            if(tab == 1){
              initiApi("Pending");
            }else if(tab == 2){
              initiApi("Approved");
            }else if(tab == 3){
              initiApi("Dispatched");
            }else if(tab == 4){
              initiApi("Rejected");
            }
      },
      /// bind context
      context: this,
    );
    return FocusDetector(
      onFocusGained: () {
        if(tab == 1){
          initiApi("Pending");
        }else if(tab == 2){
          initiApi("Approved");
        }else if(tab == 3){
          initiApi("Dispatched");
        }else if(tab == 4){
          initiApi("Rejected");
        }
      },
      child: Scaffold(
          key: _scaffoldKey,
          drawer: My_Drawer(),
          appBar: AppBar(
            title: Text("Estimate",
                style: TextStyle(
                    color: appSecondColor, fontWeight: FontWeight.w800)),
            leading: (widget.direct)?GestureDetector(
              onTap: () => _scaffoldKey.currentState.openDrawer(),
              child: Container(
                width: 20,
                height: 20,
                child: appIcon(iconData: Icons.menu),
              ),
            ):GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 20,
                height: 20,
                child: appIcon(iconData: Icons.arrow_back),
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis. horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Margin(
                      right: 5,
                      left: 5,
                      top: 5,
                      bottom: 5,
                      child: _card(1,"Pending"),
                    ),
                    Margin(
                      right: 5,
                      top: 5,
                      bottom: 5,
                      child:  _card(2,"Accepted"),
                    ),
                    Margin(
                      right: 5,
                      top: 5,
                      bottom: 5,
                      child:  _card(3,"Dispatched"),
                    ),
                    Margin(
                      right: 5,
                      top: 5,
                      bottom: 5,
                      child:  _card(4,"Rejected"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: (_isLoading)
                    ? Loader()
                    : (_wSellerArray.length == 0)
                    ? NoData(): Column(
                  children: [
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (!_isLoadingcontent &&
                              scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                            _loadMore();
                          }
                        },
                        child: AnimationLimiter(
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
                                              GestureDetector(
                                                onTap: ()=>
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                                      return ClassicWebBrowserPage(url:_wSellerArray[index]['est_url'],fromEstimate: true);
                                                    })),
                                                child: EstimatesCellAdmin(
                                                    wSellerArray:
                                                    _wSellerArray[index],
                                                    i: index,apiReload: initiApinormal),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              itemCount: _wSellerArray.length,
                              scrollDirection: Axis.vertical),
                        ),
                      ),
                    ),
                    (_isLoadingcontent)?Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                          child: SpinKitFadingCircle(
                            color: appSecondColor,
                          )),
                    ):SizedBox(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
  Widget _card(i,title){
    return GestureDetector(
      onTap: ()=>_tab(i),
      child: Card(
        elevation: 8,
        color: (tab == i) ? appSecondColor : Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 13,color: (tab == i) ? Colors.white:appSecondColor),
            ),
          ),
        ),
      ),
    );
  }
}
