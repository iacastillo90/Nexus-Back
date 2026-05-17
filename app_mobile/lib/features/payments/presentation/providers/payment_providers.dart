import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../core/network/dio_provider.dart';
import '../data/datasources/payment_remote_datasource.dart';
import '../domain/repositories/payment_repository.dart';

part 'payment_providers.g.dart';

@riverpod
PaymentRemoteDataSource paymentRemoteDataSource(PaymentRemoteDataSourceRef ref) {
  return PaymentRemoteDataSource(ref.watch(networkDioProvider));
}

@riverpod
PaymentRepository paymentRepository(PaymentRepositoryRef ref) {
  return PaymentRepositoryImpl(
    remoteDataSource: ref.watch(paymentRemoteDataSourceProvider),
  );
}

@riverpod
class PaymentController extends _$PaymentController {
  @override
  FutureOr<void> build() async {
    await ref.read(paymentRepositoryProvider).initPayments();
  }

  Future<bool> checkoutWithStripe(double amount, String currency) async {
    state = const AsyncValue.loading();
    final result = await ref.read(paymentRepositoryProvider).checkoutWithStripe(amount, currency);
    state = const AsyncValue.data(null);
    return result;
  }

  Future<bool> subscribe(Package package) async {
    state = const AsyncValue.loading();
    final result = await ref.read(paymentRepositoryProvider).purchaseSubscription(package);
    state = const AsyncValue.data(null);
    return result;
  }
}
