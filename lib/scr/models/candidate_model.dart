class _Candidate {
  int _id;
  String _firstName;
  String _lastName;
  String _email;
  String _phone;
  String _resumeFile;

  // final int empID;

  _Candidate(result) {
    _id = result['id'];
    _firstName = result['firstName'];
    _lastName = result['lastName'];
    _email = result['email'];
    _phone = result['phone'];
    _resumeFile = result['resumeFile'];
  }

  int get id => _id;

  @override
  String toString() => 'Candidate { name: $firstName $lastName}';

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get fullname => _lastName + " " + firstName;

  String get email => _email;

  String get phone => _phone;

  String get resumeFile => _resumeFile;
}

class Candidate {
  int _id;
  String _firstName;
  String _lastName;
  String _email;
  String _phone;
  String _resumeFile;

  Candidate(this._id, this._firstName, this._lastName, this._email, this._phone,
      this._resumeFile); // final int empID;

  Candidate.fromJson(Map<String, dynamic> result) {
    _id = result['id'];
    _firstName = result['firstName'];
    _lastName = result['lastName'];
    _email = result['email'];
    _phone = result['phone'];
    _resumeFile = result['resumeFile'];
  }

  Map<String, dynamic> toJson(int empID) => {
        "id": _id,
        "firstName": _firstName,
        "lastName": _lastName,
        "email": _email,
        "phone": _phone,
        "resumeFile": _resumeFile,
        "empID": empID
      };

  int get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get fullname => _lastName + " " + firstName;

  String get email => _email;

  String get phone => _phone;

  String get resumeFile => _resumeFile;
}

class ItemCandidateModel {
  final String listName = 'listCandidate';
  int _num_page;
  int _per_page;
  int _total_pages;
  List<_Candidate> _candidates = [];

  ItemCandidateModel.fromJson(Map<String, dynamic> json) {
    print(json[listName].length);
    // _page = json['page'];
    // _total_results = json['total_results'];
    // _total_pages = json['total_pages'];
    List<_Candidate> temp = [];

    for (int i = 0; i < json[listName].length; i++) {
      _Candidate candidate = _Candidate(json[listName][i]);
      temp.add(candidate);
    }

    _candidates = temp;
    print('done');
  }

  List<_Candidate> get candidates => _candidates;

  int get total_pages => _total_pages;

  int get per_page => _per_page;

  int get num_page => _num_page;
}


//
// class ItemModel <_T>{
//   int _num_page;
//   int _per_page;
//   int _total_pages;
//   List<_T> _results = [];
//
//   ItemModel.fromJson(Map<String, dynamic> json, String listType) {
//     print(json[listType].length);
//     // _page = json['page'];
//     // _total_results = json['total_results'];
//     // _total_pages = json['total_pages'];
//     List<_T> temp = [];
//
//     for (int i = 0; i < json[listType].length; i++) {
//       _T result = _T(json[listType][i]);
//       temp.add(result);
//     }
//
//     _results = temp;
//     print('done');
//   }
//
//
//   List<_T> get results => _results;
//
//   int get total_pages => _total_pages;
//
//   int get per_page => _per_page;
//
//   int get num_page => _num_page;
// }
