part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoadedProduct extends CartState {
  const CartLoadedProduct(this.product);
  final List<ProductModel> product;
  @override
  List<Object> get props => [product];
}

final class CartEmptyProduct extends CartState {}

final class CartFailed extends CartState {
  const CartFailed(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
