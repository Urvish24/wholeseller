import 'package:bwc/constant/constants.dart';
import 'package:bwc/ui/pages/ClassicWebBrowserPage.dart';
import 'package:bwc/ui/widgets/Toast.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class ItemsCellCustomer extends StatelessWidget {
  var data;

  ItemsCellCustomer(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                onTap: () => (data['invoice_url'] != null)
                    ? Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                        return ClassicWebBrowserPage(url: data['invoice_url'],fromEstimate: false);
                      }))
                    : show("Can't get invoice url", context, red))
          ],
        ),
      ),
    );
  }
}
