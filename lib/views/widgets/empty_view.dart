import 'package:admin_web_app/utils/assets.dart';
import 'package:admin_web_app/utils/text_styles.dart';
import 'package:admin_web_app/views/widgets/s_txt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyView extends StatelessWidget {
  final String? emptyText;
  const EmptyView({Key? key, this.emptyText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          SvgPicture.asset(LocalSVG.noDataIcon),
          const SizedBox(height: 10),
          STxt(
            txt: emptyText ?? "No Data Available.",
            style: CustomTextStyle.mediumGreyStyle,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
