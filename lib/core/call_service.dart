import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

import '../features/video_call/model/call_model.dart';

class CallService {
  Future<void> showCallkitIncoming(CallModel callModel) async {
    var params = <String, dynamic>{
      'id': callModel.callerId,
      'nameCaller': callModel.callerName,
      'appName': 'Callkit',
      'avatar': callModel.callerAvatar,
      'handle': '',
      'type': 0,
      'duration': 30000,
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'textMissedCall': 'Missed call',
      'textCallback': 'Call back',
      'extra': <String, dynamic>{'userId': '1a2b3c4d'},
      'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      'android': <String, dynamic>{
        'isCustomNotification': true,
        'isShowLogo': false,
        'isShowCallback': false,
        'ringtonePath': 'system_ringtone_default',
        'backgroundColor': '#0955fa',
        'backgroundUrl': callModel.callerAvatar,
        'actionColor': '#4CAF50',
        'incomingCallNotificationChannelName': "Incoming Call",
        'missedCallNotificationChannelName': "Missed Call",
      },
      'ios': <String, dynamic>{
        'iconName': 'CallKitLogo',
        'handleType': '',
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'default',
        'audioSessionActive': true,
        'audioSessionPreferredSampleRate': 44100.0,
        'audioSessionPreferredIOBufferDuration': 0.005,
        'supportsDTMF': true,
        'supportsHolding': true,
        'supportsGrouping': false,
        'supportsUngrouping': false,
        'ringtonePath': 'system_ringtone_default'
      }
    };
    await FlutterCallkitIncoming.showCallkitIncoming(params);
  }
}
