
///Base URL API
const String BASE_URL = 'https://employeereferralsystemerus.azurewebsites.net';

class CandidateApiString{

  ///Get list candidates of employee api: /api/candidates/{numpage}/empid/{empID}
  static String getCandidates({int pageNum, int empId}){
    return BASE_URL + '/api/candidates/$pageNum/empid/$empId';
  }

  ///Get candidate by id api: /api/candidates/{id}
  static String getCandidateById(int id){
    return BASE_URL + '/api/candidates/$id';
  }

  ///Update candidate by id api:​/api/candidates/{id}


  ///Delete candidate by id api:​/api/candidates/{id}


  ///Insert candidate api: /api/candidates

}

class CandidateSkillApiString{

  ///Get list candidate skills api
  static String getCandidateSkills(int numpage, int canID){
    return BASE_URL + '/api/candidateskills/$numpage/candid/$canID';
  }

}



class JobApiString{

  ///Get list jobs api :
  static String getJobsByCompany({int pageNum, int companyId}){
    return BASE_URL + '/api/jobs/$pageNum/companyid/$companyId';
  }



}

class EmpAccountApiString{

  ///Get list account api :
  static String getEmpAccounts(int pageNum){
    return BASE_URL + '/api/empaccounts/pagenum/$pageNum';
  }


}
