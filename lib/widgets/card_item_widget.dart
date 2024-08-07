import 'package:color_ado/resources/dimens.dart';
import 'package:flutter/material.dart';

class CardItemWidget extends StatelessWidget {
  const CardItemWidget({
    super.key,
    required this.iconData,
    required this.title,
    required this.onTapCard,
  });

  final IconData iconData;
  final String title;
  final Function onTapCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapCard(),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              Icon(
                iconData,
                color: Colors.blue,
                size: 40,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: kFontSize16x,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
