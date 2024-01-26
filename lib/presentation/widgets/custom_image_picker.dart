import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:readmock/config/app_text_styles.dart';

class CustomImagePicker extends StatefulWidget {
  final void Function(File?) onImagePicked;
  final String title;
  File? imageFile;

  CustomImagePicker(
      {required this.onImagePicked, required this.title, this.imageFile});

  @override
  _CustomImagePickerState createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });

      widget.onImagePicked(_imageFile);
    }
  }

  @override
  void initState() {
    super.initState();
    _imageFile = widget.imageFile;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Select Image'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        GestureDetector(
                          child: const Text('Take a picture'),
                          onTap: () {
                            _pickImage(ImageSource.camera);
                            Navigator.of(context).pop();
                          },
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          child: const Text('Choose from gallery'),
                          onTap: () {
                            _pickImage(ImageSource.gallery);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_imageFile != null ? widget.title : widget.title,
                    style: AppTextStyle.h3TitleTextStyle()
                        .copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _imageFile != null
                    ? Row(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.width * 0.4,
                                // Set the height of the image preview
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                                child: Image.file(
                                  _imageFile!,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              // Camera icon on the image overlay with opacity 0.5
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.grey,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),

                          //REmove button
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _imageFile = null;
                              });
                              widget.onImagePicked(null);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text('Remove',
                                        style: AppTextStyle.h5TitleTextStyle()
                                            .copyWith(
                                          color: Colors.white,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        height: 50, // Set the height of the image preview
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 24,
                          color: Colors.grey,
                        ),
                      ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (_imageFile != null)
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        const Text('Selected Image'),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    content: Image.file(_imageFile!),
                  );
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('View Full Image'),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
