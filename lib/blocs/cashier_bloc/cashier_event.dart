part of 'cashier_bloc.dart';

sealed class CashierEvent extends Equatable {
  const CashierEvent();

  @override
  List<Object> get props => [];
}

final class CashierFetchProduct extends CashierEvent {}
