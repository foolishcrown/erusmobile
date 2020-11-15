import 'package:erusmobile/scr/models/candidate_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CandidateBloc {
  final _repository = CandidateRepository();
  final _candidateFetcher = PublishSubject<ItemCandidateModel>();
  final _candidateInfo = PublishSubject<Candidate>();
  final _updateCandidate = PublishSubject<bool>();
  final _insertCandidate = PublishSubject<bool>();
  final _deleteCandidate = PublishSubject<bool>();

  PublishSubject<ItemCandidateModel> get allCandidates =>
      _candidateFetcher.stream;

  PublishSubject<Candidate> get candidateInfo => _candidateInfo.stream;

  PublishSubject<bool> get updateStatus => _updateCandidate.stream;

  PublishSubject<bool> get insertStatus => _insertCandidate.stream;

  PublishSubject<bool> get deleteStatus => _deleteCandidate.stream;

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

  Future deleteCandidateById({int canId}) async {
    bool isDelete =
        await _repository.deleteCandidateById(canId: canId).catchError((e) {
      throw e;
    });
    _deleteCandidate.sink.add(isDelete);
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

  Future insertCandidate(
      {@required Candidate candidate, @required int empId}) async {
    bool isInserted = await _repository
        .insertNewCandidate(candidate: candidate, empId: empId)
        .catchError((e) {
      throw e;
    });
    _insertCandidate.sink.add(isInserted);
  }

  ///dispose function
  dispose() {
    _candidateFetcher.close();
    _candidateInfo.close();
    _updateCandidate.close();
    _insertCandidate.close();
    _deleteCandidate.close();
  }
}
