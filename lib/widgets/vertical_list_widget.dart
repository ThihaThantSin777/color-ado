import 'package:cached_network_image/cached_network_image.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:flutter/material.dart';

class VerticalListWidget extends StatelessWidget {
  const VerticalListWidget({
    super.key,
    this.image,
    this.title,
    this.description,
    required this.id,
    required this.onTapDelete,
    required this.onTapEdit,
  });

  final String? image;
  final String? title;
  final String? description;
  final int id;
  final Function onTapEdit;
  final Function onTapDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image?.isNotEmpty ?? false) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: image ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              if (title?.isNotEmpty ?? false) ...[
                Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: kFontSize16x,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              if (description?.isNotEmpty ?? false) ...[
                Text(
                  description ?? '',
                  maxLines: 4,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
              Row(
                children: [
                  Expanded(
                      child: MaterialButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    onPressed: () {
                      onTapEdit();
                    },
                    child: const Text('Edit'),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: MaterialButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      onTapDelete();
                    },
                    child: const Text('Delete'),
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}