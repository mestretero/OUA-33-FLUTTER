// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/ui/product/product-detail/product_view_model.dart';
import 'package:stacked/stacked.dart';

class ProductDetailView extends StatelessWidget {
  final String productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
      viewModelBuilder: () => ProductViewModel(),
      onModelReady: (model) => model.fetchProductDetails(productId),
      builder: (context, model, widget) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: const [],
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : model.product == null
                ? const Text("Ürün Bulunamadı")
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(model.product!.mainImageUrl,
                            fit: BoxFit.cover),
                        const SizedBox(height: 16),
                        Text(
                          model.product!.name,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Text('Ürün Açıklaması',
                                style: TextStyle(color: Colors.green)),
                            SizedBox(width: 16),
                            Text('İletişim',
                                style: TextStyle(color: Colors.green)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(model.product!.description),
                        const SizedBox(height: 16),
                        Text(
                          '₺${model.product!.price}',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        if (model.product!.uid == model.authServices.user!.uid)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.archive),
                                onPressed: model.archiveProduct,
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: model.editProduct,
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: model.deleteProduct,
                              ),
                            ],
                          )
                        else
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: model.addToCart,
                                child: const Text('Sepete Ekle'),
                              ),
                              ElevatedButton(
                                onPressed: model.sendMessage,
                                child: const Text('Mesaj'),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
