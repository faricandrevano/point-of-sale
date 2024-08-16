import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos/data/models/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    CollectionReference transactionRef =
        FirebaseFirestore.instance.collection("transaction");
    CollectionReference refCart =
        FirebaseFirestore.instance.collection("carts");
    WriteBatch batch = FirebaseFirestore.instance.batch();

    on<TransactionEvent>((event, emit) async {
      if (event is TransactionAdded) {
        emit(TransactionLoading());
        try {
          await transactionRef.add(event.trans.toMap());
          QuerySnapshot snapshot = await refCart.get();
          for (DocumentSnapshot doc in snapshot.docs) {
            batch.delete(doc.reference);
          }
          await batch.commit();
          emit(TransactionSuccess());
        } catch (e) {
          print(e.toString());
          emit(const TransactionFailed("Gagal Menambahkan Transaksi"));
        }
      }
    });

    on<TransactionFetch>((event, emit) async {
      try {
        QuerySnapshot querySnapshot = await transactionRef.get();
        if (querySnapshot.docs.isEmpty) {
          emit(TransactionEmpty());
        } else {
          List<TransactionModel> productdata =
              await Future.wait(querySnapshot.docs.map((doc) async {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

            return TransactionModel.fromJson(data);
          }));
          emit(TransactionLoaded(productdata));
        }
      } catch (e) {
        print(e.toString());
        emit(const TransactionFailed('Gagal Load Product'));
      }
    });
  }
}
