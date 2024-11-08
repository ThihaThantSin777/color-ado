import 'package:color_ado/resources/dimens.dart';
import 'package:flutter/material.dart';

class CUEventsDetailsPage extends StatelessWidget {
  const CUEventsDetailsPage({
    super.key,
    required this.description,
    required this.title,
  });

  final String title;
  final String description;

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
