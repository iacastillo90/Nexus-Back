import 'package:purchases_flutter/purchases_flutter.dart';
import '../data/datasources/payment_remote_datasource.dart';

abstract class PaymentRepository {
  Future<void> initPayments();
  Future<bool> checkoutWithStripe(double amount, String currency);
  Future<bool> purchaseSubscription(Package package);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> initPayments() async {
    return remoteDataSource.initPayments();
  }

  @override
  Future<bool> checkoutWithStripe(double amount, String currency) async {
    return remoteDataSource.checkoutWithStripe(amount, currency);
  }

  @override
  Future<bool> purchaseSubscription(Package package) async {
    return remoteDataSource.purchaseSubscription(package);
  }
}
