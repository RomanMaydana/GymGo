class Plan {
  final String plan;
  final double price;
  final int qty;
  final String planId;

  Plan({this.plan, this.price, this.qty, this.planId});

  factory Plan.fromMap(Map doc) {
    Plan plan = Plan(
        plan: doc['plan'],
        price: doc['price'].toDouble(),
        qty: doc['qty'].toInt(),
        planId: doc['planId']);
    return plan;
  }
}
