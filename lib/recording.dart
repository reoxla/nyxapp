import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class VoiceRecorderService {
  final recorder = AudioRecorder();
  late AudioPlayer _player;
  String? _lastRecordingPath;

  void startRecording() async {
    bool hasPermission = await recorder.hasPermission();
    if (hasPermission) {
      const config = RecordConfig();
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/my_recording.m4a';

      await recorder.start(const RecordConfig(), path: path);
    }
  }

  void stopRecording() async {
    final path = await recorder.stop();
    print("Recording saved to: $path");
    _lastRecordingPath = path;
  }

  void initPlayer() {
    _player = AudioPlayer();
  }

  void playRecording() async {
    if (_lastRecordingPath != null) {
      // DeviceCheck: We use DeviceFileSource for files stored on the phone
      await _player.play(DeviceFileSource(_lastRecordingPath!));
    }
  }

  // Don't forget to clean up!
  void cleanUp() {
    _player.dispose();
    recorder.dispose();
  }
}
