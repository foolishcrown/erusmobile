import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CandidateSkillBloc {
  final _repository = CandidateRepository();
  final _repositorySkill = SkillRepository();
  final _candidateSkillFetcher = PublishSubject<ItemCandidateSkillModel>();
  final _candidateSkillAdder = PublishSubject<bool>();

  PublishSubject<ItemCandidateSkillModel> get allSkill =>
      _candidateSkillFetcher.stream;

  PublishSubject<bool> get addSkill => _candidateSkillAdder.stream;

  Future fetchAllCandidateSkill(int canId) async {
    ItemCandidateSkillModel candidateSkillModel =
        await _repository.fetchSkillsByCandidate(canId).catchError((e) {
      throw e;
    });
    _candidateSkillFetcher.sink.add(candidateSkillModel);
  }

  Future addSkillCandidate({int canId, int skillId, int level}) async {
    bool isAdded =
    await _repositorySkill.addSkillCandidate(canId: canId, skillId: skillId, level: level).catchError((e) {
      throw e;
    });
    _candidateSkillAdder.sink.add(isAdded);
  }


  dispose() {
    _candidateSkillFetcher.close();
    _candidateSkillAdder.close();
  }
}
