///Base URL API
const String BASE_URL = 'https://employeereferralsystemerus.azurewebsites.net';

class LoginApiString {
  ///Get authorize token of login api : /api/accounts/{idtoken}
  static String getAuthorizeToken({String idToken}) {
    return BASE_URL + '/api/logins/$idToken';
  }

  static String checkExistAccount({String email}) {
    return BASE_URL + '/api/logins/email/$email';
  }
}

class CandidateApiString {
  ///Get list candidates of employee api: /api/candidates/{numpage}/empid/{empID}
  static String getCandidates({int pageNum, int empId}) {
    return BASE_URL + '/api/candidates/$pageNum/empid/$empId';
  }

  ///Get candidate by id api: /api/candidates/{id}
  static String getCandidateById(int id) {
    return BASE_URL + '/api/candidates/$id';
  }

  ///Update candidate by id api:​/api/candidates/{id}

  static String updateCandidateById(int id) {
    return BASE_URL + '/api/candidates/$id';
  }

  ///Delete candidate by id api:​/api/candidates/{id}
  static String deleteCandidate(int canId) {
    return BASE_URL + '/api/candidates/$canId';
  }

  ///Insert candidate api: /api/candidates
  static String insertCandidate() {
    return BASE_URL + '/api/candidates';
  }
}

class CandidateSkillApiString {
  ///Get list candidate skills api
  static String getCandidateSkills({int numpage, int canID}) {
    return BASE_URL + '/api/candidateskills/$numpage/candid/$canID';
  }

  ///Add skill for candidate
  static String addSkillCandidate(){
    return BASE_URL + '/api/candidateskills';
  }
}

class RequiredSkillApiString {
  ///Get list candidate skills api
  static String getRequiredSkills({int numpage, int jobId}) {
    return BASE_URL + '/api/skillrequires/$numpage/jobid/$jobId';
  }
}

class JobApiString {
  ///Get list jobs api :
  static String getJobsByCompany({int pageNum, int companyId}) {
    return BASE_URL + '/api/jobs/$pageNum/companyid/$companyId';
  }

  static String getQuantityJobByComp({int companyId}){
    return BASE_URL + '/api/jobs/getquantityjobbycomid/$companyId';
  }
}

class EmployeeApiString {
  ///Get employee data by login email
  static String getEmployeeByMail(String email) {
    return BASE_URL + '/api/employees/email/$email';
  }

  static String getEmpRank(int empId){
    return BASE_URL + '/api/employees/getemployeerankbyempid/$empId';
  }

  static String getReward({int empId, int canId, int jobId}){
    return BASE_URL + '/api/employees/getreward/$empId/$canId/$jobId';
  }

}

class CompanyApiString {
  ///Get company by employee id
  static String getCompanyByEmpID(int empId) {
    return BASE_URL + '/api/companies/empid/$empId';
  }
}

class SkillApiString{
  ///Get all skill
  static String getSkillWithPage(int numpage){
    return BASE_URL + '/api/skills/numpage/$numpage';
  }
}

class ApplyApiString{
  ///Apply candidate
  static String applyCandidateToJob(){
    return BASE_URL + '/api/applycandidates';
  }

  static String fetchAllApplyCandidate(int empId){
    return BASE_URL + '/api/applycandidates/employeeid/$empId';
  }

}