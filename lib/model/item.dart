
class Item {
  String imagePath;
  double price;
  String location;
  String name;
  Item({required this.imagePath, required this.name,required this.price,this.location="Main brach"});
}
 final List<Item> items = [
    Item(name:"product 1" ,imagePath: "assets/images/watch12.jpg",price: 12.99,location:"Joy shop"),
    Item(name:"product 2" ,imagePath: "assets/images/watch3.jpg", price: 12.99),
    Item(name:"product 3" ,imagePath: "assets/images/watch4.jpg", price: 12.99),
    Item(name:"product 4" ,imagePath: "assets/images/watch5.jpg", price: 12.99),
    Item(name:"product 5",imagePath: "assets/images/watch6.jpg", price: 12.99),
    Item(name:"product 6" ,imagePath: "assets/images/watch8.jpg", price: 12.99),
    Item(name:"product 7" ,imagePath: "assets/images/watch9.jpg", price: 12.99),
    Item(name:"product 8" ,imagePath: "assets/images/watch11.jpg", price: 12.99)
  ];