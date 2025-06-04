class Products {
  final int productId;
  final int quantity;

  
  Products({
    required this.productId,
    required this.quantity,
  });
}

class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<Products> products;
  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });
  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'] ?? 0,
      userId: json['userId'] ?? 0,
      date: DateTime.parse(json['date'] ?? DateTime.now().toString()),
      products: (json['products'] as List)
          .map((product) => Products(
                productId: product['productId'] ?? 0,
                quantity: product['quantity'] ?? 0,
              ))
          .toList(),
    );
  }


}
