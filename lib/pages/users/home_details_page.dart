import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/utils/launcher_utils.dart';
import 'package:flutter/material.dart';

class HomeDetailsPage extends StatelessWidget {
  const HomeDetailsPage({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    this.pdfName,
    this.pdfUrl,
  });

  final String title;
  final String image;
  final String description;
  final String? pdfName;
  final String? pdfUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              kSP10x,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: kFontSize22x,
                      height: 2,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: kSP10x,
                ),
                Hero(
                  tag: image,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.cover,
                    height: kDetailsPageImageHeight,
                  ),
                ),
                const SizedBox(
                  height: kSP10x,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: kFontSize16x,
                    height: 2.3,
                  ),
                ),
                const SizedBox(
                  height: kSP10x,
                ),
                if ((pdfName?.isNotEmpty ?? false) && (pdfUrl?.isNotEmpty ?? false)) ...[
                  const Divider(
                    thickness: 1.2,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blue,
                          iconColor: Colors.white,
                        ),
                        icon: const Icon(Icons.download),
                        onPressed: () {
                          LauncherUtils.launchURL(pdfUrl ?? '');
                        },
                        label: Text(
                          '$pdfName to Download here',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
