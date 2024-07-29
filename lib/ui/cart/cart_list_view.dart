import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/scaler.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/common/widgets/my_appbar.dart';
import 'package:oua_flutter33/ui/cart/cart_list_view_model.dart';
import 'package:stacked/stacked.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartListViewModel>.reactive(
      viewModelBuilder: () => CartListViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyAppBarWidget(
                  isBackButton: false,
                  title: "Sepetim",
                  routeName: "",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SafeArea(
                      child: Text(
                        'Toplam: ₺${model.totalPrice.toString()}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SafeArea(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD3F4BF),
                          elevation: 0,
                        ),
                        onPressed: () {
                          model.cartItems.isEmpty
                              ? MyToast.showErrorTost(context,
                                  "Lütfen Sepetinize Bir Şeyler Ekleyiniz !")
                              : showGifDialog(context);
                        },
                        child: Text(
                          'Satın Al',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                model.cartItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 128,
                            ),
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 56,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Sepetinizde Ürün Yok',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Şu an sepetinizde herhangi bir ürün bulunmuyor. Alışveriş yapmaya başlamak için mağazamızı ziyaret edin!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: Scaler.height(1, context),
                        child: ListView.builder(
                          itemCount: model.cartItems.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final item = model.cartItems[index];

                            return Container(
                              margin: const EdgeInsets.only(bottom: 8, top: 8),
                              padding: const EdgeInsets.all(8),
                              width: Scaler.width(0.75, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 72,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(item.mainImageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: Scaler.width(0.55, context),
                                        child: Text(
                                          item.name,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '₺${item.price.toString()}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 4),
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: IconButton(
                                      style: IconButton.styleFrom(
                                          backgroundColor: Colors.red.shade100,
                                          padding: const EdgeInsets.all(0)),
                                      icon: Transform.rotate(
                                        angle: 27.5,
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                      ),
                                      onPressed: () {
                                        model.removeItem(item);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showGifDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 300,
            height: 300,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/online-shopping.png",
                  fit: BoxFit.cover,
                  width: 72,
                  height: 72,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const SizedBox(height: 8),
                Text(
                  "Satın alınıyor...",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Close the dialog after 3 seconds
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
    });
  }
}
