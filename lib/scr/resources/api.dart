import 'dart:async';
import 'dart:convert';
import 'package:erusmobile/scr/models/apply_model.dart';
import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/models/company_model.dart';
import 'package:erusmobile/scr/models/emp_account_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/require_skill_model.dart';
import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/models/skill_model.dart';
import 'package:erusmobile/scr/resources/api_strings.dart';
import 'package:erusmobile/scr/resources/google_sign_in.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;

/// AUTHOR : NGO VAN SANG
/// SE130361
/// API PROVIDER
///
///
///
///
/// ***********************************************************************************************************************************
/// LOGIN API PROVIDER*****************************************************************************************************************
/// ***********************************************************************************************************************************
class LoginApiProvider {
  Future<String> fetchAuthorizeToken({@required String idToken}) async {
    Client client = Client();
    print('Generating authorize token...');
    final response =
        await client.post(LoginApiString.getAuthorizeToken(idToken: idToken));
    print('Body : ' + response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body)['token'];
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<bool> fetchStatusExistAccount({@required String email}) async {
    Client client = Client();
    print('Get status exist account...');
    final response =
    await client.post(LoginApiString.checkExistAccount(email: email));
    print('Body : ' + response.body.toString());
    if (response.statusCode == 200) {
      return json.decode(response.body)['isExist'];
    } else {
      throw Exception(
          'Failed to load post, server is under maintenance, please try again later.');
    }
  }
}



/// ***********************************************************************************************************************************
/// CANDIDATE API PROVIDER*************************************************************************************************************
/// ***********************************************************************************************************************************
class CandidateApiProvider {
  ///get all candidate by employee id
  Future<ItemCandidateModel> fetchCandidateList(
      {@required int pageNum, @required int empID, @required String authorizeToken}) async {
    Client client = Client();

    print("entered candidate list");
    final response = await client.get(
        CandidateApiString.getCandidates(empId: empID, pageNum: pageNum),
        headers: {'Authorization': authorizeToken});

    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemCandidateModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<Candidate> fetchCandidateById(
      {@required int canId, @required String authorizeToken}) async {
    Client client = Client();

    print("Loading candidate");
    final response = await client.get(
        CandidateApiString.getCandidateById(canId),
        headers: {'Authorization': authorizeToken});

    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Candidate.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<bool> deleteCandidateById(
      {@required int canId, @required String authorizeToken}) async {
    Client client = Client();

    print("Deleting candidate");
    final response = await client.delete(
        CandidateApiString.getCandidateById(canId),
        headers: {'Authorization': authorizeToken});

    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return true;
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<bool> fetchCandidateUpdate(
      {@required int empID,
      @required String authorizeToken,
      @required Candidate newCandidate}) async {
    Client client = Client();

    print("Updating candidate");
    final response = await client.put(
        CandidateApiString.updateCandidateById(newCandidate.id),
        headers: {
          'Authorization': authorizeToken,
          'Content-Type': 'application/json'
        },
        body: json.encode(newCandidate.toJsonUpdate(empID)));

    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return true;
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<bool> insertNewCandidate(
      {@required int empID,
      @required String authorizeToken,
      @required Candidate newCandidate}) async {
    Client client = Client();

    print("Processing candidate");
    final response = await client.post(CandidateApiString.insertCandidate(),
        headers: {
          'Authorization': authorizeToken,
          'Content-Type': 'application/json'
        },
        body: json.encode(newCandidate.toJsonInsert(empID)));

    print("body : " + response.body.toString());
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      return true;
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

/// ***********************************************************************************************************************************
/// CANDIDATE SKILL API PROVIDER*******************************************************************************************************
/// ***********************************************************************************************************************************
class CandidateSkillApiProvider {
  ///get skills of candidate
  Future<ItemCandidateSkillModel> fetchCandidateSkillList(
      {@required int numpage, @required int canID, @required String authorizeToken}) async {
    Client client = Client();

    print('entered skill list');
    final response = await client.get(
        CandidateSkillApiString.getCandidateSkills(numpage : numpage , canID : canID),
        headers: {'Authorization': authorizeToken});
    print('body : ' + response.body.toString());
    if (response.statusCode == 200) {
      return ItemCandidateSkillModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      throw Exception('Failed to load post');
    }
  }
}

/// ***********************************************************************************************************************************
/// CANDIDATE SKILL API PROVIDER*******************************************************************************************************
/// ***********************************************************************************************************************************
class RequiredSkillApiProvider {
  ///get skills of candidate
  Future<ItemRequiredSkillModel> fetchRequiredSkillList(
      {@required int numpage, @required int jobId, @required String authorizeToken}) async {
    Client client = Client();

    print('entered skill list');
    final response = await client.get(
        RequiredSkillApiString.getRequiredSkills(numpage : numpage , jobId: jobId),
        headers: {'Authorization': authorizeToken});
    print('body : ' + response.body.toString());
    if (response.statusCode == 200) {
      return ItemRequiredSkillModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      throw Exception('Failed to load post');
    }
  }
}

/// ***********************************************************************************************************************************
/// COMPANY API PROVIDER***************************************************************************************************************
/// ***********************************************************************************************************************************
class CompanyApiProvider{

  Future<Company> fetchCompanyIdByEmpId(
      {@required int empId, @required String authorizeToken}) async {
    Client client = Client();

    print("Processing candidate id");
    final response = await client.get(
        CompanyApiString.getCompanyByEmpID(empId),
        headers: {'Authorization': authorizeToken});

    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return Company(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


}


/// ***********************************************************************************************************************************
/// JOB API PROVIDER*******************************************************************************************************************
/// ***********************************************************************************************************************************
class JobApiProvider {
  Future<ItemJobModel> fetchJobList(
      {int pageNum, int companyId, String authorizeToken}) async {
    Client client = Client();

    print("entered");
    final response = await client.get(
        JobApiString.getJobsByCompany(pageNum: pageNum, companyId: companyId),
        headers: {'Authorization': authorizeToken});
    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemJobModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}


/// ***********************************************************************************************************************************
/// EMPLOYEE API PROVIDER**************************************************************************************************************
/// ***********************************************************************************************************************************
class EmployeeApiProvider {
  Future<EmpAccount> fetchEmpAccount(
      {String email, String authorizeToken}) async {
    Client client = Client();

    print("entered");
    final response = await client.get(
        EmployeeApiString.getEmployeeByMail(email),
        headers: {'Authorization': authorizeToken});
    print("body : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return EmpAccount(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      signOutGoogle();
      throw Exception('Failed to load post');
    }
  }
}


/// ***********************************************************************************************************************************
/// JOB API PROVIDER*******************************************************************************************************************
/// ***********************************************************************************************************************************
class SkillApiProvider {
  Future<ItemSkillModel> fetchSkills(
      {int pageNum, String authorizeToken}) async {
    Client client = Client();

    print("Fetching Skills");
    final response = await client.get(
        SkillApiString.getSkillWithPage(pageNum),
        headers: {'Authorization': authorizeToken});
    print("Skills : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
        return ItemSkillModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}

/// ***********************************************************************************************************************************
/// JOB API PROVIDER*******************************************************************************************************************
/// ***********************************************************************************************************************************
class ApplyApiProvider {
  Future<bool> applyCandidate(
      {@required int canId,
        @required String authorizeToken,
        @required int jobId}) async {
    Client client = Client();

    print("Processing candidate");
    final response = await client.post(ApplyApiString.applyCandidateToJob(),
        headers: {
          'Authorization': authorizeToken,
          'Content-Type': 'application/json'
        },
        body: json.encode({
          "canID": canId,
          "jobID": jobId,
        }));

    print("body : " + response.body.toString());
    if (response.statusCode == 201) {
      // If the call to the server was successful, parse the JSON
      return true;
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else if (response.statusCode == 409) {
      return false;
    }else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<ItemApplyCandidateModel> fetchAllApplyCandidate(
      {int empId, String authorizeToken}) async {
    Client client = Client();

    print("Fetching Skills");
    final response = await client.get(
        ApplyApiString.fetchAllApplyCandidate(empId),
        headers: {'Authorization': authorizeToken});
    print("Applies : " + response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemApplyCandidateModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      signOutGoogle();
      throw Exception(
          'Your login authorize token has been expired, try to login again !');
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}