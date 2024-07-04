import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:oua_flutter33/core/models/user_model.dart';
import 'package:oua_flutter33/core/services/user_service.dart';

class ProfileImageWidget extends StatefulWidget {
  final User? user;

  const ProfileImageWidget({super.key, this.user});

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidget();
}

class _ProfileImageWidget extends State<ProfileImageWidget> {
  PlatformFile? pickedFile;
  User? user;

  final String noneImage =
      "https://firebasestorage.googleapis.com/v0/b/ouaflutter33.appspot.com/o/images%2Fnone-pp.png?alt=media&token=64eeecb0-8d11-4b3c-ab42-2225f5857472";

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });

    UserService().uploadFile(pickedFile!.path!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey,
            width: 4,
            strokeAlign: BorderSide.strokeAlignInside),
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
          image: pickedFile != null
              ? FileImage(File(pickedFile!.path!))
              : NetworkImage(
                      user?.imageUrl != null ? user!.imageUrl : noneImage)
                  as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
      child: IconButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.grey[400]),
          fixedSize: const WidgetStatePropertyAll(
            Size(10, 10),
          ),
        ),
        onPressed: selectFile,
        icon: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }
}
