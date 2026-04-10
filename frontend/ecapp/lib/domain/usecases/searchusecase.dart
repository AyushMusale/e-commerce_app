import 'package:ecapp/data/models/searchlist.dart';
import 'package:ecapp/data/repositires/searchrepo.dart';

class SearchUsecase {
  SearchRepo searchRepo;
  SearchUsecase({required this.searchRepo});

  Future<Searchlist> execute(String keyword) async {
    return await searchRepo.getSearch(keyword);
  }
}
