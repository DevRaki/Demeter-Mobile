import 'package:demeter/login.dart';
import 'package:demeter/paid_Sales.dart';
import 'package:demeter/sales.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:demeter/services/sale_service.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final SaleService saleService = SaleService();
  late DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  late DateTime endDate = DateTime.now().add(Duration(days: 1));
  late List<Map<String, dynamic>> sales = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              width: 30,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'logout') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'logout',
                    child: Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                          color: Color(
                              0xFFB26926)), // Color del texto del menú desplegable
                    ),
                  ),
                ],
                child: Icon(
                  Icons.person,
                  color:
                      Color(0xFFB26926), // Color del ícono del menú desplegable
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFD69C67),
              ),
              child: Text(
                'Menú Principal',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              title: Text('Ventas Pendientes'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesPage()),
                );
              },
            ),
            ListTile(
              title: Text('Ventas Pagadas'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaidSalesPage()),
                );
              },
            ),
            ListTile(
              title: Text('Dashboard'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFD69C67),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: Color(0xFFD69C67), // Fondo de color deseado
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenido al Dashboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Color del texto
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final List<Map<String, dynamic>> fetchedSales =
                      await saleService.getSalesByTimeRange(
                    startTime: DateFormat('yyyy-MM-dd').format(startDate),
                    endTime: DateFormat('yyyy-MM-dd').format(endDate),
                  );

                  setState(() {
                    sales = _groupAndSumSalesByDate(fetchedSales);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFB26926), // Color de fondo del botón
                ),
                child: Text(
                  'Obtener Ventas',
                  style: TextStyle(
                      color: Colors.black), // Color del texto del botón
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Inicio: ${DateFormat('dd-MM-yyyy').format(startDate)}',
                    style: TextStyle(color: Colors.black), // Color del texto
                  ),
                  Text(
                    'Fin: ${DateFormat('dd-MM-yyyy').format(endDate)}',
                    style: TextStyle(color: Colors.black), // Color del texto
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _selectStartDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFB26926), // Color de fondo del botón
                    ),
                    child: Text(
                      'Seleccionar Inicio',
                      style: TextStyle(
                          color: Colors.black), // Color del texto del botón
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _selectEndDate(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFB26926), // Color de fondo del botón
                    ),
                    child: Text(
                      'Seleccionar Fin',
                      style: TextStyle(
                          color: Colors.black), // Color del texto del botón
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: DataTable2(
                  columns: [
                    DataColumn2(
                      label: Text('Fecha'),
                      size: ColumnSize.S,
                    ),
                    DataColumn2(
                      label: Text('Ventas'),
                      size: ColumnSize.S,
                    ),
                  ],
                  rows: sales
                      .map<DataRow>((sale) => DataRow(
                            cells: [
                              DataCell(Text(sale['createdAt'])),
                              DataCell(Text(sale['total'].toString())),
                            ],
                          ))
                      .toList(),
                ),
              ),
              // Gráfico de barras
              SizedBox(height: 20),
              Text(
                'Ventas por Fecha',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Color del texto
                ),
              ),
              Container(
                height:
                    200, // Ajusta la altura del gráfico según tus preferencias
                child: charts.BarChart(
                  _createBarChartSeries(),
                  animate: true,
                  barGroupingType: charts.BarGroupingType.grouped,
                  defaultRenderer: charts.BarRendererConfig(
                    cornerStrategy: const charts.ConstCornerStrategy(5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ))!;

    if (pickedDate != startDate) {
      setState(() {
        startDate = pickedDate;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ))!;

    if (pickedDate != endDate) {
      setState(() {
        endDate = pickedDate;
      });
    }
  }

  List<Map<String, dynamic>> _groupAndSumSalesByDate(
      List<Map<String, dynamic>> sales) {
    final groupedSales = <String, double>{};

    for (final sale in sales) {
      final date =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(sale['createdAt']));
      final totalString = sale['Total'];
      final total = totalString != null ? double.parse(totalString) : 0.0;

      if (groupedSales.containsKey(date)) {
        groupedSales[date] = groupedSales[date]! + total;
      } else {
        groupedSales[date] = total;
      }
    }

    return groupedSales.entries
        .map((entry) => {'createdAt': entry.key, 'total': entry.value})
        .toList();
  }

  List<charts.Series<Map<String, dynamic>, String>> _createBarChartSeries() {
    return [
      charts.Series<Map<String, dynamic>, String>(
        id: 'Ventas',
        domainFn: (Map<String, dynamic> sale, _) => sale['createdAt'],
        measureFn: (Map<String, dynamic> sale, _) => sale['total'],
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xFFB26926)),
        data: sales,
      ),
    ];
  }
}
