import 'package:flutter/material.dart';
import 'package:oua_flutter33/common/helpers/toast_functions.dart';
import 'package:oua_flutter33/ui/cart/cart_list_view_model.dart';
import 'package:stacked/stacked.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartListViewModel>.reactive(
      viewModelBuilder: () => CartListViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          
          automaticallyImplyLeading: false,
           title: const Padding(
             padding: EdgeInsets.all(12.0),
             child: Text('Sepetim',
              style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
             ),
                       
                       ),
           ),
        ),
        body: model.cartItems.isEmpty
            ? const Center(
            
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_cart_outlined,
                    size:40,
                    ),
                    SizedBox(height: 8,),
                    Text('Sepetiniz boş',
                    style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                               ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: model.cartItems.length,
                itemBuilder: (context, index) {
                  final item = model.cartItems[index];
                  return SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color:const Color(0xFFD3F4BF),
                          width: 1 ),
                      ),
                      child: ListTile(
                        leading: Image.network(item.mainImageUrl),
                        title: Text(item.name),
                        subtitle: Text('₺${item.price.toString()}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle,
                          color: Color(0xFFD3F4BF),
                          ),
                          onPressed: () {
                            model.removeItem(item);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SafeArea(
                child: Text(
                  'Toplam: ₺${model.totalPrice.toString()}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SafeArea(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color(0xFFD3F4BF), 
                  ),
                  onPressed: () {
                     model.cartItems.isEmpty?MyToast.showInfoBox(context, "Lütfen Sepetinize Bir Şeyler Ekleyiniz !"):
                    MyToast.showInfoBox(context, "Satın Alınıyor....");
                  },
                  child: const Text('Satın Al',style: TextStyle(color:Colors.black,),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
