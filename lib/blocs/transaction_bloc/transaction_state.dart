part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitial extends TransactionState {}

final class TransactionSuccess extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionFailed extends TransactionState {
  const TransactionFailed(this.error);
  final String error;
}

final class TransactionEmpty extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  const TransactionLoaded(this.data);
  final List<TransactionModel> data;
  @override
  List<Object> get props => [data];
}
