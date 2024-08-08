import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {
  static Future launchURL(String url) async {
    final rURL = url.replaceAll(" ", "%20");
    final uri = Uri.parse(rURL);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
      );
    }
  }
}
