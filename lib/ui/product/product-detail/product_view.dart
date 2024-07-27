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
      // ignore: deprecated_member_use
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
                ? const Center(
                    child: Text(
                      "Ürün Yaratıcısı Tarafından Kaldırıldı",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              model.product!.mainImageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                           /*  Positioned(
                              top: 10,
                              left: 10,
                              child: IconButton(
                                onPressed: () => model.navigationService.back,
                                icon: Container(
                                  height: 36,
                                  width: 36,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(0.4),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ), */
                            if (model.product!.uid ==
                                model.authServices.user!.uid)
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          model.deleteProduct(productId),
                                      icon: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(0.4),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                        child: Icon(
                                          Icons.delete_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => model.archiveProduct(),
                                      icon: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(0.4),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                        child: Icon(
                                          Icons.archive_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.editProductView,
                                          arguments: EditProductViewArguments(
                                            product: model.product!,
                                          ),
                                        ).then((_) {
                                          Future.delayed(
                                              const Duration(milliseconds: 500),
                                              () {
                                            model
                                                .fetchProductDetails(productId);
                                          });
                                        });
                                      },
                                      icon: Container(
                                        height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary
                                              .withOpacity(0.4),
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(999),
                                        ),
                                        child: Icon(
                                          Icons.edit_rounded,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  model.product!.name,
                                  style: const TextStyle(
                                      fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              if(model.product!.uid ==
                                model.authServices.user!.uid)
                                 Column(
                                  children: [
                                    const Icon(Icons.favorite,
                                    color: Color(0xFF6EDB2A),
                                ),
                                Text("${model.favoriteCount}",
                                style: const TextStyle(color: Color(0xFF6EDB2A),
                                fontSize: 16,
                                ),
                                ),
                                  ],
                                ),
                             
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Text(
                              'Ürün Açıklaması',
                              style: TextStyle(
                                color: Color(0xFF6EDB2A),
                              ),
                            ),
                            SizedBox(width: 16),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(model.product!.description),
                        const SizedBox(height: 16),
                        if (model.product!.uid != model.authServices.user!.uid)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '₺${model.product!.price}',
                                style: const TextStyle(
                                  color: Color(0xFF6EDB2A),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFFD3F4BF),
                                    width: 2,
                                  ),
                                ),
                                onPressed: () {
                                  model.addToCart();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: const Color(0xFFD3F4BF),
                                      content: Text(
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        "${model.product!.name} sepete eklendi",
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sepete Ekle',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFFD3F4BF),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD3F4BF),
                                ),
                                onPressed: () =>
                                    model.sendMessage(context, productId),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.chat,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Mesaj',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
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

