import 'package:flutter/material.dart';
import 'package:hr/presentation/pages/landing/widgets/getstarted_button.dart';
import 'widgets/background_image.dart';
import 'widgets/logo_text.dart';
import 'widgets/subtitle_desc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BackgroundImage(),
          LogoText(topMargin: screenHeight * 0.1),
          SubtitleDescription(startFrom: screenHeight * 0.59),
          GetStartedButton(topMargin: screenHeight * 0.88),
        ],
      ),
    );
  }
}
