import 'package:flutter/material.dart';
import 'package:oua_flutter33/core/models/product_model.dart';
import 'package:oua_flutter33/ui/product/product-detail/product_view_model.dart';
import 'package:stacked/stacked.dart';

class EditProductView extends StatefulWidget {
  final Product product;

  const EditProductView({Key? key, required this.product}) : super(key: key);

  @override
  _EditProductViewState createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late double _price; // Ürün fiyatı için bir değişken ekleyin

  @override
  void initState() {
    super.initState();
    _name = widget.product.name;
    _description = widget.product.description;
    _price = widget.product.price; // Ürün fiyatını başlatın
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductViewModel>.reactive(
      viewModelBuilder: () => ProductViewModel(),
      onModelReady: (model) => model.fetchProductDetails(widget.product.id!),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ürünü Düzenle',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [],
          
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: _name,
                    decoration: const InputDecoration(
                      labelText: 'Ürün İsim',
                      contentPadding: const EdgeInsets.only(bottom: 16.0,top: 16),
                      labelStyle: TextStyle(color: Color(0xFF6EDB2A),fontSize: 16,fontWeight: FontWeight.w500,),
                       enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide (color:Color(0xFF6EDB2A),),
                      ),
                    ),
                    onSaved: (value) => _name = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir isim girin!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _description,
                    decoration: const InputDecoration(
                      labelText: 'Ürün Açıklaması',
                      contentPadding: const EdgeInsets.only(bottom: 16.0,top: 16),
                      labelStyle: TextStyle(color: Color(0xFF6EDB2A),fontSize: 16,fontWeight: FontWeight.w500,),
                       enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide (color:Color(0xFF6EDB2A),),
                      ),
                    ),
                    maxLines: 15,
                    onSaved: (value) => _description = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir açıklama girin!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _price.toString(), 
                    decoration: const InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 16.0,top: 16),
                      labelText: 'Fiyat',
                      labelStyle: TextStyle(color: Color(0xFF6EDB2A),fontSize: 16,fontWeight: FontWeight.w500,),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide (color:Color(0xFF6EDB2A),),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onSaved: (value) => _price = double.tryParse(value!) ?? 0.0,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir fiyat girin!';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Geçerli bir fiyat girin!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6EDB2A),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        model.updateProduct(Product(
                          id: widget.product.id,
                          uid: widget.product.uid,
                          name: _name,
                          description: _description,
                          shortDescription: widget.product.shortDescription,
                          mainImageUrl: widget.product.mainImageUrl,
                          price: _price, 
                          priceUnit: widget.product.priceUnit,
                          categoryId: widget.product.categoryId,
                          subCategoryId: widget.product.subCategoryId,
                          subSubCategoryId: widget.product.subSubCategoryId,
                          countOfFavored: widget.product.countOfFavored,
                          medias: widget.product.medias,
                          isActive: widget.product.isActive,
                          isArchive: widget.product.isArchive,
                          createDate: widget.product.createDate,
                        )).then((_) {
                          model.fetchProductDetails(widget.product.id!);
                          Navigator.pop(context, true); 
                        });
                      }
                    },
                    child: const Center(
                      child: Text("Kaydet"),
                    ),
                  ),
                  // Add more fields as needed
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
