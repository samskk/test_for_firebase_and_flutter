class DailySpecial {
  final String description;
  final double price;

  DailySpecial({required this.description, required this.price});

  factory DailySpecial.fromRTDB(Map<String, dynamic> data) {
    return DailySpecial(
        description: data['description'] ?? 'drink',
        price: data['price'] ?? 0.0);
  }
  String fancyDescription() {
    return 'Today\'s special: A delicious $description for the low price of \$${price.toStringAsFixed(2)}';
  }
}
