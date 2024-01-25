import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readmock/core/resources/assets_manager.dart';

import '../../core/utils/dimensions.dart';

class CustomExitCard extends StatelessWidget {
  String? title;
  String? message;

  VoidCallback? onExit;
  CustomExitCard(
      {Key? key,
      this.title = 'Close the app',
      this.message = 'Are you sure you want to close the app',
      this.onExit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 40, top: 15),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(Dimensions.paddingSizeDefault))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
                color: Theme.of(context).hintColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault),
            child: SizedBox(width: 60, child: Image.asset(ImageAssets.logo)),
          ),
          const SizedBox(
            height: Dimensions.paddingSizeExtraSmall,
          ),
          Text(
            title!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: Dimensions.paddingSizeSmall,
                bottom: Dimensions.paddingSizeLarge),
            child: Text(message!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeOverLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //  cancel button
                // withour custome
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('cancel'.toUpperCase())),

                const SizedBox(
                  width: Dimensions.paddingSizeDefault,
                ),
                //  exit button
                ElevatedButton(
                    onPressed: onExit ?? () => SystemNavigator.pop(),
                    child: Text('exit'.toUpperCase())),
              ],
            ),
          )
        ],
      ),
    );
  }
}
