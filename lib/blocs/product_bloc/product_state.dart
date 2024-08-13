part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  const ProductSuccess({required this.message, required this.event});
  final String message;
  final ProductEvent event;
  @override
  List<Object> get props => [message];
}

final class ProductEmpty extends ProductState {}

final class ProductFailed extends ProductState {
  const ProductFailed(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}

final class ProductUploadData extends ProductState {
  const ProductUploadData(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}

final class ProductLoaded extends ProductState {
  const ProductLoaded(this.data);
  final List<ProductModel> data;
  @override
  List<Object> get props => [data];
}

final class ProductImageLoaded extends ProductState {
  const ProductImageLoaded(this.images);
  final List images;
  @override
  List<Object> get props => [images];
}

final class ProductImageUpdateLoaded extends ProductState {
  const ProductImageUpdateLoaded(this.images);
  final List images;
  @override
  List<Object> get props => [images];
}
