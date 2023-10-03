import 'package:equatable/equatable.dart';

class Response extends Equatable {
  final double totalSpent;

  final double shoppingTotal;
  final int shoppingTransactions;
  final double shoppingPct;

  final double wellnessTotal;
  final int wellnessTransactions;
  final double wellnessPct;

  final double transportTotal;
  final int transportTransactions;
  final double transportPct;

  final double barsAndResturantTotal;
  final int barsAndResturantTransactions;
  final double barsAndResturantPct;

  final double subscriptionsTotal;
  final int subscriptionsTransactions;
  final double subscriptionsPct;

  const Response({
    required this.totalSpent,
    required this.shoppingTotal,
    required this.shoppingTransactions,
    required this.shoppingPct,
    required this.wellnessTotal,
    required this.wellnessTransactions,
    required this.wellnessPct,
    required this.transportTotal,
    required this.transportTransactions,
    required this.transportPct,
    required this.barsAndResturantTotal,
    required this.barsAndResturantTransactions,
    required this.barsAndResturantPct,
    required this.subscriptionsTotal,
    required this.subscriptionsTransactions,
    required this.subscriptionsPct,
  });

  @override
  List<Object?> get props => [
        totalSpent,
        shoppingTotal,
        shoppingTransactions,
        shoppingPct,
        wellnessTotal,
        wellnessTransactions,
        wellnessPct,
        transportTotal,
        transportTransactions,
        transportPct,
        barsAndResturantTotal,
        barsAndResturantTransactions,
        barsAndResturantPct,
        subscriptionsTotal,
        subscriptionsTransactions,
        subscriptionsPct,
      ];
}
