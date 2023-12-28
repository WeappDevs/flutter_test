import 'dart:math';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';

class ShimmerProductTableView extends StatelessWidget {
  const ShimmerProductTableView({super.key});

  @override
  Widget build(BuildContext context) {
    //Shimmer only work with white color
    return Container(
      decoration: const BoxDecoration(color: Clr.whiteColor),
      child: Table(
        border: TableBorder.all(width: .1, color: Clr.greyColor, borderRadius: BorderRadius.circular(5)),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        columnWidths: const {
          0: IntrinsicColumnWidth(flex: 1),
          1: IntrinsicColumnWidth(flex: 2.5),
          2: IntrinsicColumnWidth(flex: 5),
          3: IntrinsicColumnWidth(flex: 2),
          4: IntrinsicColumnWidth(flex: 3),
          5: IntrinsicColumnWidth(flex: 2),
          6: IntrinsicColumnWidth(flex: 3),
        },
        defaultColumnWidth: const FlexColumnWidth(),
        children: [
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'In', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'SKU', style: CustomTextStyle.tableHeaderStyle),
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
                child: STxt(txt: 'Product Style', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Price', style: CustomTextStyle.tableHeaderStyle),
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: STxt(
                            txt:
                                '${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}',
                            style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, bottom: 10, left: 10),
                        child: STxt(
                            txt:
                                '${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}',
                            style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                      )
                    ],
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: '${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}',
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
                            '${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}${Random().nextInt(10000)}',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Clr.shimmerBaseClr,
                  highlightColor: Clr.shimmerHighlightClr,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: STxt(
                        txt: '${Random().nextInt(10000)}${Random().nextInt(10000)}',
                        style: CustomTextStyle.tableContentStyle.copyWith(backgroundColor: Clr.whiteColor)),
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
                            message: "View Product",
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                border: Border.all(width: .8, color: Clr.blueColor),
                                borderRadius: BorderRadius.circular(5),
                                // color: Clr.whiteColor,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.remove_red_eye_outlined, color: Clr.blueColor, size: 20),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Tooltip(
                            message: "Edit Product",
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                border: Border.all(width: .8, color: Clr.amberColor),
                                borderRadius: BorderRadius.circular(5),
                                // color: Clr.whiteColor,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.mode_edit_outline_outlined, color: Clr.amberColor, size: 20),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Tooltip(
                            message: "Delete Product",
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                border: Border.all(width: .8, color: Clr.redColor),
                                borderRadius: BorderRadius.circular(5),
                                // color: Clr.whiteColor,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.delete_outline_outlined, color: Clr.redColor, size: 20),
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
