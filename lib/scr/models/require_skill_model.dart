class _RequiredSkill{
  int _canID;
  int _skillID;
  String _name;
  int _level;

  _RequiredSkill(result){
    _canID = result['id'];
    _skillID = result['skillID'];
    _name = result['nameSkill'];
    _level = result['level'];
  }

  String get name => _name;

  int get canID => _canID;

  int get skillID => _skillID;

  int get level => _level;
}

class ItemRequiredSkillModel{
  final String listName = 'listskillrequireresponse';

  List<_RequiredSkill> _skills = [];

  ItemRequiredSkillModel.fromJson(Map<String, dynamic> json){
    List<_RequiredSkill> temp = [];

    for(int i = 0 ; i < json[listName].length; i++){
      _RequiredSkill skill = _RequiredSkill(json[listName][i]);
      temp.add(skill);
    }
    _skills = temp;
    print('Done');
  }

  List<_RequiredSkill> get skills => _skills;
}
