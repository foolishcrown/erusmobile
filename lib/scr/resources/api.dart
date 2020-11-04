import 'dart:async';
import 'dart:convert';
import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/resources/api_strings.dart';
import 'package:http/http.dart' show Client;

class CandidateApiProvider {
  Client client = Client();

  ///get all candidate by employee id
  Future<ItemCandidateModel> fetchCandidateList(
      {int pageNum, int empID}) async {
    print("entered candidate list");
    final response = await client
        .get(CandidateApiString.getCandidates(empId: empID, pageNum: pageNum));

    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemCandidateModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

class CandidateSkillApiProvider {
  Client client = Client();

  ///get skills of candidate
  Future<ItemCandidateSkillModel> fetchCandidateSkillList(
      {int numpage, int canID}) async {
    print('entered skill list');
    final response = await client
        .get(CandidateSkillApiString.getCandidateSkills(numpage, canID));
    print('body : ' + response.body.toString());
    if (response.statusCode == 200) {
      return ItemCandidateSkillModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

class EmpAccountApiProvider {
  Client client = Client();

  Future<ItemEmpAccountModel> fetchEmpAccountList({int numpage}) async {
    print('entered employee account list');
    final response = await client.get(EmpAccountApiString.getEmpAccounts(numpage));
    print('body :' + response.body.toString());
    if(response.statusCode == 200){
      return ItemEmpAccountModel.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load post');
    }
  }
}

class JobApiProvider {
  Client client = Client();

  Future<ItemJobModel> fetchJobList({int pageNum, int companyId}) async {
    print("entered");
    final response =
    await client.get(JobApiString.getJobsByCompany(pageNum: pageNum, companyId: companyId));
    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemJobModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
