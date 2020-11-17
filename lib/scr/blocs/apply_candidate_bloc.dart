import 'package:erusmobile/scr/models/apply_model.dart';
import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ApplyCandidateBloc {
  final _repository = ApplyRepository();
  final _applyState = PublishSubject<bool>();
  final _appliesFetcher = PublishSubject<ItemApplyCandidateModel>();

  PublishSubject<bool> get applyState => _applyState.stream;

  PublishSubject<ItemApplyCandidateModel> get allApplies => _appliesFetcher.stream;

  Future applyCandidate({int canId, int jobId}) async {
    bool isApply = await _repository
        .applyCandidate(canId: canId, jobId: jobId)
        .catchError((e) {
      throw e;
    });
    _applyState.sink.add(isApply);
  }

  Future fetchAllApplyCandidate({int empId}) async {
    ItemApplyCandidateModel applyCandidateModel = await _repository
        .fetchAllApplyCandidate(empId: empId)
        .catchError((e) {
      throw e;
    });
    _appliesFetcher.sink.add(applyCandidateModel);
  }


  dispose() {
    _applyState.close();
    _appliesFetcher.close();
  }

}
