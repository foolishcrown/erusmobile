class _Job{
  int _id;
  String _title;
  String _description;
  int _reward;
  int _slot;
  bool _status;

  _Job(result){
    _id = result['id'];
    _title = result['title'];
    _description = result['description'];
    _reward = result['reward'];
    _slot = result['slot'];
    _status = result['status'];
  }


  int get id => _id;

  String get title => _title;

  bool get status => _status;

  int get slot => _slot;

  int get reward => _reward;

  String get description => _description;
}
// id": 4,
// "title": "Developer",
// "description": "Knowledge of the software development life-cycle. The desire to work in fast-paced environment. Ability to develop unit testing of code components or complete applications. Deep programming language knowledge",
// "reward": 50,
// "slot": 3,
// "status": true

class ItemJobModel{
  int _num_page;
  int _per_page;
  int _total_pages;
  List<_Job> _jobs = [];

  ItemJobModel.fromJson(Map<String, dynamic> json){
    print(json['listresponse'].length);

    List<_Job> temp = [];

    for(int i = 0; i < json['listresponse'].length; i++){
      _Job job = _Job((json['listresponse'][i]));
      temp.add(job);
    }
    _jobs = temp;
    print('Done');
  }

  int get num_page => _num_page;

  int get per_page => _per_page;

  int get total_pages => _total_pages;

  List<_Job> get jobs => _jobs;
}
