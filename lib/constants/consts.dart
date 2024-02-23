const String poppinsFamily = 'Poppins';
const String museoFamily = 'museo';
const String proximaFamily = 'proxima';

//Firebases
const callsCollection = 'Calls';
const tokensCollection = 'Tokens';
//Agora
const agoraAppId = 'f2ff960592354d5b86dab556f13fca77';

const int callDurationInSec = 20;

enum CallStatus {
  none,
  ringing,
  accept,
  reject,
  unAnswer,
  cancel,
  end,
}
