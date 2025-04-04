part of 'home_cubit.dart';

abstract class DeleteNameStatus<T> {}

class DeleteNameInit extends DeleteNameStatus {}

class DeleteNameLoading extends DeleteNameStatus {}

class DeleteNameCompleted<T> extends DeleteNameStatus {
  final T data;

  DeleteNameCompleted(this.data);
}

class DeleteNameError extends DeleteNameStatus {
  final String message;

  DeleteNameError(this.message);
}
