

import 'dart:async';
import 'package:erusmobile/scr/resources/authorize_token_store.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CompanyBloc{
  StreamController _companyId = new PublishSubject<int>();

  Stream get companyId =>_companyId.stream;

  // 3
  Future getCompanyId() async {
    await SharedPrefAccount.readIntValue(SharedPrefAccount.COMPANY_ID).then((value) => _companyId.sink.add(value));
  }

  // 4
  @override
  void dispose() {
    _companyId.close();
  }


}