import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';

class ShimmerCatTableView extends StatelessWidget {
  const ShimmerCatTableView({super.key});

  @override
  Widget build(BuildContext context) {
    //Shimmer only work with white color
    return Container(
      decoration: const BoxDecoration(color: Clr.whiteColor),
      child: Table(
        border: TableBorder.all(width: .1, color: Clr.greyColor, borderRadius: BorderRadius.circular(5)),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: const {
          0: IntrinsicColumnWidth(flex: .5),
          1: IntrinsicColumnWidth(flex: 2),
          2: IntrinsicColumnWidth(flex: 2),
          3: IntrinsicColumnWidth(flex: 2),
          4: IntrinsicColumnWidth(flex: 3),
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
                child: STxt(txt: 'Category Image', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Category Name', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Category ID', style: CustomTextStyle.tableHeaderStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: STxt(txt: 'Action', style: CustomTextStyle.tableHeaderStyle),
              ),
            ],
            decoration: const BoxDecoration(color: Clr.tableHeaderGreyColor),
          ),
          for (int i = 0; i < 5; i++) ...[
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Shimmer.fromColors(
                        baseColor: Clr.shimmerBaseClr,
                        highlightColor: Clr.shimmerHighlightClr,
                        child: Container(
                          height: 50,
                          width: 50,
                          color: Clr.whiteColor,
                        ),
                      ),
                    ),
                  ],
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
                        style: CustomTextStyle.tableContentStyle
                            .copyWith(fontWeight: FontWeight.w600, backgroundColor: Clr.whiteColor)),
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
