import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mobile2/home/data/models/name_model_db/name_model.dart';
import 'package:mobile2/resources/data_state.dart';

import '../repository/name_repository.dart';

part 'all_name_status.dart';

part 'add_name_status.dart';

part 'delete_name_status.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final NameRepository repository;

  HomeCubit(this.repository)
      : super(HomeState(
          AllNameInit(),
          AddNameInit(),
          DeleteNameInit(),
        ));

  /// get all
  void getAllName() async {
    emit(state.copyWith(newAllNameStatus: AllNameLoading()));
    final DataState dataState = await repository.getAllNameDB();

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          newAllNameStatus: AllNameCompleted<List<NameModel>>(dataState.data),
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(newAllNameStatus: AllNameError(dataState.message!)));
    }
  }

  /// add

  void addName(NameModel name) async {
    print("555555");
    emit(state.copyWith(newAddNameStatus: AddNameLoading()));
    final DataState dataState = await repository.addName(name);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          newAddNameStatus: AddNameCompleted<int>(dataState.data),
        ),
      );
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
          newAddNameStatus: AddNameError(dataState.message!)));
    }
  }
/// delete
  void deleteName(int index) async {
    emit(state.copyWith(newDeleteNameStatus: DeleteNameLoading()));
    final DataState dataState = await repository.delete(index);

    if (dataState is DataSuccess) {
      emit(
        state.copyWith(
          newDeleteNameStatus: DeleteNameCompleted<int>(dataState.data),
        ),
      );
      getAllName();
    }

    if (dataState is DataFailed) {
      emit(state.copyWith(
          newDeleteNameStatus: DeleteNameError(dataState.message!)));
    }
  }


  void changeColor(Color? color){
    emit(state.copyWith(newColor: color));
  }

}
