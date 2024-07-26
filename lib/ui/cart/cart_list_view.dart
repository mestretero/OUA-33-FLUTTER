import 'package:flutter/material.dart';
import 'package:oua_flutter33/app/app.router.dart';
import 'package:oua_flutter33/ui/cart/cart_list_view_model.dart';
import 'package:stacked/stacked.dart';

class CartListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartListViewModel>.reactive(
      viewModelBuilder: () => CartListViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
                  model.navigationService.navigateTo(Routes.homeView);
            },
            icon:SizedBox(
              width: 40,
              height: 40,
              child: Icon( Icons.keyboard_arrow_left_rounded,)),
            color:Color(0xFF6EDB2A), 

          ),
           title: Text('Sepetim',
            style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
           ),
          
          ),
        ),
        body: model.cartItems.isEmpty
            ? Center(
                child: Text('Sepetiniz boş',
                style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
           ),
                ),
              )
            : ListView.builder(
                itemCount: model.cartItems.length,
                itemBuilder: (context, index) {
                  final item = model.cartItems[index];
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color:Color(0xFFD3F4BF),
                          width: 1 ),
                      ),
                      child: ListTile(
                        leading: Image.network(item.mainImageUrl),
                        title: Text(item.name),
                        subtitle: Text('₺${item.price.toString()}'),
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle,
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              SafeArea(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:Color(0xFFD3F4BF), 
                  ),
                  onPressed: () {
                    
                  },
                  child: Text('Satın Al',style: TextStyle(color:Colors.black,),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
