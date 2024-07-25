// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/ui/product/product-detail/product_view_model.dart';
import 'package:stacked/stacked.dart';

class ProductDetailView extends StatelessWidget {
  final String productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    
    return ViewModelBuilder<ProductViewModel>.reactive(
      viewModelBuilder: () => ProductViewModel(),
      onModelReady: (model) async => await model.fetchProductDetails(productId),
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
                                style: TextStyle(color: Color(0xFF6EDB2A),),),
                            SizedBox(width: 16),
                        /*  FutureBuilder<User?>(
                              future: getIt<ProductService>()
                                  .getUserByProductId(productId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text("Hata: ${snapshot.error}");
                                } else if (!snapshot.hasData) {
                                  return Text("Kullanıcı Bulunamadı");
                                } else {
                                  final user = snapshot.data!;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatView(
                                            receiverUser: user,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text('İletişim',
                                        style: TextStyle(color: Color(0xFF6EDB2A))),
                                  );
                                }
                              },
                            ), */
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
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.editProductView,
                                    arguments: EditProductViewArguments(
                                      product: model.product!,
                                    ),
                                  ).then((_) {
                                    Future.delayed(const Duration(milliseconds: 500), () {
                                      model.fetchProductDetails(productId);
                                    });
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed:() {model.deleteProduct(productId);}
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:  const Color(0xFF6EDB2A),
                                ),
                                onPressed: () => model.sendMessage(context, productId),
                                child: const Text('Mesaj Gönder'),
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
