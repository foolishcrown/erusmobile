import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CandidateBloc {
  final _repository = CandidateRepository();
  final _candidateFetcher = PublishSubject<ItemCandidateModel>();
  final _candidateInfo = PublishSubject<Candidate>();
  final _updateCandidate = PublishSubject<bool>();

  PublishSubject<ItemCandidateModel> get allCandidates =>
      _candidateFetcher.stream;

  PublishSubject<Candidate> get candidateInfo => _candidateInfo.stream;

  PublishSubject<bool> get updateStatus => _updateCandidate.stream;

  ///Fetch all candidates
  Future fetchAllCandidate({int pageNum, int empId}) async {
    ItemCandidateModel candidateModel = await _repository
        .fetchAllCandidates(pageNum: pageNum, empId: empId)
        .catchError((e) {
      throw e;
    });
    _candidateFetcher.sink.add(candidateModel);
  }

  ///Get candidate information
  Future fetchCandidateById({int canId}) async {
    Candidate candidateModel =
        await _repository.fetchCandidateById(canId: canId).catchError((e) {
      throw e;
    });
    _candidateInfo.sink.add(candidateModel);
  }

  Future updateCandidateById(
      {@required Candidate candidate, @required int empId}) async {
    bool isUpdate = await _repository
        .updateCandidateById(candidate: candidate, empId: empId)
        .catchError((e) {
      throw e;
    });
    _updateCandidate.sink.add(isUpdate);
  }

  ///dispose function
  dispose() {
    _candidateFetcher.close();
    _candidateInfo.close();
    _updateCandidate.close();
  }
}
