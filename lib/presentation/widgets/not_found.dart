import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../core/resources/assets_manager.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key, required this.titile});

  final String titile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Animated logo
        Center(
          child: FadeInImage.assetNetwork(
            placeholder:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKiRpmZu5shu1vVVI0cn03RT2J961Xv4mWfZ4R21hfDg&s',
            image:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKiRpmZu5shu1vVVI0cn03RT2J961Xv4mWfZ4R21hfDg&s',
            height: 150, // Adjust the height as needed
          ),
        ),

        const SizedBox(height: 20),

        // Animated title
        TyperAnimatedTextKit(
          speed: Duration(milliseconds: 200),
          isRepeatingAnimation: false,
          text: [titile],
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),

        // Subtitle
        const SizedBox(height: 10),
        Text(
          "Sorry, we couldn't find any results.",
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    );
  }
}
