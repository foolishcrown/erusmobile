class _Skill {
  int _id;
  String _description;

  _Skill(result) {
    _id = result['id'];
    _description = result['description'];
  }

  String get description => _description;

  int get id => _id;
}

class ItemSkillModel {
  int _num_page;
  int _per_page;
  int _total_pages;
  List<_Skill> _skills = [];

  ItemSkillModel.fromJson(Map<String, dynamic> json){
    print(json['listskillresponse'].length);
    List<_Skill> temp = [];

    for (int i = 0; i < json['listskillresponse'].length; i++) {
      _Skill skill = _Skill(json['listskillresponse'][i]);
      temp.add(skill);
    }

    _skills = temp;
    print('done');
  }

  List<_Skill> get skills => _skills;

  int get total_pages => _total_pages;

  int get per_page => _per_page;

  int get num_page => _num_page;
}