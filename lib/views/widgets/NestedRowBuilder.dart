import 'package:admin_web_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NestedRowBuilder extends StatelessWidget {
  final Map<String, dynamic> data;
  const NestedRowBuilder({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.entries.expand((element) {
        return (element.value is Map)
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
                    child: Text(
                      element.key.replaceAll("_", " ").toString().trimLeft().capitalize.toString(),
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
                    child: Text(
                      element.key.replaceAll("_", " ").toString().trimLeft().capitalize.toString(),
                      style: const TextStyle(color: Clr.greyColor),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 9,
                    child: Text(element.value?.toString() ?? "-"),
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
