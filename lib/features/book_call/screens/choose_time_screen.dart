import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/custom_elevated_button.dart';
import 'package:helpert_app/common_widgets/custom_dialog.dart';
import 'package:helpert_app/common_widgets/fetch_svg.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/book_call/bloc/available_slots_bloc.dart';
import 'package:helpert_app/features/book_call/bloc/available_slots_state.dart';
import 'package:helpert_app/features/book_call/screens/subscribe_to_specialist_screen.dart';
import 'package:helpert_app/utils/nav_router.dart';
import 'package:intl/intl.dart';

class ChooseTimeScreen extends StatefulWidget {
  final String dayName;
  final DateTime date;
  final int doctorId;
  const ChooseTimeScreen(
      {Key? key,
      required this.dayName,
      required this.date,
      required this.doctorId})
      : super(key: key);

  @override
  State<ChooseTimeScreen> createState() => _ChooseTimeScreenState();
}

class _ChooseTimeScreenState extends State<ChooseTimeScreen> {
  int currentIndex = -1;

  @override
  void initState() {
    super.initState();
    debugPrint('${widget.date}');
    debugPrint('Choose time init');
    context
        .read<AvailableSlotsBloc>()
        .availableSlots(widget.doctorId, widget.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          splashRadius: 24,
          onPressed: () {
            NavRouter.pop(context);
          },
          icon: const SvgImage(
            path: ic_backbutton,
          ),
        ),
        elevation: 0,
        title: Column(
          children: [
            Text(
              widget.dayName,
              style: TextStyles.boldTextStyle(
                  fontSize: 16, textColor: AppColors.black),
            ),
            Text(
              DateFormat("MMMM dd, yyyy").format(widget.date),
              style: TextStyles.regularTextStyle(
                  fontSize: 16, textColor: AppColors.moon),
            ),
          ],
        ),
      ),
      body: BlocConsumer<AvailableSlotsBloc, AvailableSlotsState>(
          listener: (context, state) {
        if (state is AvailableSlotError) {
          BotToast.closeAllLoading();
          if (state.error.trim() != "There is  No slot Available") {
            BotToast.showText(text: state.error);
          }
        }
      }, builder: (context, state) {
        return state is AvailableSlotLoaded
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: 30, bottom: 6, left: 16, right: 16),
                    child: FadeInDown(
                      child: Text(
                        'Next available appointments',
                        style: TextStyles.regularTextStyle(
                          fontSize: 16,
                          textColor: AppColors.moon,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FadeInRight(
                      child: state.dayModel.slots.isNotEmpty
                          ? ListView.builder(
                              padding: EdgeInsets.only(
                                  bottom: 30, left: 16, right: 16, top: 6),
                              itemCount: state.dayModel.slots.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return TimeSelectionTile(
                                  sessionRate: state.dayModel.sessionRate!,
                                  doctorId: state.dayModel.userId!,
                                  dayId: state.dayModel.dayId,
                                  slotId: state.dayModel.slots[index].slotId,
                                  date: widget.date,
                                  isSelected: currentIndex == index,
                                  time: state.dayModel.slots[index].slotTime,
                                  onTap: () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                );
                              })
                          : Center(
                              child: FadeInDown(
                                child: Text(
                                  'No slot found',
                                  style: TextStyles.regularTextStyle(
                                    fontSize: 16,
                                    textColor: AppColors.moon,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              )
            : state is AvailableSlotLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text('No slot available yet'),
                  );
      }),
    );
  }
}

class TimeSelectionTile extends StatelessWidget {
  final int sessionRate;
  final String time;
  final int doctorId;
  final int slotId;
  final int dayId;
  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;
  const TimeSelectionTile({
    Key? key,
    required this.sessionRate,
    required this.time,
    this.isSelected = false,
    required this.onTap,
    required this.doctorId,
    required this.slotId,
    required this.dayId,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding:
                      EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 16),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: isSelected
                            ? AppColors.acmeBlue
                            : AppColors.pureWhite,
                        width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.silver.withOpacity(.4),
                        spreadRadius: 4,
                        blurRadius: 4,
                        offset: Offset(0, 8), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 30,
                            decoration: BoxDecoration(
                                color: AppColors.acmeBlue,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            time,
                            style: TextStyles.semiBoldTextStyle(fontSize: 18),
                          )
                        ],
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        child: isSelected
                            ? Center(
                                child: Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              ))
                            : SizedBox(),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? AppColors.success
                                : AppColors.silver),
                      )
                    ],
                  ),
                ),
              ),
              if (isSelected)
                SizedBox(
                  width: 16,
                ),
              if (isSelected)
                Expanded(
                  flex: 3,
                  child: FadeInRight(
                    child: CustomElevatedButton(
                      title: 'Confirm',
                      disable: false,
                      onTap: () {
                        CustomDialogs.showDialogWithTextField(
                                context,
                                'Agenda of Appointment',
                                'Write agenda of the appointment',
                                'Save')
                            .then((value) {
                          if (value.isNotEmpty) {
                            NavRouter.push(
                                context,
                                SubscribeToSpecialistScreen(
                                  appointmentDescription: value,
                                  sessionRate: sessionRate,
                                  date: date,
                                  doctorId: doctorId,
                                  dayId: dayId,
                                  slotId: slotId,
                                ));
                          }
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
