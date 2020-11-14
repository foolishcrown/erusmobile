import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/resources/api.dart';
import 'package:erusmobile/scr/resources/authorize_token_store.dart';

class CandidateRepository {
  ///Call api get candidates by employee id
  final _candidateApiProvider = CandidateApiProvider();

  Future<ItemCandidateModel> fetchAllCandidates(
          {int pageNum, int empId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _candidateApiProvider
                  .fetchCandidateList(
                      pageNum: pageNum,
                      empID: empId,
                      authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));

  Future<Candidate> fetchCandidateById({int canId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _candidateApiProvider
                  .fetchCandidateById(
                      canId: canId, authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));

  Future<bool> updateCandidateById({Candidate candidate, int empId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _candidateApiProvider
                  .fetchCandidateUpdate(
                      empID: empId,
                      newCandidate: candidate,
                      authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));

  ///Call api get skills by candidate id
  final _candidateSkillApiProvider = CandidateSkillApiProvider();

  Future<ItemCandidateSkillModel> fetchSkillsByCandidate(int canId) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _candidateSkillApiProvider
                  .fetchCandidateSkillList(
                      canID: canId,
                      numpage: 1,
                      authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));
}

class JobRepository {
  ///Call api get all jobs by company id
  final _jobsApiProvider = JobApiProvider();

  Future<ItemJobModel> fetchAllJobsByCompany(
          {int numPage, int companyId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _jobsApiProvider
                  .fetchJobList(
                      companyId: companyId,
                      pageNum: numPage,
                      authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));
}

class LoginRepository {
  ///Call api post and get authorize token
  final _loginApiProvider = LoginApiProvider();

  Future<String> fetchAuthorizeToken({String idToken}) =>
      _loginApiProvider.fetchAuthorizeToken(idToken: idToken);

  ///call api post and get exist account status
  Future<bool> fetchExistStatusAccount({String email}) =>
      _loginApiProvider.fetchStatusExistAccount(email: email);

  final _employeeApiProvider = EmployeeApiProvider();

  Future<EmpAccount> fetchEmpAccount(String email) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _employeeApiProvider
                  .fetchEmpAccount(
                      email: email, authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));
}
