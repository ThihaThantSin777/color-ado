import 'package:color_ado/resources/dimens.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      surfaceTintColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Dialog ရဲ့ alert info message
          Padding(
            padding: EdgeInsets.all(kSP20x),
            child: Center(
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    width: kSP10x,
                  ),
                  Text(
                    'Please wait',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
