import 'package:admin_web_app/controllers/index_controller.dart';
import 'package:admin_web_app/models/add_product/category_list_model.dart';
import 'package:admin_web_app/utils/colors.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/utils/validate.dart';
import 'package:admin_web_app/views/widgets/empty_view.dart';
import 'package:admin_web_app/views/widgets/shimmer_cat_table_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverseeCategoryScreen extends StatelessWidget {
  const OverseeCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IndexController controller = Get.find<IndexController>();

    return SelectionArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Oversee Category",
                style: CustomTextStyle.screenHeadingStyle,
              ),
              IconButton(
                onPressed: () {
                  controller.onAddEditCategoryBtnTapped();
                },
                splashRadius: 30,
                tooltip: "Add Category",
                icon: const Icon(Icons.add_box_rounded),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: .8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Clr.greyColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 30),
          Obx(() => (controller.isTableLoaderShow.value == Loader.Show.name)
              ? const ShimmerCatTableView()
              : (controller.categoryListModel.value?.data?.isNotEmpty ?? false)
                  ? Container(
                      decoration: const BoxDecoration(color: Clr.whiteColor),
                      child: Table(
                        border:
                            TableBorder.all(width: .1, color: Clr.greyColor, borderRadius: BorderRadius.circular(5)),
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
                                child: Text('In', style: CustomTextStyle.tableHeaderStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text('Category Image', style: CustomTextStyle.tableHeaderStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text('Category Name', style: CustomTextStyle.tableHeaderStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text('Category ID', style: CustomTextStyle.tableHeaderStyle),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text('Action', style: CustomTextStyle.tableHeaderStyle),
                              ),
                            ],
                            decoration: const BoxDecoration(color: Clr.tableHeaderGreyColor),
                          ),
                          for (CtDatum element in (controller.categoryListModel.value?.data ?? [])) ...[
                            TableRow(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Text(
                                      '${(controller.categoryListModel.value?.data?.indexOf(element) ?? 0) + 1}.',
                                      style: CustomTextStyle.tableContentStyle),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover, image: NetworkImage(element.categoryImage ?? ''))),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Text(element.categoryName ?? '-', style: CustomTextStyle.tableContentStyle),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                  child: Text(element.id ?? '-',
                                      style: CustomTextStyle.tableContentStyle.copyWith(fontWeight: FontWeight.w600)),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Tooltip(
                                          message: "Edit Category",
                                          child: InkWell(
                                            onTap: () {
                                              controller.onAddEditCategoryBtnTapped(element: element);
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                border: Border.all(width: .8, color: Clr.blueColor),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              child: const Icon(Icons.mode_edit_outline_outlined,
                                                  color: Clr.blueColor, size: 20),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Tooltip(
                                          message: "Delete Category",
                                          child: InkWell(
                                            onTap: () {
                                              controller.onDeleteCategoryTapped(categoryID: element.id ?? "");
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
                    )
                  : const EmptyView(emptyText: "No Category Available")),
          const SizedBox(height: 30),
        ],
      ),
    ));
  }
}
