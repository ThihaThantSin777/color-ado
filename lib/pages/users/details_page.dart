import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    super.key,
    required this.image,
    required this.description,
  });

  final String image;
  final String description;

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
