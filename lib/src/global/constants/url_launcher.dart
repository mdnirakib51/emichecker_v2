import 'package:url_launcher/url_launcher.dart';

class UrlLauncher{
  static void launchUrls({
    required String urls,
  }) async {
    await launchUrl(Uri.parse(
        urls.toString()),
        mode: LaunchMode.externalApplication
    );
  }
}