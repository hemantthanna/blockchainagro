
class Transaction {
  final String id;
  final double price;
  final DateTime time;
  final String buyer;
  final String seller;

  Transaction(this.id, this.price, this.time, this.buyer, this.seller);
  
  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'time': time.toIso8601String(),
        'buyer': buyer,
        'seller': seller
      };

  factory Transaction.fromJson(Map<String, dynamic> jsondata) {
    return Transaction(jsondata["id"], jsondata["price"], jsondata["time"],
        jsondata["buyer"], jsondata["seller"]);
  }
}
