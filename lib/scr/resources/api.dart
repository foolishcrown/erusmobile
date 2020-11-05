import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/resources/api_strings.dart';
import 'package:http/http.dart' show Client;

final String authorizeKey = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiVmFuIFNhbmcgTmdvIiwianRpIjoiMzM1MWIxOGEtOGYwMC00ZjEwLWEzOGEtZTY2MTkxMjFjZGEwIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6MTYwNzA3MTYwMCwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMCIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDAifQ.qhI3N2bkhHCjYLfyHNyrSHRLInPjHB1Jx7r4q_tY1yI';

class CandidateApiProvider {
  Client client = Client();

  ///get all candidate by employee id
  Future<ItemCandidateModel> fetchCandidateList(
      {int pageNum, int empID}) async {
    try {
      print("entered candidate list");
      final response = await client.get(
          CandidateApiString.getCandidates(empId: empID, pageNum: pageNum),
          headers: {'Authorization': authorizeKey}
          );

      print("body : " + response.body.toString());
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return ItemCandidateModel.fromJson(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    } finally {
      client.close();
    }
  }
}

class CandidateSkillApiProvider {
  Client client = Client();

  ///get skills of candidate
  Future<ItemCandidateSkillModel> fetchCandidateSkillList(
      {int numpage, int canID}) async {
    try {
      print('entered skill list');
      final response = await client
          .get(CandidateSkillApiString.getCandidateSkills(numpage, canID));
      print('body : ' + response.body.toString());
      if (response.statusCode == 200) {
        return ItemCandidateSkillModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    } finally {
      client.close();
    }
  }
}

class EmpAccountApiProvider {
  Client client = Client();

  Future<ItemEmpAccountModel> fetchEmpAccountList({int numpage}) async {
    try {
      print('entered employee account list');
      final response =
          await client.get(EmpAccountApiString.getEmpAccounts(numpage),
          headers: {'Authorization': authorizeKey});
      print('body :' + response.body.toString());
      if (response.statusCode == 200) {
        return ItemEmpAccountModel.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post');
      }
    } finally {
      client.close();
    }
  }
}

class JobApiProvider {
  Client client = Client();

  Future<ItemJobModel> fetchJobList({int pageNum, int companyId}) async {
    try {
      print("entered");
      final response = await client.get(JobApiString.getJobsByCompany(
          pageNum: pageNum, companyId: companyId));
      print("body : " + response.body.toString());
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return ItemJobModel.fromJson(json.decode(response.body));
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    } finally {
      client.close();
    }
  }
}


