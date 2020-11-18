import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class EmpAccountBloc {
  final _empAccount = EmpAccount(null);
  final _loginRepository = LoginRepository();
  final _jobRepository = JobRepository();
  final _empAccountFetcher = PublishSubject<EmpAccount>();
  final _empRankFetcher = PublishSubject<EmpAccount>();
  final _quantityJobFetcher = PublishSubject<int>();

  PublishSubject<EmpAccount> get empAccount => _empAccountFetcher.stream;

  PublishSubject<EmpAccount> get empRankAccount => _empRankFetcher.stream;

  PublishSubject<int> get quantityJob => _quantityJobFetcher.stream;

  getEmpAccount() async {
    EmpAccount empAccount =
        await _empAccount.loadFormSharedPref().catchError((e) {
      throw e;
    });
    _empAccountFetcher.sink.add(empAccount);
  }

  Future getEmpRank(int empId) async {
    EmpAccount empAccount =
        await _loginRepository.fetchEmpRank(empId).catchError((e) {
      throw e;
    });
    _empRankFetcher.sink.add(empAccount);
  }

  Future getQuantityJob(int empId) async {
    await _loginRepository
        .fetchCompanyByEmpId(empId)
        .then((value) async => await _jobRepository
            .fetchQuantityJobByCompId(companyId: value.id)
            .then((tmp) => _quantityJobFetcher.sink.add(tmp)))
        .catchError((e) {
      throw e;
    });
  }

  dispose() {
    _empAccountFetcher.close();
    _empRankFetcher.close();
    _quantityJobFetcher.close();
  }
}
