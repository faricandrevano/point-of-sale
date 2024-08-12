part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class ProductAdded extends ProductEvent {
  const ProductAdded(this.data);
  final ProductModel data;
  @override
  List<Object> get props => [data];
}

final class ProductDelete extends ProductEvent {}

final class ProductPickedImage extends ProductEvent {}

final class ProductRemoveImage extends ProductEvent {
  const ProductRemoveImage(this.index);
  final int index;
  @override
  List<Object> get props => [index];
}
