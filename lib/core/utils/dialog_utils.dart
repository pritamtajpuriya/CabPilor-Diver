import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class DialogUtils {
  DialogUtils._();

  static void buildLoadingDialog(
    BuildContext context, {
    String title = "Loading...",
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: CircularProgressIndicator.adaptive(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //buildConfirmationDialog
  static void buildConfirmationDialog(
    BuildContext context, {
    String title = "Confirmation",
    required String message,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.primaryColor,
                        width: 0.5,
                      ),
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning,
                        color: ColorManager.primaryBloodColor,
                        size: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          message,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: onCancel,
                            child: Text(
                              "Cancel",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                          TextButton(
                            onPressed: onConfirm,
                            child: Text(
                              "Confirm",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void buildErrorMessageDialog(
    BuildContext context, {
    String title = "Failed",
    required String message,
    VoidCallback? onClose,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.primaryColor,
                        width: 0.5,
                      ),
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.warning,
                        color: ColorManager.primaryBloodColor,
                        size: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void buildSuccessMessageDialog(
    BuildContext context, {
    String title = "Success",
    required String message,
    VoidCallback? onDone,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      borderRadius: BorderRadius.circular(12.0)),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                        size: 30.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onDone,
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: ColorManager.whiteColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_right_alt_outlined),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void buildSetReminderDialog({
    required BuildContext context,
    VoidCallback? onNoClick,
    VoidCallback? onYesClick,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Do you want to set reminder?",
                    textAlign: TextAlign.center,
                    style: getSemiBoldStyle(
                        color: ColorManager.blackColor, fontSize: 18.0),
                  ),
                  Text(
                    "You need to set reminder to get remind on future. Please set reminder if you wish in future",
                    textAlign: TextAlign.center,
                    style: getRegularStyle(
                      color: ColorManager.blackColor,
                      fontSize: 14.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: onNoClick,
                          child: Container(
                            width: 80.0,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: ColorManager.redColor,
                            ),
                            child: Text(
                              "No",
                              style: getMediumStyle(
                                color: ColorManager.whiteColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onYesClick,
                          child: Container(
                            width: 80.0,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: ColorManager.primaryColor,
                            ),
                            child: Text(
                              "Yes",
                              style: getMediumStyle(
                                color: ColorManager.whiteColor,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  static void buildImageViewDialog(
      {required BuildContext context, required String url}) {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 24),
            child: CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => const LinearProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          );
        });
  }

  static void buildPhotoPickerDialog(
      {required BuildContext context,
      VoidCallback? onCameraTap,
      VoidCallback? onGalleryTap}) {
    showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            bottomLeft: Radius.circular(18.0),
                          )),
                      padding: const EdgeInsets.all(24.0),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 60.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onGalleryTap,
                    child: Container(
                      decoration: BoxDecoration(
                          color: ColorManager.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(18.0),
                            bottomRight: Radius.circular(18.0),
                          )),
                      padding: const EdgeInsets.all(24.0),
                      child: const Icon(
                        Icons.photo,
                        size: 60.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<DateTime?> inputDateFromUser(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3030),
    );
    return pickedDate;
  }

  static Future<TimeOfDay?> inputTimeFromUser(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,
      initialTime: TimeOfDay.now(),
    );
    return pickedTime;
  }

  static void buildDeleteAlertDialog({
    required BuildContext context,
    String message = "Make sure you cannot undo once you have deleted",
    VoidCallback? onCancel,
    required VoidCallback onDelete,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Are you sure?",
              style: getMediumStyle(
                  color: ColorManager.blackColor, fontSize: 18.0),
            ),
            content: Text(
              message,
              style: getRegularStyle(
                color: ColorManager.blackColor,
                fontSize: 16.0,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: getMediumStyle(
                      color: ColorManager.blackColor,
                      fontSize: 15.0,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    onDelete();
                  },
                  child: Text(
                    "Delete",
                    style: getMediumStyle(
                      color: ColorManager.redColor,
                      fontSize: 15.0,
                    ),
                  )),
            ],
          );
        });
  }

  //Build Do you want to Need to Perchase Dialog

  static void buildPerchaseAlertDialog({
    required BuildContext context,
    String message = "Please Perchase this item to unlock",
    VoidCallback? onCancel,
    required VoidCallback onContinue,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Do you want to perchase?",
              style: getMediumStyle(
                  color: ColorManager.blackColor, fontSize: 18.0),
            ),
            content: Text(
              message,
              style: getRegularStyle(
                color: ColorManager.blackColor,
                fontSize: 16.0,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: getMediumStyle(
                      color: ColorManager.blackColor,
                      fontSize: 15.0,
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    onContinue();
                  },
                  child: Text(
                    "Perchase",
                    style: getMediumStyle(
                      color: ColorManager.redColor,
                      fontSize: 15.0,
                    ),
                  )),
            ],
          );
        });
  }

  static void buildContactPermissionDialog({
    required BuildContext context,
    VoidCallback? onGrant,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (cContext) => AlertDialog(
        title: const Text("Contact Permission"),
        content: const Text(
            "Chat NP need contact permission to backup contact list in server. Are you sure to give permission ?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: getSemiBoldStyle(color: ColorManager.redColor),
              )),
          TextButton(
            child: Text(
              "Grant",
              style: getSemiBoldStyle(color: ColorManager.primaryColor),
            ),
            onPressed: () {
              if (onGrant != null) {
                Navigator.pop(context);
                onGrant();
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  static void buildCameraPermissionDialog({
    required BuildContext context,
    VoidCallback? onGrant,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (cContext) => AlertDialog(
        title: const Text("Camera Permission"),
        content: const Text(
            "Chat NP need camera permission to capture image or record video. Are you sure to grant? "),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: getSemiBoldStyle(color: ColorManager.redColor),
              )),
          TextButton(
            child: Text(
              "Grant",
              style: getSemiBoldStyle(color: ColorManager.primaryColor),
            ),
            onPressed: () {
              if (onGrant != null) {
                Navigator.pop(context);
                onGrant();
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  static void buildStoragePermissionDialog({
    required BuildContext context,
    VoidCallback? onGrant,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (cContext) => AlertDialog(
        title: const Text("Storage Permission"),
        content: const Text(
            "Chat NP need storage permission to upload image or record video. Are you sure to grant? "),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: getSemiBoldStyle(color: ColorManager.redColor),
              )),
          TextButton(
            child: Text(
              "Grant",
              style: getSemiBoldStyle(color: ColorManager.primaryColor),
            ),
            onPressed: () {
              if (onGrant != null) {
                Navigator.pop(context);
                onGrant();
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  static void buildMicrophonePermissionDialog({
    required BuildContext context,
    VoidCallback? onGrant,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (cContext) => AlertDialog(
        title: const Text("Microphone Permission"),
        content: const Text(
            "Chat NP need microphone permission to send audio message. Are you sure to grant? "),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: getSemiBoldStyle(color: ColorManager.redColor),
              )),
          TextButton(
            child: Text(
              "Grant",
              style: getSemiBoldStyle(color: ColorManager.primaryColor),
            ),
            onPressed: () {
              if (onGrant != null) {
                Navigator.pop(context);
                onGrant();
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
