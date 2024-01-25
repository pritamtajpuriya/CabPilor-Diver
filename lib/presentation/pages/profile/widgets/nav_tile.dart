import 'package:flutter/material.dart';
import 'package:readmock/config/app_text_styles.dart';
import 'package:readmock/core/resources/styles_manager.dart';

class BuildNavTitle extends StatelessWidget {
  const BuildNavTitle(
      {Key? key, this.title, this.iconUrl, this.onPressed, this.icon})
      : super(key: key);

  final String? title;
  final String? iconUrl;
  final IconData? icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey.withOpacity(0.05)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: icon == null
                      ? Image.asset(
                          iconUrl!,
                          height: 30,
                        )
                      : Icon(icon, color: Colors.black87),
                  // Image.asset(
                  //   iconUrl!,
                  //   height: 30,
                  // ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                title!,
                style: AppTextStyle.h5TitleTextStyle(),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 12,
              )
            ],
          ),
        ),
      ),
    );
  }
}
