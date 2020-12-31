import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
            child: _buildContainer(context),
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

  Widget _buildContainer(BuildContext context) {
    return _pickedFile != null
        ? Image.file(_pickedFile)
        : widget.imageUrl != ''
            ? Center(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.imageUrl,
                  errorWidget: (ctx, _, __) => _placeholderImage(),
                  progressIndicatorBuilder: (ctx, _, progress) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blueGrey,
                        value: progress
                            .progress, //!= null ? progress.progress : 1,
                      ),
                    );
                  },
                ),
              )
            : _placeholderImage();
    /*Container(
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
      ),*/
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

  Widget _placeholderImage() => Image.asset(
        'assets/images/medical.png',
        /*frameBuilder: (_, child, ___, __) {
          return DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: child));
        },*/
      );
}
