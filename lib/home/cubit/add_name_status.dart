part of 'home_cubit.dart';

abstract class AddNameStatus<T> {}

class AddNameInit extends AddNameStatus {}

class AddNameLoading extends AddNameStatus {}

class AddNameCompleted<T> extends AddNameStatus {
  final T data;

  AddNameCompleted(this.data);
}

class AddNameError extends AddNameStatus {
  final String message;

  AddNameError(this.message);
}
