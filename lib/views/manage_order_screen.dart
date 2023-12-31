import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/common_componets/hover_button.dart';
import 'package:admin_web_app/utils/text_field_styles.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:admin_web_app/views/widgets/debug_banner.dart';
import 'package:admin_web_app/views/widgets/shimmer_order_table_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';

class ManageOrderScreen extends StatelessWidget {
  const ManageOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IndexController controller = Get.find<IndexController>();

    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            STxt(
              txt: "Manage Orders",
              style: CustomTextStyle.screenHeadingStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: .8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Clr.greyColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 30),
            CommonTextField(
              decoration: CustomTextFieldStyle.normalFieldDecoration.copyWith(
                hintText: "Search Orders Here.....",
                prefixIcon: const Icon(Icons.manage_search_rounded),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() => (controller.isOrderTableLoaderShow.value == Loader.Show.name)
                ? const ShimmerOrderTableView()
                : Container(
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

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: '${i + 1}.', style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(
                                    txt: 'BNGJOR1647-GW4',
                                    style: CustomTextStyle.tableContentStyle.copyWith(fontWeight: FontWeight.w600)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: 'Test Dev', style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: 'BNGJOR1647-GW4', style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(
                                    txt: "Diamond Pave Crossover Fashion Band",
                                    style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: "Bracelet", style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: 'BNGJOR1647-GW4', style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: 'BNGJOR1647-GW4', style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: 'Surat, Gujarat, India.', style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: '01-08-2024\n12:30 PM', style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: STxt(txt: '\$120', style: CustomTextStyle.tableContentStyle),
                              ),
                              (i % 2 == 0)
                                  ? const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                      child: Chip(
                                        label: STxt(
                                            txt: 'Refunded',
                                            style: TextStyle(
                                                fontSize: 12, fontWeight: FontWeight.w500, color: Clr.whiteColor)),
                                        backgroundColor: Clr.orangeColor,
                                      ),
                                    )
                                  : (i % 3 == 0)
                                      ? const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                          child: Chip(
                                            label: STxt(
                                                txt: 'Canceled',
                                                style: TextStyle(
                                                    fontSize: 12, fontWeight: FontWeight.w500, color: Clr.whiteColor)),
                                            backgroundColor: Clr.greyColor,
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                          child: Chip(
                                            label: STxt(
                                                txt: 'Paid',
                                                style: TextStyle(
                                                    fontSize: 12, fontWeight: FontWeight.w500, color: Clr.whiteColor)),
                                            backgroundColor: Clr.greenColor,
                                          ),
                                        ),
                              Center(
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
                                          child:
                                              const Icon(Icons.remove_red_eye_outlined, color: Clr.blueColor, size: 20),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Tooltip(
                                        message: "Cancel Order",
                                        child: InkWell(
                                          onTap: () {
                                            controller.onCancelOrderTapped();
                                          },
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
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]
                      ],
                    ),
                  )),
            const SizedBox(height: 30),
            Center(
              child: DebugBanner(
                child: HoverButton(
                  btnText: "Show/Hide Loader",
                  callback: () {
                    if (controller.isOrderTableLoaderShow.value == Loader.Show.name) {
                      controller.hideOrderTBLoader();
                    } else {
                      controller.showOrderTBLoader();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      controller.goToFirstElement(
                        selectedTableIndex: controller.selectedProductTableIndex,
                        itemScrollController: controller.productItemScrollController,
                        onIndexChanged: (index) {
                          controller.getProductList(pageIndex: index);
                        },
                      );
                    },
                    splashRadius: 20,
                    icon: const Icon(Icons.keyboard_double_arrow_left),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      controller.onBackButtonTapped(
                        selectedTableIndex: controller.selectedProductTableIndex,
                        itemScrollController: controller.productItemScrollController,
                        pageLength: controller.productPageLength,
                        onIndexChanged: (index) {
                          controller.getProductList(pageIndex: index);
                        },
                      );
                    },
                    splashRadius: 20,
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  const SizedBox(width: 5),
                  Obx(() => SizedBox(
                        width: (controller.productPageLength.value < 5) ? controller.productPageLength.value * 60 : 290,
                        height: 45,
                        child: ScrollablePositionedList.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.productPageLength.value,
                          itemScrollController: controller.productItemScrollController,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: InkWell(
                                  onTap: () {
                                    controller.onElementTapped(
                                      index: index,
                                      selectedTableIndex: controller.selectedProductTableIndex,
                                      onIndexChanged: (index) {
                                        controller.getProductList(pageIndex: index);
                                      },
                                    );
                                  },
                                  child: Obx(() => Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: (controller.selectedProductTableIndex.value == index)
                                              ? Clr.primaryColor
                                              : Clr.transparentColor,
                                        ),
                                        alignment: Alignment.center,
                                        child: STxt(
                                          txt: (index + 1).toString(),
                                          style: CustomTextStyle.tableHeaderStyle.copyWith(
                                              color: (controller.selectedProductTableIndex.value == index)
                                                  ? Clr.whiteColor
                                                  : Clr.blackColor),
                                        ),
                                      )),
                                ),
                              ),
                            );
                          },
                        ),
                      )),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      controller.onNextButtonTapped(
                        selectedTableIndex: controller.selectedProductTableIndex,
                        itemScrollController: controller.productItemScrollController,
                        pageLength: controller.productPageLength,
                        onIndexChanged: (index) {
                          controller.getProductList(pageIndex: index);
                        },
                      );
                    },
                    splashRadius: 20,
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      controller.goToLastElement(
                        selectedTableIndex: controller.selectedProductTableIndex,
                        itemScrollController: controller.productItemScrollController,
                        onIndexChanged: (index) {
                          controller.getProductList(pageIndex: index);
                        },
                        pageLength: controller.productPageLength,
                      );
                    },
                    splashRadius: 20,
                    icon: const Icon(Icons.keyboard_double_arrow_right),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
