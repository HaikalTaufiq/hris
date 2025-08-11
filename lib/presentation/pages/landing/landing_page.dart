import 'package:flutter/material.dart';
import 'package:hr/presentation/pages/landing/widgets/getstarted_button.dart';
import 'widgets/background_image.dart';
import 'widgets/logo_text.dart';
import 'widgets/subtitle_desc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: LogoText(topMargin: screenHeight * 0.2),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SubtitleDescription(startFrom: screenHeight * 0.59),
                    SizedBox(height: 10),
                    GetStartedButton(topMargin: screenHeight * 0.88),
                    SizedBox(height: 10),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
