import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/models/view_product/view_product_list_model.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/common_componets/common_text_field.dart';
import 'package:admin_web_app/utils/text_field_styles.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:admin_web_app/views/widgets/shimmer_table_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({Key? key}) : super(key: key);

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
            Text(
              "View Product",
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
                hintText: "Search Product By Name.....",
                prefixIcon: const Icon(Icons.manage_search_rounded),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() => (controller.isTableLoaderShow.value == Loader.Show.name)
                ? const ShimmerProductTableView()
                : Container(
                    decoration: const BoxDecoration(color: Clr.whiteColor),
                    child: Table(
                      border: TableBorder.all(width: .1, color: Clr.greyColor, borderRadius: BorderRadius.circular(5)),
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      columnWidths: const {
                        0: IntrinsicColumnWidth(flex: 1),
                        1: IntrinsicColumnWidth(flex: 2.5),
                        2: IntrinsicColumnWidth(flex: 2.5),
                        3: IntrinsicColumnWidth(flex: 5),
                        4: IntrinsicColumnWidth(flex: 2),
                        5: IntrinsicColumnWidth(flex: 3),
                        6: IntrinsicColumnWidth(flex: 2),
                        7: IntrinsicColumnWidth(flex: 3),
                      },
                      defaultColumnWidth: const FlexColumnWidth(),
                      children: [
                        TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text('In', style: CustomTextStyle.tableHeaderStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text('Product ID', style: CustomTextStyle.tableHeaderStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text('SKU', style: CustomTextStyle.tableHeaderStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text('Product Name', style: CustomTextStyle.tableHeaderStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text('Product Type', style: CustomTextStyle.tableHeaderStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text('Product Style', style: CustomTextStyle.tableHeaderStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text('Price', style: CustomTextStyle.tableHeaderStyle),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                              child: Text('Action', style: CustomTextStyle.tableHeaderStyle),
                            ),
                          ],
                          decoration: const BoxDecoration(color: Clr.tableHeaderGreyColor),
                        ),
                        for (VDatum element in (controller.viewProductListModel.value?.data ?? [])) ...[
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(
                                    '${(controller.viewProductListModel.value?.data?.indexOf(element) ?? 0) + 1}.',
                                    style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(element.id ?? "-",
                                    style: CustomTextStyle.tableContentStyle.copyWith(fontWeight: FontWeight.w600)),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(element.additionalDetails?.productSku ?? "-",
                                    style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(element.name ?? "-", style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(element.additionalDetails?.style ?? "-",
                                    style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(element.categoryId?.categoryName ?? "-",
                                    style: CustomTextStyle.tableContentStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(element.generalPrice?.toString() ?? "-",
                                    style: CustomTextStyle.tableContentStyle),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Tooltip(
                                        message: "View Product",
                                        child: InkWell(
                                          onTap: () {
                                            controller.onViewProductBtnTapped(jewelID: element.id ?? "");
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: .8, color: Clr.blueColor),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Icon(Icons.remove_red_eye_outlined,
                                                color: Clr.blueColor, size: 20),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Tooltip(
                                        message: "Make InWaiting",
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: .8, color: Clr.greyColor),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.cached_rounded, color: Clr.greyColor, size: 20),
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
                                          ),
                                          alignment: Alignment.center,
                                          child: const Icon(Icons.mode_edit_outline_outlined,
                                              color: Clr.amberColor, size: 20),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Tooltip(
                                        message: "Delete Product",
                                        child: InkWell(
                                          onTap: () {
                                            controller.onDeleteProductTapped(jewelID: element.id ?? "");
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                              border: Border.all(width: .8, color: Clr.redColor),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            alignment: Alignment.center,
                                            child: const Icon(Icons.delete_outline_outlined,
                                                color: Clr.redColor, size: 20),
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: controller.goToFirstElement,
                    splashRadius: 20,
                    icon: const Icon(Icons.keyboard_double_arrow_left),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: controller.onBackButtonTapped,
                    splashRadius: 20,
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  const SizedBox(width: 5),
                  Obx(() => SizedBox(
                        width: (controller.pageLength.value < 5) ? controller.pageLength.value * 60 : 290,
                        height: 45,
                        child: ScrollablePositionedList.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.pageLength.value,
                          itemScrollController: controller.itemScrollController,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 7),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: InkWell(
                                  onTap: () {
                                    controller.onElementTapped(index: index);
                                  },
                                  child: Obx(() => Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          color: (controller.selectedTableIndex.value == index)
                                              ? Clr.primaryColor
                                              : Clr.transparentColor,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          (index + 1).toString(),
                                          style: CustomTextStyle.tableHeaderStyle.copyWith(
                                              color: (controller.selectedTableIndex.value == index)
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
                    onPressed: controller.onNextButtonTapped,
                    splashRadius: 20,
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: controller.goToLastElement,
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
