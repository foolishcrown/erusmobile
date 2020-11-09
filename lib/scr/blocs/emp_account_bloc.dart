import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:rxdart/rxdart.dart';

class EmpAccountBloc {
  final _empAccount = EmpAccount(null);
  final _empAccountFetcher = PublishSubject<EmpAccount>();

  PublishSubject<EmpAccount> get empAccount => _empAccountFetcher.stream;

  getEmpAccount() async {
    EmpAccount empAccount =
        await _empAccount.loadFormSharedPref().catchError((e) {
      throw e;
    });
    _empAccountFetcher.sink.add(empAccount);
  }

  dispose() {
    _empAccountFetcher.close();
  }
}
