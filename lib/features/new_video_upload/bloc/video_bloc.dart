import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpert_app/features/new_video_upload/bloc/video_state.dart';
import 'package:helpert_app/features/video/repo/video_repo.dart';
import 'package:light_compressor/light_compressor.dart';
import 'package:path_provider/path_provider.dart' as path;

class VideoBloc extends Cubit<VideoState> {
  VideoBloc() : super(InitialState());

  Future<void> publishVideo(String? categoryId, String? introVideo,
      String? mainTitle, MultipartFile? introThumbnail) async {
    emit(VideoLoading());
    try {
      MultipartFile? introVideoFile;
      String? desFile;
      final LightCompressor lightCompressor = LightCompressor();

      /// intro video
      if (introVideo != null) {
        desFile = await _destinationFile;
        final Stopwatch stopwatch = Stopwatch()..start();
        final dynamic response = await lightCompressor.compressVideo(
            path: introVideo,
            destinationPath: desFile,
            videoQuality: VideoQuality.medium,
            isMinBitrateCheckEnabled: false,
            iosSaveInGallery: false);
        stopwatch.stop();
        final Duration duration =
            Duration(milliseconds: stopwatch.elapsedMilliseconds);

        if (response is OnSuccess) {
          desFile = response.destinationPath;
          String introFileName = desFile.split('/').last;
          introVideoFile =
              await MultipartFile.fromFile(desFile, filename: introFileName);
          var data = FormData.fromMap({
            'main_title': mainTitle,
            'intro_video': introVideoFile,
            'interest_id': categoryId,
            'image': introThumbnail
          });

          bool result = await VideoRepo.instance.publishVideoApi(data,
              (sendStatus, receiveStatus) {
            print('SENDER VALUE :: $sendStatus');
            print('RECEIVER VALUE :: $receiveStatus');
            emit(VideoStatusState(
                sentStatus: sendStatus, receiveStatus: receiveStatus));
            print(sendStatus / receiveStatus * 100);
            print(": == === :");
          });
          if (result) {
            emit(VideoLoaded());
          } else {
            emit(VideoError('something wrong'));
          }
        }
      }
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  Future<String> get _destinationFile async {
    String directory;
    final String videoName = '${DateTime.now().millisecondsSinceEpoch}.mp4';
    if (Platform.isAndroid) {
      // Handle this part the way you want to save it in any directory you wish.
      final List<Directory>? dir = await path.getExternalStorageDirectories(
          type: path.StorageDirectory.movies);
      directory = dir!.first.path;
      return File('$directory/$videoName').path;
    } else {
      final Directory dir = await path.getLibraryDirectory();
      directory = dir.path;
      return File('$directory/$videoName').path;
    }
  }
}
