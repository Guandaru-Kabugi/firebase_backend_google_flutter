import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({super.key});

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {

  File? _takeImage;

  void _takePicture() async{

    final imagePicker = ImagePicker();
    final pickedImaged = await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600,);
    if (pickedImaged == null) {
      return;
    }
    //perform the task of picking and changing state of an image with cubits
  }

  @override
  Widget build(BuildContext context) {
    
    Widget content = TextButton.icon(
      onPressed: _takePicture, 
      label: Text('Take a Picture'),
      icon: Icon(Icons.camera),
      );
    if (_takeImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: Image.file(
          _takeImage!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          ),
      );
    }    
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1, color: Theme.of(context).colorScheme.primary.withAlpha(51)
        )
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      child: content,
    );
  }
}