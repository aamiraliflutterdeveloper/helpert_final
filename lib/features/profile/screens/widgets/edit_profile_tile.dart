import 'package:flutter/material.dart';

import '../../../../common_widgets/fetch_svg.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/text_styles.dart';

class EditProfileTile extends StatefulWidget {
  const EditProfileTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon,
      required this.onTap})
      : super(key: key);
  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback onTap;

  @override
  State<EditProfileTile> createState() => _EditProfileTileState();
}

class _EditProfileTileState extends State<EditProfileTile> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        onTap: widget.onTap,
        leading: SizedBox(
            height: double.infinity,
            width: 30,
            child: Center(
              child: SvgImage(
                path: widget.icon,
                color: Color(0xFF86878B),
                width: 20,
                height: 20,
              ),
            )),
        title: Transform.translate(
          offset: Offset(-16, 0),
          child: Text(
            widget.title,
            style: TextStyles.mediumTextStyle(fontSize: 15),
          ),
        ),
        // subtitle: Text(
        //   subtitle,
        //   style: TextStyles.regularTextStyle(
        //     fontSize: 12,
        //     textColor: AppColors.moon,
        //   ).copyWith(fontWeight: FontWeight.w400),
        // ),
        trailing: widget.title.contains('Push')
            ? Transform.scale(
                scale: 1.1,
                child: Switch(
                    onChanged: (val) {
                      setState(() {
                        switchValue = val;
                      });
                    },
                    value: switchValue,
                    activeColor: AppColors.acmeBlue,
                    activeTrackColor: Colors.blue.shade100,
                    inactiveThumbColor: Colors.redAccent,
                    inactiveTrackColor: Colors.orange))
            : Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              ),
      ),
    );
  }
}
