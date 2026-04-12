class NoDataException implements Exception{
  String exception;
  NoDataException({
    this.exception = 'no data'
  });

  factory NoDataException.setException(String message){
    return NoDataException(exception: message);
  }
}