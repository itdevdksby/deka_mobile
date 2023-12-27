
import 'failure_response.dart';

enum ResponseStatus {
  LOADING, DEFAULT, SUCCESS, FAILED
}

abstract class ResponseState<T> {
  final T? data;
  final FailureResponse? error;

  const ResponseState({this.data, this.error});
}

class ResponseDefault extends ResponseState {
  const ResponseDefault() : super(data: null, error: null);
}

class ResponseLoading extends ResponseState {
  const ResponseLoading() : super(data: null, error: null);
}

class ResponseSuccess<T> extends ResponseState<T> {
  const ResponseSuccess(T data) : super(data: data);
}

class ResponseFailed<T> extends ResponseState<T> {
  const ResponseFailed(FailureResponse error) : super(error: error);
}
