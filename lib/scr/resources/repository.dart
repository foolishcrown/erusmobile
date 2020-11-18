import 'package:erusmobile/scr/models/apply_model.dart';
import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/company_model.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/require_skill_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/models/skill_model.dart';
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

  Future<bool> deleteCandidateById({int canId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _candidateApiProvider
                  .deleteCandidateById(
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

  Future<bool> insertNewCandidate({Candidate candidate, int empId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _candidateApiProvider
                  .insertNewCandidate(
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

  final _requiredSkillApiProvider = RequiredSkillApiProvider();

  Future<ItemRequiredSkillModel> fetchSkillsByCandidate(
          {int jobId, int numpage}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _requiredSkillApiProvider
                  .fetchRequiredSkillList(
                      jobId: jobId,
                      numpage: numpage,
                      authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));
}

class SkillRepository {
  final _skillApiProvider = SkillApiProvider();

  Future<ItemSkillModel> fetchSkills(int numPage) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _skillApiProvider
                  .fetchSkills(
                      pageNum: numPage, authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));

  final _candidateSkillApiProvider = CandidateSkillApiProvider();

  Future<bool> addSkillCandidate({int canId, int skillId, level}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _candidateSkillApiProvider
                  .addSkillCandidate(
                      skillId: skillId,
                      level: level,
                      canId: canId,
                      authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));
}

class ApplyRepository {
  final _applyApiProvider = ApplyApiProvider();

  Future<bool> applyCandidate({int canId, int jobId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _applyApiProvider
                  .applyCandidate(
                      jobId: jobId,
                      canId: canId,
                      authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));

  Future<ItemApplyCandidateModel> fetchAllApplyCandidate({int empId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _applyApiProvider
                  .fetchAllApplyCandidate(
                      empId: empId, authorizeToken: value.toString())
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

  Future<EmpAccount> fetchEmpRank(int empId) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _employeeApiProvider
          .fetchEmpRank(
          empId: empId, authorizeToken: value.toString())
          .catchError((e) {
        throw e;
      }));

  final _companyApiProvider = CompanyApiProvider();

  Future<Company> fetchCompanyByEmpId(int empId) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => _companyApiProvider
                  .fetchCompanyIdByEmpId(
                      empId: empId, authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));

}
