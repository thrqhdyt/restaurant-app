enum Status { loading, noData, hasData, error }

class ResultState<T> {
  final Status status;
  final T? data;
  final String? message;

  ResultState({required this.status, this.data, this.message});
}
