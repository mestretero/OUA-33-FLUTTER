// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';

import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/ui/product/product_add/product_add_view_model.dart';

class PhotoPickerScreen extends StatefulWidget {
  final Function(List<File?> images) onChanged;
  final ProductAddViewModel? model;
  const PhotoPickerScreen({
    super.key,
    required this.onChanged,
    this.model,
  });

  @override
  _PhotoPickerScreenState createState() => _PhotoPickerScreenState();
}

class _PhotoPickerScreenState extends State<PhotoPickerScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<File?> _images = [null, null, null, null];
  int _imageCount = 0;
  bool isEditedPage = false;

  @override
  void initState() {
    super.initState();
    isEditedPage = widget.model!.isEditedPage;
    if (widget.model!.isEditedPage) {
      for (var i = 0; i < widget.model!.imagesData.length; i++) {
        _images[i] = widget.model!.imagesData[i];
        _imageCount += 1;
      }
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _images[_imageCount] = File(pickedFile.path);
        _imageCount++;
        widget.onChanged(_images);
      });
    }
  }

  void _removeImage(index) {
    setState(() {
      if (index + 1 == _imageCount) {
        _images[index] = null;
        _imageCount--;
      } else {
        for (var i = index; i < _imageCount; i++) {
          _images[index] = _images[index + 1];
          _images[index + 1] = null;
          _imageCount--;
        }
      }
      widget.onChanged(_images);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text(
                    'Galeriden Seç',
                  ),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: Icon(
                  Icons.photo_camera,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Kameradan Çek'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "El Emeğinizin Fotoğrafları",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "$_imageCount/4",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                  onPressed: _imageCount < 4
                      ? () {
                          _showPicker(context);
                        }
                      : null,
                  child: Icon(
                    Icons.add_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(4, (index) {
              return Container(
                width: Scaler.width(0.19, context),
                height: Scaler.width(0.19, context),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: _images[index] != null
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_images[index]!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: IconButton(
                          iconSize: 32,
                          onPressed: () => _removeImage(index),
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                        ),
                      )
                    // Image.file(, fit: BoxFit.cover)
                    : Center(child: Text('${index + 1}')),
              );
            }),
          ),
        ],
      ),
    );
  }
}
