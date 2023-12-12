import 'package:demeter/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:demeter/models/sale_model.dart';
import 'package:demeter/services/sale_service.dart';
import 'package:demeter/login.dart';
import 'package:demeter/saleDetails.dart';
import 'package:demeter/paid_Sales.dart';
import 'package:demeter/services/sale_details_service.dart';

class SalesPage extends StatefulWidget {
  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  final SaleService saleService = SaleService();
  final SaleDetailsService saleDetailsService = SaleDetailsService();
  TextEditingController searchController = TextEditingController();
  late List<SaleModel> sales;
  late List<SaleModel> filteredSales;

  @override
  void initState() {
  super.initState();
  loadSales();
  // Inicializar filteredSales junto con sales
  sales = [];
  filteredSales = [];
}

  Future<void> loadSales() async {
    try {
      final List<SaleModel> fetchedSales = await saleService.getSales();
      setState(() {
        sales = fetchedSales;
        filteredSales = sales;
      });
    } catch (error) {
      print('Error loading sales: $error');
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
              margin: EdgeInsets.only(bottom: 8.0),
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
                            // Recargar la lista completa de ventas cuando se borra el texto de búsqueda
                            setState(() {
                              filteredSales = sales;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          // Filtrar la lista de ventas según el ID ingresado
                          filteredSales = sales
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
                    children: filteredSales.map((sale) {
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
                                        builder: (context) => SaleDetailsPage(
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
                                    'Pagar',
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
