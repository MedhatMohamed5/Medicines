class Customer {
  static const kCustomer = 'customers';
  final String id;
  final String name;
  final String phone;

  final double balanceAmt;
  final double purchasedAmt;
  final double paidAmt;

  Customer({
    this.id,
    this.name,
    this.phone,
    this.balanceAmt,
    this.paidAmt,
    this.purchasedAmt,
  });

  Customer copyWith({
    String id,
    String name,
    String phone,
    double balanceAmt,
    double purchasedAmt,
    double paidAmt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      balanceAmt: balanceAmt ?? this.balanceAmt,
      purchasedAmt: purchasedAmt ?? this.purchasedAmt,
      paidAmt: paidAmt ?? this.paidAmt,
    );
  }

  factory Customer.fromMap(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      balanceAmt: double.parse(json['balanceAmt'].toString()) ?? 0.0,
      purchasedAmt: double.parse(json['purchasedAmt'].toString()) ?? 0.0,
      paidAmt: double.parse(json['paidAmt'].toString()) ?? 0.0,
    );
  }
}
