class _ApplyCandidate {
  int _canId;
  int _jobId;
  int _phaseId;
  bool _status;
  String _applyDate;
  String _lastUpdate;
  String _phaseName;
  String _candidateName;
  String _jobName;
  int _reward;


  int get reward => _reward;

  String get candidateName => _candidateName;

  _ApplyCandidate(result) {
    _canId = result['canID'];
    _jobId = result['jobID'];
    _status = result['status'];
    _applyDate = result['applyDate'];
    _lastUpdate = result['lastUpdate'];
    _phaseName = result['phaseName'];
    _candidateName = result['candidateName'];
    _jobName = result['jobName'];
    _phaseId = result['phaseID'];
    _reward = result['reward'];
  }


  int get phaseId => _phaseId;

  String get phaseName => _phaseName;

  String get lastUpdate => _lastUpdate;

  String get applyDate => _applyDate;

  bool get status => _status;

  int get jobId => _jobId;

  int get canId => _canId;

  String get jobName => _jobName;
}


class ItemApplyCandidateModel {
  final String listName = 'listApplyCandidateResponse';
  int _num_page;
  int _per_page;
  int _total_pages;
  List<_ApplyCandidate> _applies = [];

  ItemApplyCandidateModel.fromJson(Map<String, dynamic> json) {
    print(json[listName].length);
    // _page = json['page'];
    // _total_results = json['total_results'];
    // _total_pages = json['total_pages'];
    List<_ApplyCandidate> temp = [];
    for (int i = 0; i < json[listName].length; i++) {
      _ApplyCandidate candidate = _ApplyCandidate(json[listName][i]);
      temp.add(candidate);
    }
    _applies = temp;
    print('done');
  }

  List<_ApplyCandidate> get applyCandidate => _applies;

  int get total_pages => _total_pages;

  int get per_page => _per_page;

  int get num_page => _num_page;
}
