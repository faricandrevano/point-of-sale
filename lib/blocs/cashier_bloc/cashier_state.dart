part of 'cashier_bloc.dart';

sealed class CashierState extends Equatable {
  const CashierState();

  @override
  List<Object> get props => [];
}

final class CashierInitial extends CashierState {}

final class CashierLoadedProduct extends CashierState {
  const CashierLoadedProduct(this.product);
  final List<ProductModel> product;
  @override
  List<Object> get props => [product];
}

final class CashierEmptyProduct extends CashierState {}

final class CashierFailed extends CashierState {
  const CashierFailed(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
