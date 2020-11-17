
class Company{
  int _id;
  String _name;
  String _phone;
  String _address;
  String _email;

  Company(result) {
    if (result != null) {
      _id = result['id'];
      _name = result['name'];
      _email = result['email'];
      _phone = result['phone'];
      _address = result['address'];
    }
  }

  int get id => _id;

  String get name => _name;

  String get email => _email;

  String get address => _address;

  String get phone => _phone;
}