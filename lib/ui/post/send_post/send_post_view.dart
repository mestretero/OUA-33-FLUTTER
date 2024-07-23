// ignore_for_file: deprecated_member_use, prefer_is_empty

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/widgets/my_appbar.dart';
import 'package:oua_flutter33/ui/post/send_post/send_post_view_model.dart';
import 'package:stacked/stacked.dart';

class SendPostView extends StatelessWidget {
  const SendPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SendPostViewModel>.reactive(
      viewModelBuilder: () => SendPostViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyAppBarWidget(
                        isBackButton: true,
                        title: "Yeni Gönderi",
                        routeName: Routes.mainView,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          elevation: 0,
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          // Navigation service
                          model.nextLastEditPage(context);
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("İleri"),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_outlined,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildProductSection(context, model),
                  const SizedBox(height: 16),
                  _buildImageSection(context, model),
                  const SizedBox(height: 8),
                  _buildGallerySection(context, model),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductSection(BuildContext context, SendPostViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Gönderiyle İlgili Ürünler",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                iconSize: 24,
                padding: const EdgeInsets.all(0.0),
                style: IconButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => model.addProduct(context),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          children: model.selectedProducts.map((product) {
            return Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(product.mainImageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Scaler.width(0.65, context),
                    child: Text(
                      product.name,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      iconSize: 16,
                      padding: const EdgeInsets.all(0.0),
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        backgroundColor: Colors.red.shade100.withOpacity(0.8),
                      ),
                      icon: const RotationTransition(
                        turns: AlwaysStoppedAnimation(45 / 360),
                        child: Icon(
                          Icons.add_rounded,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () => model.removeProduct(product),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context, SendPostViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "El Emeğinizin Fotoğrafı",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: Scaler.width(1, context),
          height: Scaler.width(1.2, context),
          child: model.selectedImage != null
              ? Image.file(
                  File(model.selectedImage!.path),
                  fit: BoxFit.cover,
                )
              : Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.photo_camera_rounded,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 32,
                    ),
                    onPressed: () => model.pickImage(),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildGallerySection(BuildContext context, SendPostViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Galerim",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.copy,
                    color: Theme.of(context).colorScheme.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Birden Fazla Seç",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
              onPressed: () => model.pickMultipleImages(),
            ),
            IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                elevation: 0,
              ),
              icon: Icon(
                Icons.camera_alt_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => model.openCamera(),
            ),
          ],
        ),
        const SizedBox(height: 8),
        model.galleryImages.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: model.galleryImages.length,
                itemBuilder: (context, index) {
                  final image = model.galleryImages[index];
                  final bool isSelected = model.selectedGalleryImages
                          .where((img) => img.name == image.title)
                          .toList()
                          .isEmpty
                      ? (model.selectedImage?.name == image.title
                          ? true
                          : false)
                      : true;

                  return GestureDetector(
                    onTap: () {
                      model.updateSelectedImage(image);
                    },
                    child: FutureBuilder<Uint8List?>(
                      future: image.thumbnailData,
                      builder: (context, snapshot) {
                        final bytes = snapshot.data;
                        if (bytes == null) {
                          return const CircularProgressIndicator();
                        }
                        return Container(
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: isSelected
                                ? Border.all(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    width: 3,
                                  )
                                : null,
                            image: DecorationImage(
                              image: MemoryImage(bytes),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.check_circle,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 24,
                                )
                              : Container(),
                        );
                      },
                    ),
                  );
                },
              ),
      ],
    );
  }
}
