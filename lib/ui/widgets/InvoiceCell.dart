import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/ClassicWebBrowserPage.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class InvoiceCell extends StatelessWidget {
  var data;
  GestureTapCallback fuc;

  InvoiceCell(this.data, this.fuc);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fuc,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: (data['clicked'] == true)
                              ? appSecondColor
                              : Colors.black,
                          width: (data['clicked'] == true) ? 8 : 2),
                      borderRadius: BorderRadius.all(Radius.circular(
                              13.0) //                 <--- border radius here
                          ),
                    ),
                    child: Center(
                        child: SizedBox(
                      height: 13,
                      width: 13,
                    )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data['customer_name'],
                            style: list_title,
                          ),
                          Text(data['invoice_number'], style: list_titleblack),
                        ],
                      ),
                      sizedBoxUv,
                      Container(
                        height: 1,
                        color: appSecondColor,
                      ),
                      sizedBoxUv,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹' + data['total'].toString(),
                            style: list_titleblack,
                          ),
                          Text(
                            data['date'],
                            style: list_normal,
                          ),
                        ],
                      ),
                    ],
                  ))
                ],
              ),
              RisedButtonuv(
                  title: 'View Invoice',
                  onTap: () => {
                        (data['invoice_url'] != null)
                            ? Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                                return ClassicWebBrowserPage(
                                    url: data['invoice_url'],fromEstimate: false);
                              }))
                            : show("Can't get invoice url", context, red)
                      })
            ],
          ),
        ),
      ),
    );
  }
}
