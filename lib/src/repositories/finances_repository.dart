import 'package:dio/dio.dart';
import 'package:guide/src/models/finances_model.dart';
import 'package:guide/src/repositories/i_finances_repository.dart';

class FinancesRepository extends IFinancesRepository {
  @override
  Future<FinancesModel?> getAtivos(String ativo) async {
    try {
      String _path = 'https://query2.finance.yahoo.com/v8/finance/chart/$ativo';

      Response _response = await Dio().get(_path);

      if (_response.statusMessage == 'OK') {
        return FinancesModel.fromJson(_response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
