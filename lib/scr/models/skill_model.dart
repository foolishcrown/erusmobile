class Skill {
  int _id;
  String _description;

  Skill.fromJson(result) {
    _id = result['id'];
    _description = result['description'];
  }


  Skill(this._id, this._description);

  String get description => _description;

  int get id => _id;
}


class ItemSkillModel {
  int _num_page;
  int _per_page;
  int _total_pages;
  List<Skill> _skills = [];

  ItemSkillModel.fromJson(Map<String, dynamic> json){
    print(json['listskillresponse'].length);
    List<Skill> temp = [];

    for (int i = 0; i < json['listskillresponse'].length; i++) {
      Skill skill = Skill.fromJson(json['listskillresponse'][i]);
      temp.add(skill);
    }

    _skills = temp;
    print('done');
  }

  List<Skill> get skills => _skills;

  int get total_pages => _total_pages;

  int get per_page => _per_page;

  int get num_page => _num_page;
}