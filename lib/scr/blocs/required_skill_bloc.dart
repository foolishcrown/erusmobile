import 'package:erusmobile/scr/models/require_skill_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class RequiredSkillBloc{
  final _repository = JobRepository();
  final _requiredSkillFetcher = PublishSubject<ItemRequiredSkillModel>();

  PublishSubject<ItemRequiredSkillModel> get allSkill =>
      _requiredSkillFetcher.stream;

  fetchAllRequiredSkill(int jobId) async {
    ItemRequiredSkillModel requiredSkillModel =
    await _repository.fetchSkillsByCandidate(jobId: jobId, numpage: 1).catchError((e) {
      throw e;
    });
    _requiredSkillFetcher.sink.add(requiredSkillModel);
  }

  dispose(){
    _requiredSkillFetcher.close();
  }


}