class ProductCartSaved {
  final int? productId;
  final int? quantity;

  ProductCartSaved({required this.productId, required this.quantity});

  factory ProductCartSaved.fromJson(Map<String, dynamic> json) =>
      ProductCartSaved(
        productId: json['productId'],
        quantity: json['quantity'],
      );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'quantity': quantity,
  };
}
