import 'package:guide/src/models/finances_model.dart';
import 'package:guide/src/repositories/finances_repository.dart';
import 'package:guide/src/repositories/i_finances_repository.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final IFinancesRepository _financesRepository = FinancesRepository();

  final financesList = BehaviorSubject<List<FinancesModel>>();
  final graph = BehaviorSubject<bool>.seeded(false);

  void initStateScreen() {
    _getAtivos();
  }

  void disposeScreen() {
    financesList.close();
    graph.close();
  }

  Future<void> _getAtivos() async {
    List<FinancesModel> _financesList = <FinancesModel>[];

    final _petr4 = await _financesRepository.getAtivos('PETR4.SA');
    final _itsa4 = await _financesRepository.getAtivos('ITSA4.SA');

    if (_petr4 != null) {
      _financesList.add(_petr4);
    }
    if (_itsa4 != null) {
      _financesList.add(_itsa4);
    }

    financesList.sink.add(_financesList);
  }
}
