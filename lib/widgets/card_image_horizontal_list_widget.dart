import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardImageHorizontalListWidget extends StatelessWidget {
  const CardImageHorizontalListWidget({
    super.key,
    required this.title,
    this.viewAllTitle,
    required this.onTapViewAll,
    required this.imageList,
    this.cardListViewHeight = 150,
  });

  final String title;
  final String? viewAllTitle;
  final Function onTapViewAll;
  final List<String> imageList;
  final double cardListViewHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTapViewAll();
                },
                child: Text(
                  viewAllTitle ?? 'View all',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: cardListViewHeight,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            children: imageList
                .map((e) => _ImageCardView(
                      image: e,
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
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
