import 'package:color_ado/utils/image_utils.dart';
import 'package:flutter/material.dart';

class DataEmptyWidget extends StatelessWidget {
  const DataEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        ImageUtils.kDataEmptyImage,
      ),
    );
  }
}
