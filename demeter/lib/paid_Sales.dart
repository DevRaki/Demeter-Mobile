import 'package:flutter/material.dart';
import 'package:demeter/models/sale_model.dart';
import 'package:demeter/services/sale_service.dart';
import 'package:demeter/login.dart';
import 'package:demeter/sale_info.dart';
import 'package:demeter/sales.dart';
import 'package:demeter/services/sale_details_service.dart';
import 'package:demeter/Dashboard.dart';

class PaidSalesPage extends StatefulWidget {
  @override
  _PaidSalesPageState createState() => _PaidSalesPageState();
}

class _PaidSalesPageState extends State<PaidSalesPage> {
  final SaleService saleService = SaleService();
  final SaleDetailsService saleDetailsService = SaleDetailsService();
  TextEditingController searchController = TextEditingController();
  late List<SaleModel> paidSales;
  late List<SaleModel> filteredPaidSales;

  @override
  void initState() {
    super.initState();
    loadPaidSales();
  }

  Future<void> loadPaidSales() async {
    try {
      final List<SaleModel> fetchedPaidSales = await saleService.getPaidSales();
      setState(() {
        paidSales = fetchedPaidSales;
        filteredPaidSales = paidSales;
      });
    } catch (error) {
      print('Error loading paid sales: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD69C67),
      appBar: AppBar(
        title: Text('Ventas Pagadas'),
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
                    child: Text('Cerrar Sesión'),
                  ),
                ],
                child: Icon(Icons.person),
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
                  color: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Buscar por ID',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            searchController.clear();
                            // Recargar la lista completa de ventas pagadas cuando se borra el texto de búsqueda
                            setState(() {
                              filteredPaidSales = paidSales;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          // Filtrar la lista de ventas pagadas según el ID ingresado
                          filteredPaidSales = paidSales
                              .where(
                                  (sale) => sale.id.toString().contains(value))
                              .toList();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: Wrap(
                    spacing: 16.0,
                    runSpacing: 16.0,
                    children: filteredPaidSales.map((sale) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Card(
                          color: Color(0xFFD69C67),
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('ID: ${sale.id}'),
                                Text('Total: ${sale.total}'),
                                ElevatedButton(
                                  onPressed: () async {
                                    // Obtener detalles de la venta
                                    final saleDetails = await saleDetailsService
                                        .getSaleDetails(sale.id);

                                    // Navegar a la página de detalles
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SaleInfoPage(
                                          sale: sale,
                                          saleDetails: saleDetails,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFB26926),
                                  ),
                                  child: Text(
                                    'Detalles',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
