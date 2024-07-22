import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/utils/string_extensions.dart';
import 'package:flutter/material.dart';

class BlueCardContainerWidget extends StatelessWidget {
  const BlueCardContainerWidget({
    super.key,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  final String title;
  final String description;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kBlueCardContainerHeight,
      padding: const EdgeInsets.all(kSP20x),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSP20x),
        color: Colors.blue,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: kFontSize18x,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: kSP5x,
          ),
          const Divider(
            thickness: 1,
            color: Colors.white,
          ),
          const SizedBox(
            height: kSP5x,
          ),
          Text(
            description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              height: 2.3,
            ),
          ),
          const SizedBox(
            height: kSP5x,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              createdAt.getMonthDayYear,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: kSP5x,
          ),
        ],
      ),
    );
  }
}
