import 'package:android_intent/android_intent.dart';
import './config.dart';
import 'package:path/path.dart' as path;
class _TUBEtool{
  void openvlc(String url) async{
    String str1 = path.posix.normalize(path.join(vlcDomain,url));
    String str2 = 'smb://root@${str1}';
    AndroidIntent vlcIntent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull(str2),
      package:'org.videolan.vlc',
      componentName: 'org.videolan.vlc.gui.video.VideoPlayerActivity',
    );
    await vlcIntent.launch();
  }
  void pageopenvlc(String url) async{
    AndroidIntent vlcIntent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull(url),
      package:'org.videolan.vlc',
      componentName: 'org.videolan.vlc.gui.video.VideoPlayerActivity',
    );
    await vlcIntent.launch();
  }
}

_TUBEtool TUBEtool = new _TUBEtool();