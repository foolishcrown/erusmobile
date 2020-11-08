import 'dart:async';
import 'dart:convert';
import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/resources/api_strings.dart';
import 'package:http/http.dart' show Client;

// final String authorizeKey = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiVmFuIFNhbmcgTmdvIiwianRpIjoiMzM1MWIxOGEtOGYwMC00ZjEwLWEzOGEtZTY2MTkxMjFjZGEwIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsImV4cCI6MTYwNzA3MTYwMCwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMCIsImF1ZCI6Imh0dHBzOi8vbG9jYWxob3N0OjUwMDAifQ.qhI3N2bkhHCjYLfyHNyrSHRLInPjHB1Jx7r4q_tY1yI';

class LoginApiProvider {

  Future<String> fetchAuthorizeToken({String idToken}) async {
    Client client = Client();
    try {
      print('Generating authorize token...');
      final response =
          await client.post(LoginApiString.getAuthorizeToken(idToken: idToken));
      print('Body : ' + response.body.toString());
      if (response.statusCode == 200) {
        return json.decode(response.body)['token'];
      } else {
        throw Exception('Failed to load post');
      }
    } finally {
      client.close();
    }
  }

  Future<bool> fetchStatusExistAccount({String email}) async {
    Client client = Client();
    try {
      print('Get status exist account...');
      final response =
          await client.post(LoginApiString.checkExistAccount(email: email));
      print('Body : ' + response.body.toString());
      if (response.statusCode == 200) {
        return json.decode(response.body)['isExist'];
      } else {
        throw Exception('Failed to load post');
      }
    } finally {
      client.close();
    }
  }
}

class CandidateApiProvider {

  ///get all candidate by employee id
  Future<ItemCandidateModel> fetchCandidateList(
      {int pageNum, int empID, String authorizeToken}) async {
    Client client = Client();
    try {
      print("entered candidate list");
      final response = await client.get(
          CandidateApiString.getCandidates(empId: empID, pageNum: pageNum),
          headers: {'Authorization': authorizeToken});

      print("body : " + response.body.toString());
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return ItemCandidateModel.fromJson(json.decode(response.body));
      } else if(response.statusCode == 401){
        throw Exception('Your login authorize token has been expired, try to login again !');
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

  ///get skills of candidate
  Future<ItemCandidateSkillModel> fetchCandidateSkillList(
      {int numpage, int canID, String authorizeToken}) async {
    Client client = Client();
    try {
      print('entered skill list');
      final response = await client.get(
          CandidateSkillApiString.getCandidateSkills(numpage, canID),
          headers: {'Authorization': authorizeToken});
      print('body : ' + response.body.toString());
      if (response.statusCode == 200) {
        return ItemCandidateSkillModel.fromJson(json.decode(response.body));
      } else if(response.statusCode == 401){
        throw Exception('Your login authorize token has been expired, try to login again !');
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
          await client.get(EmpAccountApiString.getEmpAccounts(numpage));
      print('body :' + response.body.toString());
      if (response.statusCode == 200) {
        return ItemEmpAccountModel.fromJson(json.decode(response.body));
      } else if(response.statusCode == 401){
        throw Exception('Your login authorize token has been expired, try to login again !');
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

  Future<ItemJobModel> fetchJobList(
      {int pageNum, int companyId, String authorizeToken}) async {
    try {
      print("entered");
      final response = await client.get(
          JobApiString.getJobsByCompany(pageNum: pageNum, companyId: companyId),
          headers: {'Authorization': authorizeToken});
      print("body : " + response.body.toString());
      if (response.statusCode == 200) {
        // If the call to the server was successful, parse the JSON
        return ItemJobModel.fromJson(json.decode(response.body));
      } else if(response.statusCode == 401){
        throw Exception('Your login authorize token has been expired, try to login again !');
      } else {
        // If that call was not successful, throw an error.
        throw Exception('Failed to load post');
      }
    } finally {
      client.close();
    }
  }
}
