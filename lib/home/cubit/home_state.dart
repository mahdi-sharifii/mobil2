part of 'home_cubit.dart';

class HomeState {
  AllNameStatus allNameStatus;
  AddNameStatus addNameStatus;
  DeleteNameStatus deleteNameStatus;
  Color? color;

  HomeState(this.allNameStatus, this.addNameStatus, this.deleteNameStatus,
      {this.color});

  HomeState copyWith({
    AllNameStatus? newAllNameStatus,
    AddNameStatus? newAddNameStatus,
    DeleteNameStatus? newDeleteNameStatus,
    Color? newColor,
  }) {
    return HomeState(
      newAllNameStatus ?? allNameStatus,
      newAddNameStatus ?? addNameStatus,
      newDeleteNameStatus ?? deleteNameStatus,
      color: newColor,
    );
  }
}
