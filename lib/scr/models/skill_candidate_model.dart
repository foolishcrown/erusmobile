class _CandidateSkill{
  int _canID;
  int _skillID;
  String _name;
  int _level;

  _CandidateSkill(result){
    _canID = result['id'];
    _skillID = result['skillID'];
    _name = result['skillName'];
    _level = result['level'];
  }

  String get name => _name;

  int get canID => _canID;

  int get skillID => _skillID;

  int get level => _level;
}

class ItemCandidateSkillModel{
  final String listName = 'listCandidateSkill';
  List<_CandidateSkill> _skills = [];

  ItemCandidateSkillModel.fromJson(Map<String, dynamic> json){
    print(json[listName].length);
    List<_CandidateSkill> temp = [];

    for(int i = 0 ; i < json[listName].length; i++){
      _CandidateSkill skill = _CandidateSkill(json[listName][i]);
      temp.add(skill);
    }
    _skills = temp;
    print('Done');
  }

  List<_CandidateSkill> get skills => _skills;
}
