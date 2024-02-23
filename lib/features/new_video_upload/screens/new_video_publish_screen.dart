import 'package:better_player/better_player.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/common_widgets/bottons/elevated_button_with_icon.dart';
import 'package:helpert_app/constants/asset_paths.dart';
import 'package:helpert_app/constants/text_styles.dart';
import 'package:helpert_app/features/new_video_upload/bloc/video_bloc.dart';
import 'package:helpert_app/features/new_video_upload/bloc/video_state.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:video_compress/video_compress.dart';

import '../../../common_widgets/textfield/custom_textformfield.dart';
import '../../../constants/app_colors.dart';
import '../../auth/models/user_model.dart';
import '../bloc/interest_bloc.dart';

class NewVideoPublishScreen extends StatefulWidget {
  final XFile videoFile;
  final MultipartFile? introThumbnail;

  const NewVideoPublishScreen(
      {Key? key, required this.videoFile, this.introThumbnail})
      : super(key: key);

  @override
  State<NewVideoPublishScreen> createState() => _NewVideoPublishScreenState();
}

class _NewVideoPublishScreenState extends State<NewVideoPublishScreen> {
  final descriptionController = TextEditingController();
  List<ListItem> interests = [];
  int selectedIndex = -1;

  late Subscription subscription;
  double? requiredData;
  BetterPlayerController? _betterPlayerController;
  BetterPlayerDataSource? _betterPlayerDataSource;
  BetterPlayerConfiguration? betterPlayerConfiguration;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    context.read<InterestBloc>().fetchAllInterest();
    interests = context.read<InterestBloc>().interests;
    betterPlayerConfiguration = BetterPlayerConfiguration(
        autoDispose: false,
        looping: true,
        autoPlay: false,
        aspectRatio: .45,
        allowedScreenSleep: false,
        handleLifecycle: true,
        eventListener: (value) {
          if (value.betterPlayerEventType == BetterPlayerEventType.play ||
              value.betterPlayerEventType ==
                  BetterPlayerEventType.bufferingStart) {
            isPlaying = true;
            setState(() {});
          } else if (value.betterPlayerEventType ==
                  BetterPlayerEventType.pause ||
              value.betterPlayerEventType == BetterPlayerEventType.finished) {
            isPlaying = false;
            setState(() {});
          }
        },
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableRetry: true,
          playerTheme: BetterPlayerTheme.custom,
          playIcon: Icons.play_arrow_sharp,
          enablePip: false,
          enableOverflowMenu: false,
          enableFullscreen: false,
          enableMute: false,
          enableProgressText: false,
          enableProgressBar: false,
          enableProgressBarDrag: false,
          enablePlayPause: false,
          enableSkips: false,
          enableAudioTracks: false,
          enableSubtitles: false,
          enableQualities: false,
          enablePlaybackSpeed: false,
        ));
    _betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file, widget.videoFile.path);
    _betterPlayerController =
        BetterPlayerController(betterPlayerConfiguration!);
    _betterPlayerController!.setupDataSource(_betterPlayerDataSource!);
    hashList.clear();
  }

  bool deliverNotification = false;

  List categoryList = [];
  List hashList = [];

  @override
  void dispose() {
    VideoCompress.dispose();
    super.dispose();
  }

  String? categoryId;
  String selectedCategory = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 14,
            ),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButtonWithIcon(
                        height: 48,
                        prefixIcon: draft_icon,
                        text: 'Drafts',
                        onPrimaryColor: AppColors.black,
                        primaryColor: AppColors.pureWhite,
                        borderColor: AppColors.snow,
                        onTap: () {})),
                SizedBox(width: 15),
                Expanded(
                  child: ElevatedButtonWithIcon(
                      height: 48,
                      prefixIcon: post_icon,
                      text: 'Post',
                      onPrimaryColor: AppColors.snow,
                      primaryColor: AppColors.acmeBlue,
                      onTap: () async {
                        _betterPlayerController?.pause();
                        setState(() {});
                        if (selectedCategory.isEmpty) {
                          BotToast.showText(text: 'please select interest');
                        }
                        if (descriptionController.text.isEmpty) {
                          BotToast.showText(
                              text: 'please fill the description');
                        }
                        if (selectedCategory.isNotEmpty &&
                            descriptionController.text.isNotEmpty) {
                          await context.read<VideoBloc>().publishVideo(
                              categoryId,
                              widget.videoFile.path,
                              description,
                              widget.introThumbnail);
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              _betterPlayerController!.dispose();
              return true;
            },
            child:
                BlocConsumer<VideoBloc, VideoState>(listener: (context, state) {
              if (state is VideoLoading) {
                BotToast.closeAllLoading();
              }
              if (state is VideoStatusState) {
                BotToast.closeAllLoading();
              }
              if (state is VideoLoaded) {
                BotToast.closeAllLoading();
                Navigator.of(context).popUntil((route) => route.isFirst);
                _betterPlayerController!.dispose();
              }
              if (state is VideoError) {
                BotToast.closeAllLoading();
                BotToast.showText(text: state.error);
              }
            }, builder: (context, state) {
              if (state is VideoStatusState) {
                double data = state.sentStatus / state.receiveStatus * 100;
                double per =
                    (state.sentStatus / state.receiveStatus * 100) / 100;
                debugPrint('data is :: $data');
                debugPrint('percentage is :: $per');
                return Center(
                  child: CircularPercentIndicator(
                    restartAnimation: true,
                    radius: 40.0,
                    lineWidth: 5.0,
                    animation: true,
                    startAngle: 5,
                    percent:
                        (state.sentStatus / state.receiveStatus * 100) / 100,
                    center: Text(
                      '${(state.sentStatus / state.receiveStatus * 100).round()}%',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    backgroundColor: AppColors.silver,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: AppColors.acmeBlue,
                    footer: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Uploading video: ${state.sentStatus} from ${state.receiveStatus}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17.0),
                      ),
                    ),
                  ),
                );
              } else if (state is VideoLoading) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Text(
                          'Please wait while compressing video...',
                          style: TextStyles.regularTextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: LinearProgressIndicator(
                          backgroundColor: AppColors.silver,
                          valueColor:
                              AlwaysStoppedAnimation(AppColors.acmeBlue),
                          minHeight: 25,
                        ),
                      ),
                    ]);
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(height: 15),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              alignment: Alignment.center,
                              height: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Stack(
                                  children: [
                                    BetterPlayer(
                                        controller: _betterPlayerController!),
                                    GestureDetector(
                                      onTap: () {
                                        isPlaying
                                            ? _betterPlayerController!.pause()
                                            : _betterPlayerController!.play();
                                      },
                                      child: Align(
                                        child: Icon(
                                            isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            color: AppColors.pureWhite),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CustomTextFormField(
                                hasHintText: true,
                                hintText:
                                    'Describe your post, add questions, add hashtags, that relate to your Specialization. Ask to book a call',
                                isMaxLines: 5,
                                keyboardType: TextInputType.multiline,
                                controller: descriptionController,
                                labelText: '',
                                onChanged: (val) {
                                  setState(() {});
                                  // validateButton();
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.centerLeft,
                            height: 35,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: interests.length,
                              itemBuilder: (context, index) {
                                return InterestBox(
                                    onTap: (int value) {
                                      setState(() {
                                        selectedIndex = value;
                                        categoryId = interests[selectedIndex]
                                            .id
                                            .toString();
                                        selectedCategory =
                                            interests[selectedIndex].name;
                                        categoryList.clear();
                                        if (!hashList
                                            .contains(selectedCategory)) {
                                          hashList.add(selectedCategory);
                                          categoryList
                                              .add(' #$selectedCategory ');
                                          description =
                                              '${descriptionController.text}${categoryList[0]}';
                                          descriptionController.text =
                                              description;
                                        }
                                        setState(() {});
                                      });
                                    },
                                    index: index,
                                    name: interests[index].name,
                                    selectedIndex: selectedIndex);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}

class InterestBox extends StatefulWidget {
  final String name;
  final int selectedIndex;
  final int index;
  final Function(int value) onTap;

  const InterestBox({
    Key? key,
    required this.onTap,
    required this.index,
    required this.name,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<InterestBox> createState() => _InterestBoxState();
}

class _InterestBoxState extends State<InterestBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => widget.onTap(widget.index),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: widget.selectedIndex == widget.index
                    ? AppColors.snow
                    : AppColors.pureWhite,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(width: 1, color: AppColors.snow)),
            child: Text('#${widget.name}',
                style: TextStyles.regularTextStyle(textColor: AppColors.black)),
          ),
        ),
        SizedBox(width: 20)
      ],
    );
  }
}
