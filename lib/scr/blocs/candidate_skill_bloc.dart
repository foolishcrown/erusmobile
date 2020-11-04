import 'package:erusmobile/scr/models/skill_candidate_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CandidateSkillBloc{
  final _repository = Repository();
  final _candidateSkillFetcher = PublishSubject<ItemCandidateSkillModel>();

  PublishSubject<ItemCandidateSkillModel> get allSkill => _candidateSkillFetcher.stream;

  fetchAllCandidateSkill(int canId) async{
    ItemCandidateSkillModel candidateSkillModel = await _repository.fetchSkillsByCandidate(canId);
    _candidateSkillFetcher.sink.add(candidateSkillModel);
  }

  dispose(){
    _candidateSkillFetcher.close();
  }


}