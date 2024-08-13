import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/resources/strings.dart';
import 'package:flutter/material.dart';

class CardImageHorizontalListWidget extends StatelessWidget {
  const CardImageHorizontalListWidget({
    super.key,
    required this.title,
    this.viewAllTitle,
    required this.onTapViewAll,
    required this.imageAndDescList,
    this.cardListViewHeight = kCardImageHorizontalListHeight,
    required this.onTapImageCard,
  });

  final String title;
  final String? viewAllTitle;
  final Function onTapViewAll;
  final List<(String image, String description, String? pdfName, String? pdfUrl, String title)> imageAndDescList;
  final double cardListViewHeight;
  final Function(
    String image,
    String description,
    String? pdfName,
    String? pdfUrl,
    String title,
  ) onTapImageCard;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kSP20x),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: kFontSize16x,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  onTapViewAll();
                },
                child: Text(
                  viewAllTitle ?? kViewAllText,
                  style: const TextStyle(
                    fontSize: kFontSize16x,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: kSP10x,
        ),
        SizedBox(
          height: cardListViewHeight,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: kSP10x),
            scrollDirection: Axis.horizontal,
            children: imageAndDescList
                .map((e) => GestureDetector(
                      onTap: () {
                        onTapImageCard(e.$1, e.$2, e.$3, e.$4, e.$5);
                      },
                      child: _ImageCardView(
                        image: e.$1,
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ImageCardView extends StatelessWidget {
  const _ImageCardView({
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          kSP10x,
        ),
        child: Hero(
          tag: image,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
