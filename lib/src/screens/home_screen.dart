import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guide/src/blocs/home_bloc.dart';
import 'package:guide/src/models/finances_model.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final _scaffoldState = GlobalKey<ScaffoldState>();

late HomeBloc _bloc;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _bloc = HomeBloc();
    _bloc.initStateScreen();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.disposeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text(
          'Guide Investimentos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<bool>(
          stream: _bloc.graph.stream,
          builder: (context, snapshot) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 50),
                      Text(
                        'Ações',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          _bloc.graph.sink.add(!_bloc.graph.value);
                        },
                        icon: Icon(
                          CupertinoIcons.graph_square,
                          size: 30,
                          color: (snapshot.data ?? false)
                              ? Color.fromRGBO(18, 58, 60, 1)
                              : Colors.grey[350],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<List<FinancesModel>>(
                    stream: _bloc.financesList.stream,
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                List<Result>? _results =
                                    snapshot.data?[index].chart?.result;

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Card(
                                    elevation: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: _bloc.graph.value
                                          ? _charts(context, _results)
                                          : _column(_results),
                                    ),
                                  ),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            );
          }),
    );
  }
}

Column _column(List<Result>? _results) {
  List<Widget> list = [];
  list.add(
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          _results?[0].meta?.symbol ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    ),
  );
  list.add(Divider());
  list.add(
    Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Dia',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            width: 66,
            child: Text(
              'Data',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 66,
            child: Text(
              'Valor',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 56,
            child: Text(
              'D-1',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: 56,
            child: Text(
              'D-D0',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < 30; i++) {
    list.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              (i + 1).toString().padLeft(2, '0'),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.end,
            ),

            // SIMULANDO DIAS DIFERENTES PORQUE A API RETORNOU SOMENTE 1D COM TODAS AS HORAS DO PREGAO
            Text(
              DateFormat('dd/MM/yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(
                        (_results?[0].timestamp?[i] ?? 0) * 1000)
                    .add(Duration(days: -29 + (i))),
              ),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.end,
            ),
            // SIMULANDO DIAS DIFERENTES PORQUE A API RETORNOU SOMENTE 1D COM TODAS AS HORAS DO PREGAO

            Container(
              width: 66,
              child: Text(
                'R\$ ' +
                    (_results?[0]
                            .indicators
                            ?.quote?[0]
                            .open?[i]
                            .toStringAsFixed(2) ??
                        ''),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                textAlign: TextAlign.end,
              ),
            ),
            // (B-A)/A*100
            i == 0
                ? Container(width: 56, child: Center(child: Text('-')))
                : Container(
                    width: 56,
                    child: Text(
                      ((((_results?[0].indicators?.quote?[0].open?[i] ?? 0) -
                                          (_results?[0]
                                                  .indicators
                                                  ?.quote?[0]
                                                  .open?[i - 1] ??
                                              0)) /
                                      (_results?[0]
                                              .indicators
                                              ?.quote?[0]
                                              .open?[i - 1] ??
                                          0)) *
                                  100)
                              .toStringAsFixed(2) +
                          '%',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      textAlign: TextAlign.end,
                    ),
                  ),
            i == 0
                ? Container(width: 56, child: Center(child: Text('-')))
                : Container(
                    width: 56,
                    child: Text(
                      ((((_results?[0].indicators?.quote?[0].open?[i] ?? 0) -
                                          (_results?[0]
                                                  .indicators
                                                  ?.quote?[0]
                                                  .open?[0] ??
                                              0)) /
                                      (_results?[0]
                                              .indicators
                                              ?.quote?[0]
                                              .open?[0] ??
                                          0)) *
                                  100)
                              .toStringAsFixed(2) +
                          '%',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      textAlign: TextAlign.end,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  return Column(
    children: list,
  );
}

Column _charts(BuildContext context, List<Result>? _results) {
  List<Widget> list = [];
  list.add(
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          _results?[0].meta?.symbol ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    ),
  );
  list.add(Divider());
  list.add(Container(
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        Container(
            padding: EdgeInsets.only(right: 20, top: 40),
            width: 1500,
            child: chart(_results)),
      ],
    ),
    width: MediaQuery.of(context).size.width,
    height: 400,
  ));

  return Column(
    children: list,
  );
}

LineChart chart(List<Result>? results) {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  return LineChart(
    LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          interval: 1,
          showTitles: true,
          reservedSize: 10,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 8),
          getTitles: (double value) => getTitlesB(value, results),
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 0.01,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 8,
          ),
          getTitles: (double value) => getTitles(value, results),
          reservedSize: 40,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 0.4)),
      lineBarsData: [
        LineChartBarData(
          spots: spots(results),
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    ),
  );
}

String getTitlesB(double value, List<Result>? results) {
  return DateFormat('dd/MM/yyyy').format(
    DateTime.fromMillisecondsSinceEpoch(
            (results?[0].timestamp?[int.parse(value.toInt().toString())] ?? 0) *
                1000)
        .add(Duration(days: -29 + (int.parse(value.toInt().toString())))),
  );
}

String getTitles(double value, List<Result>? results) {
  bool has = false;
  var o = results?[0].indicators?.quote?[0].open ?? null;
  int? id;

  if (o != null) {
    o = o.take(30).toList();

    for (var i = 0; i < o.length; i++) {
      var z = value.toStringAsFixed(2);
      var x = o[i].toStringAsFixed(2);
      if (z.contains(x)) {
        has = true;
        id = i;
      }
    }
  }

  return has && id != null
      ? 'R\$ ' +
          (results?[0].indicators?.quote?[0].open?[id].toStringAsFixed(2) ?? '')
      : '';
}

List<FlSpot>? spots(List<Result>? results) {
  List<FlSpot>? spots = <FlSpot>[];

  for (var i = 0; i < 30; i++) {
    spots.add(FlSpot(
        double.parse(i.toString()),
        double.parse(
            results?[0].indicators?.quote?[0].open?[i].toStringAsFixed(2) ??
                '0')));
  }

  return spots;
}
