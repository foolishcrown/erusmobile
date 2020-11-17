import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/models/skill_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class SkillBloc {
  final _repository = SkillRepository();
  final _skillFetcher = PublishSubject<ItemSkillModel>();

  PublishSubject<ItemSkillModel> get allSkills => _skillFetcher.stream;

  Future fetchAllSkill({int pageNum}) async {
    ItemSkillModel skillModel = await _repository
        .fetchSkills(pageNum)
        .catchError((e) {
      throw e;
    });
    _skillFetcher.sink.add(skillModel);
  }

  dispose() {
    _skillFetcher.close();
  }

}
