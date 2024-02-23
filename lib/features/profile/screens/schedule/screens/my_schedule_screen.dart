import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/elevated_button_without_icon.dart';
import 'package:helpert_app/common_widgets/custom_dialog.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/profile/bloc/add_slot_bloc.dart';
import 'package:helpert_app/features/profile/bloc/add_slot_state.dart';
import 'package:helpert_app/features/profile/bloc/profile_bloc.dart';
import 'package:helpert_app/features/profile/bloc/profile_state.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';
import 'package:helpert_app/features/profile/screens/schedule/widgets/unavailable_days_tile.dart';
import 'package:helpert_app/utils/nav_router.dart';

import '../../../../../common_widgets/components/custom_appbar.dart';
import '../../../../../common_widgets/components/custom_tabbar.dart';
import '../../../../../constants/app_colors.dart';
import '../widgets/days_availability_tile.dart';

class MyScheduleScreen extends StatefulWidget {
  const MyScheduleScreen({Key? key}) : super(key: key);

  @override
  State<MyScheduleScreen> createState() => _MyScheduleScreenState();
}

class _MyScheduleScreenState extends State<MyScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().fetchSlotDays();
    _controller = TabController(length: 2, vsync: this);
  }

  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  bool status = true;
  bool somethingChanged = false;
  List<DaysModel> days = [];
  List<int> dayIds = [];

  List<Map<String, dynamic>> unavailableDateMapList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.pureWhite,
      appBar: const CustomAppBar(
        title: 'Set Time Availability',
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
        if (state is ProfileError) {
          BotToast.closeAllLoading();
          BotToast.showText(text: state.error);
        }
      }, builder: (context, state) {
        return state is ProfileLoaded
            ? state.daysListModel == null ||
                    state.unavailableDateListModel == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    bottom: true,
                    top: false,
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                            "Select the day and time, when you can accept appointments",
                            textAlign: TextAlign.center,
                            style: TextStyles.mediumTextStyle(
                                fontSize: 11, textColor: AppColors.moon)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: CustomTabBar(
                            controller: _controller,
                            tabs: const ['Availability', 'Unavailability'],
                            onTap: (index) {},
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: AppColors.pureWhite,
                            child: TabBarView(
                              physics: const BouncingScrollPhysics(),
                              controller: _controller,
                              children: [
                                ListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 16),
                                  itemCount: state.daysListModel!.days.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return DaysAvailabilityTile(
                                      toggleCallBack: () {
                                        somethingChanged = true;
                                        days = state.daysListModel!.days;
                                        // if (dayIds.contains(
                                        //     state.daysListModel!.days[index].dayId)) {
                                        // } else {
                                        //   dayIds.add(
                                        //       state.daysListModel!.days[index].dayId);
                                        //
                                        //   days.add(state.daysListModel!.days[index]);
                                        // }
                                      },
                                      days: state.daysListModel!,
                                      dayIndex: index,
                                      dayValue: state.daysListModel!.days[index]
                                              .status !=
                                          0,
                                      day:
                                          state.daysListModel!.days[index].name,
                                      timeSlots: state
                                          .daysListModel!.days[index].slots,
                                      callBack: (data) {
                                        somethingChanged = true;
                                        days = state.daysListModel!.days;
                                        // if (dayIds.contains(
                                        //     state.daysListModel!.days[index].dayId)) {
                                        // } else {
                                        //   dayIds.add(
                                        //       state.daysListModel!.days[index].dayId);
                                        //
                                        //   days.add(state.daysListModel!.days[index]);
                                        // }
                                      },
                                    );
                                  },
                                ),
                                SingleChildScrollView(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24.0, horizontal: 16),
                                  child: UnAvailableDaysTile(
                                    unavailableDateListModel:
                                        state.unavailableDateListModel!,
                                    callBack: (unavailableDates) {
                                      somethingChanged = true;
                                      unavailableDateMapList.clear();
                                      for (var element in unavailableDates) {
                                        unavailableDateMapList.add({
                                          "start_date": element.startDate,
                                          "end_date": element.endDate
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: BlocConsumer<AddSlotsBloc, AddSlotsState>(
                                listener: (context, state) {
                              if (state is AddSlotLoading) {
                                BotToast.showLoading();
                              } else if (state is AddSlotError) {
                                BotToast.closeAllLoading();
                                BotToast.showText(text: state.error);
                              } else if (state is AddSlotLoaded) {
                                BotToast.closeAllLoading();
                                context
                                    .read<ProfileBloc>()
                                    .fetchProfile(loading: false);
                                NavRouter.pop(context);
                              }
                            }, builder: (context, state) {
                              return ElevatedButtonWithoutIcon(
                                text: 'Save',
                                onPressed: () {
                                  if (_controller.index == 0) {
                                    if (somethingChanged) {
                                      bool slotsEmptyError = false;
                                      List<Map<String, dynamic>> mapData = [];
                                      for (var day in days) {
                                        List<int> slotIds = [];
                                        day.slots
                                            .where((element) =>
                                                element.status == 1)
                                            .forEach((slot) {
                                          slotIds.add(slot.slotId);
                                        });
                                        if (day.status == 1) {
                                          if (slotIds.isNotEmpty) {
                                            mapData.add({
                                              'day_id': day.dayId,
                                              'slot_id': slotIds,
                                            });
                                          } else {
                                            slotsEmptyError = true;
                                            CustomDialogs.showDayNotAvailableDialog(
                                                context,
                                                'Please select at least one slot against ${day.name}',
                                                'OK', onOkSelection: () {
                                              NavRouter.pop(context);
                                            });
                                          }
                                        }
                                      }
                                      if (!slotsEmptyError) {
                                        context
                                            .read<AddSlotsBloc>()
                                            .addDaySlots(mapData);
                                      }
                                    } else {
                                      NavRouter.pop(context);
                                    }
                                  } else {
                                    context
                                        .read<AddSlotsBloc>()
                                        .addUnAvailableDays(
                                            unavailableDateMapList);
                                  }
                                },
                                height: 55,
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                  )
            : state is ProfileLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Text('No Data Found'),
                  );
      }),
    );
  }
}
