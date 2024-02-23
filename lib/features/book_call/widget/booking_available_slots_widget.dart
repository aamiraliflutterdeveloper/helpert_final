import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/profile/models/slot_days_model.dart';

import '../../../constants/consts.dart';
import '../../profile/screens/schedule/widgets/time_slot_widget.dart';
import '../bloc/available_slots_bloc.dart';
import '../bloc/available_slots_state.dart';

class BookingAvailableSlotsWidget extends StatefulWidget {
  final Function(SlotModel, DaysModel) callback;
  const BookingAvailableSlotsWidget({Key? key, required this.callback})
      : super(key: key);

  @override
  State<BookingAvailableSlotsWidget> createState() =>
      _BookingAvailableSlotsWidgetState();
}

class _BookingAvailableSlotsWidgetState
    extends State<BookingAvailableSlotsWidget> {
  int selectedIndex = -1;
  int selectedSlot = -1;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvailableSlotsBloc, AvailableSlotsState>(
        listener: (context, state) {
      if (state is AvailableSlotError) {
        BotToast.closeAllLoading();
        if (state.error.trim() != "There is  No slot Available") {
          BotToast.showText(text: state.error);
        }
      }
    }, builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Time slots',
              textAlign: TextAlign.start,
              style: TextStyles.regularTextStyle(
                fontSize: 15,
                fontFamily: proximaFamily,
                textColor: Color(0xFF222B45),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            state is AvailableSlotLoaded
                ? state.dayModel.slots.isNotEmpty
                    ? SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.dayModel.slots.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 50,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.3),
                          itemBuilder: (context, index) {
                            return TimeSlotWidget(
                              title: SlotModel(
                                  slotId: state.dayModel.slots[index].slotId,
                                  slotTime:
                                      state.dayModel.slots[index].slotTime,
                                  status: selectedSlot == index ? 1 : 0,
                                  bookingStatus: state
                                      .dayModel.slots[index].bookingStatus),
                              onTap: (value) {
                                widget.callback(state.dayModel.slots[index],
                                    state.dayModel);
                                setState(() {
                                  selectedSlot = index;
                                });
                              },
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('No slot available yet'),
                        ),
                      )
                : state is AvailableSlotLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('No slot available yet'),
                        ),
                      ),
          ],
        ),
      );
    });
  }
}
