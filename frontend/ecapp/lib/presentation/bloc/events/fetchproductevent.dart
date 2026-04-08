class Fetchproductevent {}

class FetchproductDataevent extends Fetchproductevent{
  final String id;
  FetchproductDataevent({
    required this.id
  });
}