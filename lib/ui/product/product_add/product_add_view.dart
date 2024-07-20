// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/widgets/app_button.dart';
import 'package:oua_flutter33/common/widgets/category_selectors/category_selector_view.dart';
import 'package:oua_flutter33/common/widgets/currency_input.dart';
import 'package:oua_flutter33/common/widgets/multi_media.dart';
import 'package:oua_flutter33/common/widgets/my_appbar.dart';
import 'package:oua_flutter33/common/widgets/my_texfield.dart';
import 'package:oua_flutter33/ui/product/product_add/product_add_view_model.dart';
import 'package:stacked/stacked.dart';

class ProductAddView extends StatelessWidget {
  const ProductAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductAddViewModel>.reactive(
      viewModelBuilder: () => ProductAddViewModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, widget) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  MyAppBarWidget(
                    isBackButton: false,
                    title: "Ürün Bilgileri",
                    routeName: "",
                  ),
                  Form(
                    key: model.formKey,
                    child: Column(
                      children: [
                        // Çoklu Resim yükleme
                        const PhotoPickerScreen(),

                        //Title
                        MyTextField(
                          controller: model.titleController,
                          name: "El Emeğinizin İsmi",
                          hintText:
                              "Ürün başlığını ayrıntılı olarak giriniz. Örn: Kupa Kıyafeti",
                          inputType: TextInputType.text,
                          isTextArea: false,
                        ),

                        //Short Description
                        MyTextField(
                          controller: model.shortDescController,
                          name: "El Emeğinizin Kısa Ürün Açıklaması",
                          hintText:
                              "Ürünü bir cümle ile açıkla. Örn: Doğal iple örülmüş Kupa kıyafeti",
                          inputType: TextInputType.text,
                          isTextArea: false,
                        ),

                        //Description
                        MyTextField(
                          controller: model.descController,
                          name: "El Emeğinizin Ürün Açıklaması",
                          hintText:
                              "Ürünü bir kaç cümle ile açıkla. Örn: Doğal iple kullanılmıştır. 330ml’lik kupalar için idealdir.",
                          inputType: TextInputType.text,
                          isTextArea: true,
                        ),

                        //Kategori
                        const CategorySelector(),

                        //Fiyat & Para Birimi
                        CurrencyInputWidget(
                          title: 'Enter Price',
                          selectedCurrency: model.selectedCurrency,
                          priceController: model.priceController,
                          onChanged: (currency, price) {
                            // Burada view model ile iletişim sağlanabilir
                            // model.setAmount(1);
                            // model.setPrice(price as double);
                            print(
                                'Selected currency: $currency, Price: $price');
                          },
                        ),

                        const SizedBox(
                          height: 24,
                        ),

                        //Ekleme Butonu
                        AppButton(
                          text: "Ürünümü Ekle",
                          onTap: () {
                            model.addProduct();
                          },
                        ),

                        //Bottom Space
                        const SizedBox(
                          height: 64,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
