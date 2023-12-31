import 'dart:math';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';

class ShimmerOrderTableView extends StatelessWidget {
  const ShimmerOrderTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Clr.whiteColor),
      child: Table(
        border: TableBorder.all(width: .1, color: Clr.greyColor, borderRadius: BorderRadius.circular(5)),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: const {
          0: IntrinsicColumnWidth(flex: .2),
          1: IntrinsicColumnWidth(flex: 1),
          2: IntrinsicColumnWidth(flex: 2),
          3: IntrinsicColumnWidth(flex: 1),
          4: IntrinsicColumnWidth(flex: 2),
          5: IntrinsicColumnWidth(flex: .5),
          6: IntrinsicColumnWidth(flex: 1),
          7: IntrinsicColumnWidth(flex: 1),
          8: IntrinsicColumnWidth(flex: 3),
          9: IntrinsicColumnWidth(flex: .7),
          10: IntrinsicColumnWidth(flex: .7),
          11: IntrinsicColumnWidth(flex: 1),
          12: IntrinsicColumnWidth(flex: 1),
        },
        defaultColumnWidth: const FlexColumnWidth(),
        children: [
          TableRow(
            children: [
              /*0=In, 1=Order ID, 2=Customer Name, 3=Customer ID, 4=Product Name, 5=Product Type, 6=Product ID, 7=S-Payment ID, 8=Location, 9=Date, 10=Price, 11=Status, 12=Action*/
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'In', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Order ID', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Customer Name', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Customer ID', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Product Name', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Product Type', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Product ID', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'S-Payment ID', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Location', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Date', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Price', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Status', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Action', style: CustomTextStyle.tableHeaderStyle),
              ),
            ],
            decoration: const BoxDecoration(color: Clr.tableHeaderGreyColor),
          ),
          for (int i = 0; i < 10; i++) ...[
            TableRow(
              children: [
                /*0=In, 1=Order ID, 2=Customer Name, 3=Customer ID, 4=Product Name, 5=Product Type, 6=Product ID, 7=S-Payment ID, 8=Location, 9=Date, 10=Price, 11=Status, 12=Action*/

                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: '${i + 1}.',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: 'BNGJOR1647-GW4',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: 'Test Dev',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: 'BNGJOR1647-GW4',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt:
                            '${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: "Bracelet",
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: 'BNGJOR1647-GW4',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: 'BNGJOR1647-GW4',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: 'Surat, Gujarat, India.',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: '01-08-2024\n12:30 PM',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: '\$120',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Chip(
                      label: STxt(
                          txt: 'Refunded',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Clr.whiteColor)),
                      backgroundColor: Clr.whiteColor,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Tooltip(
                            message: "View Order",
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                border: Border.all(width: .8, color: Clr.blueColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.remove_red_eye_outlined, color: Clr.blueColor, size: 20),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Tooltip(
                            message: "Cancel Order",
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                border: Border.all(width: .8, color: Clr.redColor),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.cancel_outlined, color: Clr.redColor, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]
        ],
      ),
    );
  }
}
