// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:oua_flutter33/app/app.router.dart';
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
                  MyAppBarWidget(
                    isBackButton: true,
                    title: "Yeni Gönderi",
                    routeName: Routes.mainView,
                  ),
                  _buildProductSection(model),
                  _buildImageSection(context, model),
                  _buildGallerySection(model),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductSection(SendPostViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gönderiyle İlgili Ürünler"),
        Wrap(
          children: model.selectedProducts.map((product) {
            return Chip(
              label: Text(product.title),
              onDeleted: () => model.removeProduct(product),
            );
          }).toList(),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => model.addProduct(),
        ),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context, SendPostViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("El Emeğinizin Fotoğrafı"),
        model.selectedImage != null
            ? Image.file(File(model.selectedImage!.path))
            : IconButton(
                icon: const Icon(Icons.add_a_photo),
                onPressed: () => model.pickImage(),
              ),
      ],
    );
  }

  Widget _buildGallerySection(SendPostViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Galerim"),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.photo_camera),
              onPressed: () => model.openCamera(),
            ),
            IconButton(
              icon: const Icon(Icons.photo_library),
              onPressed: () => model.pickMultipleImages(),
            ),
          ],
        ),
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
                  // final xFile = XFile(image.relativePath ?? '');
                  final isSelected = model.selectedGalleryImages
                      .where((img) => img.name == image.title)
                      .toList();

                  if (isSelected.length > 0) {
                    return GestureDetector(
                      onTap: () {
                        model.updateSelectedImage(image);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.green, width: 10.0)),
                        child: ColorFiltered(
                          colorFilter: isSelected.length > 0
                              ? ColorFilter.mode(Colors.grey.withOpacity(0.6),
                                  BlendMode.srcATop)
                              : const ColorFilter.mode(
                                  Colors.transparent, BlendMode.multiply),
                          child: FutureBuilder<Uint8List?>(
                            future: image.thumbnailData,
                            builder: (context, snapshot) {
                              final bytes = snapshot.data;
                              if (bytes == null) {
                                return const CircularProgressIndicator();
                              }
                              return Image.memory(bytes, fit: BoxFit.cover);
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        model.updateSelectedImage(image);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: null,
                        ),
                        child: ColorFiltered(
                          colorFilter: isSelected.length > 0
                              ? ColorFilter.mode(Colors.grey.withOpacity(0.6),
                                  BlendMode.srcATop)
                              : const ColorFilter.mode(
                                  Colors.transparent, BlendMode.multiply),
                          child: FutureBuilder<Uint8List?>(
                            future: image.thumbnailData,
                            builder: (context, snapshot) {
                              final bytes = snapshot.data;
                              if (bytes == null) {
                                return const CircularProgressIndicator();
                              }
                              return Image.memory(bytes, fit: BoxFit.cover);
                            },
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
      ],
    );
  }
}
