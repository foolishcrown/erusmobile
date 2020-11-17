import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ApplyCandidateBloc {
  final _repository = ApplyRepository();
  final _applyState = PublishSubject<bool>();

  PublishSubject<bool> get applyState => _applyState.stream;

  Future applyCandidate({int canId, int jobId}) async {
    bool isApply = await _repository
        .applyCandidate(canId: canId, jobId: jobId)
        .catchError((e) {
      throw e;
    });
    _applyState.sink.add(isApply);
  }

  dispose() {
    _applyState.close();
  }

}
