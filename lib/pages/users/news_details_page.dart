import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:flutter/material.dart';

class NewsDetailsPage extends StatelessWidget {
  const NewsDetailsPage({
    super.key,
    required this.description,
    required this.title,
    required this.image,
  });

  final String title;
  final String description;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(
              kSP20x,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (image != null && (image?.isNotEmpty ?? false)) ...[
                  CachedNetworkImage(
                    imageUrl: image ?? '',
                    fit: BoxFit.cover,
                    height: kDetailsPageImageHeight,
                  ),
                ],
                const SizedBox(
                  height: kSP10x,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: kFontSize22x,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: kSP20x,
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: kFontSize16x,
                    height: 2.3,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
