import 'package:erusmobile/scr/models/job_model.dart';
import 'package:erusmobile/scr/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class JobBloc {
  final _repository = Repository();
  final _jobFetcher = PublishSubject<ItemJobModel>();

  PublishSubject<ItemJobModel> get allJobs => _jobFetcher.stream;

  fetchAllJobByCompanyId({int pageNum, int companyId}) async {
    ItemJobModel jobModel = await _repository.fetchAllJobsByCompany(companyId: companyId,numPage: pageNum).catchError((e) {
      throw e;
    });
    _jobFetcher.sink.add(jobModel);
  }

  dispose() {
    _jobFetcher.close();
  }

}
