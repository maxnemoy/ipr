class UnsupportedTypeError extends Error {}

extension Diff on Object {
  operator >(diff) {
    switch (diff.runtimeType) {
      case const (num):
        return (this as num) > (diff as num);
      default:
        throw UnsupportedTypeError();
    }
  }

  operator <(diff) {
    switch (diff.runtimeType) {
      case const (num):
        return (this as num) < (diff as num);
      default:
        throw UnsupportedTypeError();
    }
  }
}
