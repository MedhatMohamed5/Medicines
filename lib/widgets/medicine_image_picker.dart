import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MedicineImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  final String imageUrl;

  MedicineImagePicker(this.imagePickFn, this.imageUrl);

  @override
  _MedicineImagePickerState createState() => _MedicineImagePickerState();
}

class _MedicineImagePickerState extends State<MedicineImagePicker> {
  File _pickedFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.white,
          elevation: 4,
          child: Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white60,
              image: DecorationImage(
                image: _pickedFile != null
                    ? FileImage(
                        _pickedFile,
                      )
                    : widget.imageUrl != ''
                        ? NetworkImage(widget.imageUrl, scale: 0.8)
                        : AssetImage('assets/images/medical.png'),
                fit: _pickedFile == null ? BoxFit.fitHeight : BoxFit.cover,
              ),
            ),
          ),
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera),
          label: widget.imageUrl == '' && _pickedFile == null
              ? const Text('Add Image')
              : const Text('Change Image'),
          textColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedImage != null) {
      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _pickedFile = pickedImageFile;
      });
      widget.imagePickFn(pickedImageFile);
    }
  }
}
