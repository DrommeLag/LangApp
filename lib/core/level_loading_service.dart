import 'package:lang_app/core/database_service.dart';
import 'package:lang_app/models/progress.dart';
import 'package:lang_app/models/test.dart';

class LevelsService{
  UserProgress? _userProgress;
  List<Test>? _testList;

  UserProgress get userProgress => _userProgress!; 

  List<Test> get testList => _testList!;
  

  LevelsService._privateCons();

  static LevelsService? _instance;

  static Future<LevelsService> get instance async {
    if( _instance == null){
      _instance = LevelsService._privateCons();
      await _instance!._loadProgress();
      await _instance!._loadLevels().then((_) => _instance!._updateProgress());
    }
    return _instance!;
  }
  
  _loadProgress() async {
    _userProgress = await DatabaseService().getProgress();
  }

  _loadLevels() async {
    await DatabaseService().getTests().then((value) => _testList = value.toList());
  }

  Future<bool> needsUpdate() async{
    throw UnimplementedError();
  }

  updateResult(int result, int level) {
    if (_userProgress!.testStatuses[level] < result) {
      DatabaseService().updateProgress(level, result);
      _userProgress!.testStatuses[level] = result;
      if (result == _testList![level].taskIds.length &&
          level < _testList!.length - 1 &&
          _userProgress!.testStatuses[level + 1] == -1) {
        DatabaseService().updateProgress(level + 1, 0);
        _userProgress!.testStatuses[level + 1] = 0;
      }
    }
  }

  bool sureLoaded() => !(_userProgress == null || _testList == null);
  
  _updateProgress() {
    if (_testList!.length != _userProgress!.testStatuses.length) {
      for (var i = _testList!.length;
          i <= _userProgress!.testStatuses.length;
          i++) {
        DatabaseService().updateProgress(i, -1);
      }
    }
  }
}