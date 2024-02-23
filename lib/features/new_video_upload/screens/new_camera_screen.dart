import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:helpert_app/constants/app_colors.dart';

import '../../../common_widgets/status_bar_styles.dart';
import '../../../main.dart';
import '../widgets/new_camera_widget.dart';

class NewCameraScreen extends StatefulWidget {
  const NewCameraScreen({Key? key}) : super(key: key);

  @override
  State<NewCameraScreen> createState() => _NewCameraScreenState();
}

class _NewCameraScreenState extends State<NewCameraScreen> {
  bool isRearCameraSelected = false;
  CameraController? cameraController;
  bool flash = false;

  @override
  initState() {
    super.initState();
    StatusBarStyles.themeData.clear();
    initCamera(cameras[1]);
  }

  Future initCamera(CameraDescription cameraDescription) async {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);
    try {
      await cameraController!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException {
      debugPrint('');
    }
  }

  @override
  void dispose() {
    cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Expanded(
            child: NewCameraWidget(
                cameraController: cameraController!,
                callBack: () {
                  isRearCameraSelected = !isRearCameraSelected;
                  setState(() {});
                  initCamera(cameras[isRearCameraSelected ? 0 : 1]);
                },
                flashCallBack: () {
                  flash = !flash;
                  setState(() {});
                  flash == false
                      ? cameraController?.setFlashMode(FlashMode.torch)
                      : cameraController?.setFlashMode(FlashMode.off);
                }),
          )
        ],
      ),
    );
  }
}
