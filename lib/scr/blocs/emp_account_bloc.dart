import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class EmpAccountBloc {
  final _repository = Repository();
  final _empAccountFetcher = PublishSubject<ItemEmpAccountModel>();

  PublishSubject<ItemEmpAccountModel> get allSkill => _empAccountFetcher.stream;

  fetchAllEmpAccount({int numpage}) async {
    ItemEmpAccountModel empAccountModel =
        await _repository.fetchAllEmpAccounts(numpage: numpage);
    _empAccountFetcher.sink.add(empAccountModel);
  }

  dispose() {
    _empAccountFetcher.close();
  }
}
