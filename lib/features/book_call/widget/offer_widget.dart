import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/components/text_view.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/asset_paths.dart';

import '../../../constants/consts.dart';
import '../../../constants/text_styles.dart';

class OfferWidget extends StatelessWidget {
  final String text;
  const OfferWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgImage(path: ic_check),
        SizedBox(
          width: 12,
        ),
        TextView(
          text,
          textStyle: TextStyles.regularTextStyle(
            fontSize: 16,
            fontFamily: proximaFamily,
            textColor: Color(0xFF1D1E20),
          ),
        ),
      ],
    );
  }
}
