class SliderVideoList {
  final String videoTitle;
  final String videoUrl;
  Duration? lastPosition;
  bool? wasPlaying = false;

  SliderVideoList(this.videoTitle, this.videoUrl);
}
