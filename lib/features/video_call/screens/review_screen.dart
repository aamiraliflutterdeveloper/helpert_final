import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:helpert_app/common_widgets/components/custom_appbar.dart';
import 'package:helpert_app/constants/api_endpoints.dart';
import 'package:helpert_app/constants/app_colors.dart';
import 'package:helpert_app/features/video_call/bloc/review/review_bloc.dart';
import 'package:helpert_app/features/video_call/bloc/review/review_state.dart';

import '../../../utils/nav_router.dart';

class ReviewScreen extends StatefulWidget {
  final int doctorId;
  final int bookingId;
  final String doctorImage;
  final String doctorName;
  const ReviewScreen(
      {Key? key,
      required this.doctorImage,
      required this.doctorName,
      required this.doctorId,
      required this.bookingId})
      : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double selection = -1.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child:
            BlocConsumer<ReviewBloc, ReviewState>(listener: (context, state) {
          if (state is ReviewLoadingState) {
            BotToast.showLoading();
          }
          if (state is ReviewErrorState) {
            BotToast.closeAllLoading();
            BotToast.showText(text: state.message);
          }
          if (state is ReviewLoadedState) {
            BotToast.closeAllLoading();
            NavRouter.pushToRoot(context);
          }
        }, builder: (context, state) {
          return Container(
            height: 56,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: ElevatedButton(
              onPressed: () {
                ReviewBloc.get(context).bookingRating(
                    widget.doctorId, selection, widget.bookingId);
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: AppColors.acmeBlue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Text(
                state is ReviewErrorState ? 'Try Again' : 'Submit Review',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          );
        }),
      ),
      appBar: const CustomAppBar(
        title: 'Review',
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Center(
          child: Column(
            children: [
              widget.doctorImage.isEmpty
                  ? Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 4.17),
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/png/no_profile.png'),
                              fit: BoxFit.cover)),
                    )
                  : Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 4.17),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  '$VIDEO_BASE_URL${widget.doctorImage}'),
                              fit: BoxFit.cover)),
                    ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(
                    text: 'How was your experience with \n',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                TextSpan(
                    text: widget.doctorName,
                    style: const TextStyle(
                        height: 2,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.acmeBlue)),
              ])),
              SizedBox(
                height: 40,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, selected) => Icon(
                    selection > selected
                        ? Icons.star
                        : Icons.star_border_outlined,
                    color: AppColors.warning,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      selection = rating;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
