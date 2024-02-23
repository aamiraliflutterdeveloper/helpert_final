import 'package:flutter/material.dart';
import 'package:helpert_app/common_widgets/bottons/elevated_button_without_icon.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/text_styles.dart';

class CustomAlertDialog extends StatefulWidget {
  final String title;
  final VoidCallback noPressed;
  final VoidCallback yesPressed;
  const CustomAlertDialog(
      {Key? key,
      required this.title,
      required this.noPressed,
      required this.yesPressed})
      : super(key: key);

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(widget.title, style: TextStyles.regularTextStyle()),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButtonWithoutIcon(
                        primaryColor: AppColors.pureWhite,
                        borderColor: AppColors.moon,
                        textColor: AppColors.black,
                        height: 45,
                        text: 'No',
                        onPressed: widget.noPressed)),
                SizedBox(width: 20),
                Expanded(
                    child: ElevatedButtonWithoutIcon(
                        primaryColor: AppColors.failure,
                        borderColor: AppColors.failure,
                        height: 45,
                        text: 'Yes',
                        onPressed: widget.yesPressed)),
              ],
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
