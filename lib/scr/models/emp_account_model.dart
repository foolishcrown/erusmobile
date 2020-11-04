class _EmpAccount {
  String _email;

  _EmpAccount(result){
    _email = result['email'];
  }

  String get email => _email;
}

class ItemEmpAccountModel{
  final String listName = 'listempaccountresponse';
  List<_EmpAccount> _accounts = [];


  ItemEmpAccountModel.fromJson(Map<String, dynamic> json){
    print(json[listName].length);
    List<_EmpAccount> temp = [];

    for(int i = 0 ; i < json[listName].length; i++){
      _EmpAccount skill = _EmpAccount(json[listName][i]);
      temp.add(skill);
    }
    _accounts = temp;
    print('Done');
  }

  List<_EmpAccount> get accounts => _accounts;
}