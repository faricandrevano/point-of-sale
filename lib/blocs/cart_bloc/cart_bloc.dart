import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pos/data/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    CollectionReference refCart =
        FirebaseFirestore.instance.collection('carts');
    WriteBatch batch = FirebaseFirestore.instance.batch();

    on<CartEvent>((event, emit) async {
      if (event is CartItemAdd) {
        emit(CartLoading());
        try {
          await refCart.add(event.items.toMap());
          emit(const CartSuccess('berhasil tambah keranjang'));
        } catch (e) {
          emit(const CartFailed('Gagal tambah Product'));
        }
      }
      if (event is CartItemRemove) {
        try {
          await refCart.doc(event.id).delete();
        } catch (e) {
          emit(const CartFailed('Gagal menghapus product'));
        }
      }
      if (event is GetProductCart) {
        try {
          QuerySnapshot snapshot = await refCart.get();
          if (snapshot.docs.isNotEmpty) {
            List<CartModel> cartData = snapshot.docs.map((data) {
              Map<String, dynamic> dataResult =
                  data.data() as Map<String, dynamic>;
              dataResult['id'] = data.id;
              return CartModel.fromJson(dataResult);
            }).toList();
            emit(CartLoaded(cartData));
          } else {
            emit(CartEmpty());
          }
        } catch (e) {
          emit(const CartFailed('Gagal Load keranjang'));
        }
      }
    });
    on<CartUpdateQty>((event, emit) async {
      try {
        await refCart.doc(event.id).update({'qty': event.qty});
        emit(const CartSuccess('Sukses Update Keranjang'));
      } catch (e) {
        emit(const CartFailed('Gagal update keranjang'));
      }
    });
    on<CartItemRemove>((event, emit) async {
      try {
        await refCart.doc(event.id).delete();
        emit(const CartSuccess('Sukses hapus item Keranjang'));
      } catch (e) {
        emit(const CartFailed('Gagal hapus item keranjang'));
      }
    });
    on<CartItemEmpty>((event, emit) async {
      try {
        QuerySnapshot snapshot = await refCart.get();
        for (DocumentSnapshot doc in snapshot.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
        emit(const CartSuccess('Sukses hapus item Keranjang'));
      } catch (e) {
        emit(const CartFailed('Gagal hapus item keranjang'));
      }
    });
  }
}
