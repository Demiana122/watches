
import 'package:amigurumi_art/model/item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier{
 List selectedProducts=[];
 double price=0;

  get myName => null;
add(Item product){
  selectedProducts.add(product);
  price+=product.price.round();
 notifyListeners();
}
delete(Item product){
  selectedProducts.remove(product);
    price-=product.price.round();
     notifyListeners();
}
get itemCount{
  return selectedProducts.length;
}
}