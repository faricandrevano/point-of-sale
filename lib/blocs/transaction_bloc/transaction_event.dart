part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class TransactionAdded extends TransactionEvent {
  const TransactionAdded(this.trans);
  final TransactionModel trans;
}

final class TransactionFetch extends TransactionEvent {}
