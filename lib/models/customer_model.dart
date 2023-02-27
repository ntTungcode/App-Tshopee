class CustomerModel {
  String? name;
  String? password;
  String? email;
  String? id;
  String? imageUrl;
  String? cartCount;
  String? orderCount;
  String? wishlistCount;

  CustomerModel(
      {this.name,
        this.password,
        this.email,
        this.id,
        this.imageUrl,
        this.cartCount,
        this.orderCount,
        this.wishlistCount});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    password = json['password'];
    email = json['email'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    cartCount = json['cart_count'];
    orderCount = json['order_count'];
    wishlistCount = json['wishlist_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['password'] = password;
    data['email'] = email;
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['cart_count'] = cartCount;
    data['order_count'] = orderCount;
    data['wishlist_count'] = wishlistCount;
    return data;
  }
}
