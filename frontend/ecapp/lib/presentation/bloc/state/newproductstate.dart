class Newproductstate{}
class NewproductstateSuccess extends Newproductstate{
  String message;
  NewproductstateSuccess({required this.message});
}
class NewproductstateFailed extends Newproductstate{
  String message;
  NewproductstateFailed({required this.message});
}
class NewproductstatePending extends Newproductstate{}
class NewproductstateInitial extends Newproductstate{}
class NewproductstateUnaunthenticated extends Newproductstate{}
