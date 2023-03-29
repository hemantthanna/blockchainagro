class Transaction {
  final double price;
  final DateTime time;
  final String buyer;
  final String seller;
  final String productName;
  final String productDescription;
  final int productQuality;

  Transaction(this.price, this.time, this.buyer, this.seller, this.productName, this.productDescription, this.productQuality);

  Map<String, dynamic> toJson() => {
        'price': price,
        'time': time.toIso8601String(),
        'buyer': buyer,
        'seller': seller,
        'productName': productName,
        'productDescription':productDescription,
        'productQuality':productQuality
      };

  factory Transaction.fromJson(Map<String, dynamic> jsondata) {
    return Transaction(jsondata["price"], jsondata["time"], jsondata["buyer"],
        jsondata["seller"], jsondata["productName"], jsondata["productDescription"], jsondata["productQuality"]);
  }
}
