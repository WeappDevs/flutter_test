import 'package:admin_web_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';

class NestedRowBuilder extends StatelessWidget {
  final Map<String, dynamic> data;
  const NestedRowBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.entries.expand((element) {
        // debugPrint(element.value.runtimeType.toString());
        return

            ///Map
            (element.value is Map)
                ? [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: STxt(
                                txt: "${element.key.replaceAll("_", " ").toString().trimLeft().capitalize} (Map)",
                                style: const TextStyle(color: Clr.greyColor),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 9,
                              child: NestedRowBuilder(data: element.value),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                :

                ///List
                (element.value is List)
                    ? [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: STxt(
                                    txt:
                                        "${element.key.replaceAll("_", " ").toString().trimLeft().capitalize} (List_${element.value.length})",
                                    style: const TextStyle(color: Clr.greyColor),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 9,
                                  child: (element.value.length != 0)
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: List.generate(
                                              element.value.length,
                                              (index) => (element.value[index].runtimeType == String)
                                                  ? STxt(txt: element.value[index] ?? "-")
                                                  : NestedRowBuilder(data: element.value[index])),
                                        )
                                      : const STxt(txt: "-"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]

                    ///Normal String and Other data types
                    : [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: STxt(
                                    txt: element.key.replaceAll("_", " ").toString().trimLeft().capitalize.toString(),
                                    style: const TextStyle(color: Clr.greyColor),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 9,
                                  child: STxt(txt: element.value?.toString() ?? "-"),
                                ),
                              ],
                            ),
                          ),
                        )
                      ];
      }).toList(),
    );
  }
}
