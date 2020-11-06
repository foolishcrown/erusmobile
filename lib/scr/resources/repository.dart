import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/resources/api.dart';
import 'package:erusmobile/scr/resources/authorize_token_store.dart';

class Repository {
  ///Call api post and get authorize token
  final loginApiProvider = LoginApiProvider();

  Future<String> fetchAuthorizeToken({String idToken}) =>
      loginApiProvider.fetchAuthorizeToken(idToken: idToken);

  ///call api post and get exist account status
  Future<bool> fetchExistStatusAccount({String email}) =>
      loginApiProvider.fetchStatusExistAccount(email: email);

  ///Call api get candidates by employee id
  final candidateApiProvider = CandidateApiProvider();

  Future<ItemCandidateModel> fetchAllCandidates(
          {int pageNum, int empId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => candidateApiProvider
                  .fetchCandidateList(
                      pageNum: pageNum,
                      empID: empId,
                      authorizeToken: value.toString())
                  .catchError((e) {
                throw e;
              }));

  ///Call api get skills by candidate id
  final candidateSkillApiProvider = CandidateSkillApiProvider();

  Future<ItemCandidateSkillModel> fetchSkillsByCandidate(int canId) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => candidateSkillApiProvider.fetchCandidateSkillList(
              canID: canId, numpage: 1, authorizeToken: value.toString()));

  ///Call api get all jobs by company id
  final jobsApiProvider = JobApiProvider();

  Future<ItemJobModel> fetchAllJobsByCompany(
          {int numPage, int companyId}) async =>
      await SharedPrefAccount.readStringValue(SharedPrefAccount.AUTHORIZE_TOKEN)
          .then((value) => jobsApiProvider.fetchJobList(
              companyId: companyId,
              pageNum: numPage,
              authorizeToken: value.toString()));
}
