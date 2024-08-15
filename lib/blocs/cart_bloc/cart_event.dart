part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class CartItemAdd extends CartEvent {
  const CartItemAdd(this.items);
  final CartModel items;
}

final class CartItemRemove extends CartEvent {
  const CartItemRemove(this.id);
  final String id;
}

final class CartItemEmpty extends CartEvent {}

final class CartUpdateQty extends CartEvent {
  final String id;
  final int qty;
  const CartUpdateQty({required this.id, required this.qty});
}

final class GetProductCart extends CartEvent {}
