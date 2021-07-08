import 'package:guide/src/models/finances_model.dart';

abstract class IFinancesRepository {
  Future<FinancesModel?> getAtivos(String ativo);
}
