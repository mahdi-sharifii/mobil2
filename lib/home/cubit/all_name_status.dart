part of 'home_cubit.dart';

abstract class AllNameStatus<T> {}

class AllNameInit extends AllNameStatus {}

class AllNameLoading extends AllNameStatus {}

class AllNameCompleted<T> extends AllNameStatus {
  final T data;

  AllNameCompleted(this.data);
}

class AllNameError extends AllNameStatus {
  final String message;

  AllNameError(this.message);
}
