import 'dart:math';

import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CandidateBloc {
  final _repository = Repository();
  final _candidateFetcher = PublishSubject<ItemCandidateModel>();

  PublishSubject<ItemCandidateModel> get allCandidates =>
      _candidateFetcher.stream;

  Future fetchAllCandidate({int pageNum, int empId}) async {
    ItemCandidateModel candidateModel = await _repository
        .fetchAllCandidates(pageNum: pageNum, empId: empId)
        .catchError((e) {
      throw e;
    });
    _candidateFetcher.sink.add(candidateModel);
  }

  dispose() {
    _candidateFetcher.close();
  }
}
