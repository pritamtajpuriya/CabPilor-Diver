import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DynamicLinkService {
  static Future<Uri> generateDynamicLink({
    required String title,
    required String description,
    required String imageUrl,
    required String time,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://www.example.com/"),
      uriPrefix: "https://gyankala.page.link",
      androidParameters: AndroidParameters(
        packageName: packageInfo.packageName,
        minimumVersion: 30,
      ),
      iosParameters: IOSParameters(
        bundleId: packageInfo.packageName,
        appStoreId: "123456789",
        minimumVersion: "1.0.1",
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        source: "twitter",
        medium: "social",
        campaign: "gyankala",
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
        imageUrl: Uri.parse(imageUrl),
      ),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    return dynamicLink.shortUrl;
  }
}
