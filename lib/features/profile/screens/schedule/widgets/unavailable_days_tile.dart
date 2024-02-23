import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/features/profile/models/unAvailAbleDateModel.dart';
import 'package:helpert_app/features/profile/screens/schedule/widgets/unavailable_date_widget.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/app_colors.dart';
import '../../../../../constants/text_styles.dart';
import '../../../../../utils/date_formatter.dart';

class UnAvailableDaysTile extends StatefulWidget {
  final UnavailableDateListModel unavailableDateListModel;
  final Function(List<UnavailableDateModel>) callBack;
  const UnAvailableDaysTile({
    Key? key,
    required this.callBack,
    required this.unavailableDateListModel,
  }) : super(key: key);

  @override
  State<UnAvailableDaysTile> createState() => _UnAvailableDaysTileState();
}

class _UnAvailableDaysTileState extends State<UnAvailableDaysTile> {
  List<UnavailableDateModel> returnedUnavailableDates = [];

  @override
  void initState() {
    returnedUnavailableDates
        .addAll(widget.unavailableDateListModel.unavailableDateList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: Container(
            margin: EdgeInsets.only(top: 6, bottom: 6, left: 2),
            decoration: BoxDecoration(
              color: AppColors.pureWhite,
              boxShadow: const [
                BoxShadow(
                  color: AppColors.snow,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 8), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 4,
                  height: 36,
                  decoration: BoxDecoration(
                      color: AppColors.acmeBlue,
                      borderRadius: BorderRadius.circular(16)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ExpansionTile(
                      childrenPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                      title: Text(
                        'Unavailable Days',
                        style: TextStyles.semiBoldTextStyle(),
                      ),
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ListView.builder(
                              //     physics: NeverScrollableScrollPhysics(),
                              //     itemCount: widget.unavailableDateListModel
                              //         .unavailableDateList.length,
                              //     shrinkWrap: true,
                              //     itemBuilder: (context, index) {
                              //       return UnAvailableWidget(
                              //         unavailableDateModel: widget
                              //             .unavailableDateListModel
                              //             .unavailableDateList[index],
                              //         deleteCallBack: () {
                              //           returnedUnavailableDates.removeAt(index);
                              //           widget.unavailableDateListModel
                              //               .unavailableDateList
                              //               .removeAt(index);
                              //           widget.callBack(widget
                              //               .unavailableDateListModel
                              //               .unavailableDateList);
                              //           setState(() {});
                              //         },
                              //       );
                              //     }),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: returnedUnavailableDates.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return UnAvailableWidget(
                                      unavailableDateModel:
                                          returnedUnavailableDates[index],
                                      deleteCallBack: () {
                                        returnedUnavailableDates
                                            .removeAt(index);
                                        widget.callBack(
                                          returnedUnavailableDates,
                                        );
                                        setState(() {});
                                      },
                                    );
                                  }),
                              SizedBox(
                                width: double.infinity,
                                height: 43,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: AppColors.acmeBlue, backgroundColor: Color(0xFFEEF4FF), shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        elevation: 0),
                                    onPressed: () {
                                      DateFormatter.pickDateDialog(context)
                                          .then((startDate) {
                                        if (startDate != null) {
                                          DateFormatter.pickDateDialog(context)
                                              .then((endDate) {
                                            if (endDate != null) {
                                              DateTime one =
                                                  DateFormat("dd-MM-yyyy")
                                                      .parse(startDate);
                                              DateTime two =
                                                  DateFormat("dd-MM-yyyy")
                                                      .parse(endDate);
                                              if (one.isAfter(two)) {
                                                BotToast.showText(
                                                    text:
                                                        'Start date should be before end date');
                                              } else {
                                                returnedUnavailableDates.add(
                                                    UnavailableDateModel(
                                                        startDate: startDate,
                                                        endDate: endDate));
                                                widget.callBack(
                                                    returnedUnavailableDates);
                                              }
                                              setState(() {});
                                            }
                                          });
                                        }
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 18,
                                        ),
                                        Text(
                                          'Add Dates',
                                          style: TextStyles.boldTextStyle(
                                              textColor: AppColors.acmeBlue,
                                              fontSize: 12),
                                        ),
                                      ],
                                    )),
                              )
                            ]),
                      ],
                      onExpansionChanged: (isOpened) {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
