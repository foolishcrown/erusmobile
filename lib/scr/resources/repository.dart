

import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/resources/api.dart';

class Repository {
  ///Call api get candidates by employee id
  final candidateApiProvider = CandidateApiProvider();
  Future<ItemCandidateModel> fetchAllCandidates({int pageNum, int empId}) => candidateApiProvider.fetchCandidateList(pageNum: pageNum, empID: empId);

  ///Call api get skills by candidate id
  final candidateSkillApiProvider = CandidateSkillApiProvider();
  Future<ItemCandidateSkillModel> fetchSkillsByCandidate(int canId) => candidateSkillApiProvider.fetchCandidateSkillList(canID: canId, numpage: 1);

  ///Call api get all employee account on db
  final empAccountApiProvider = EmpAccountApiProvider();
  Future<ItemEmpAccountModel> fetchAllEmpAccounts({int numpage}) => empAccountApiProvider.fetchEmpAccountList(numpage: numpage);

  ///Call api get all jobs by company id
  final jobsApiProvider = JobApiProvider();
  Future<ItemJobModel> fetchAllJobsByCompany({int numPage, int companyId}) => jobsApiProvider.fetchJobList(pageNum: numPage, companyId: companyId);



}