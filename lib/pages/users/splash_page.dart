import 'package:color_ado/pages/users/home/index_page.dart';
import 'package:color_ado/resources/dimens.dart';
import 'package:color_ado/utils/image_utils.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(kDuration2Seconds, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const IndexPage()),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Image.asset(
          width: kSplashLogoImageHeight,
          ImageUtils.kAppLogo,
        ),
      ),
    );
  }
}
