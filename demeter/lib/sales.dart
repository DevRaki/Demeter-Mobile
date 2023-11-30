import 'package:flutter/material.dart';
import 'package:demeter/models/sale_model.dart';
import 'package:demeter/services/sale_service.dart';
import 'package:demeter/login.dart';
import 'package:demeter/saleDetails.dart';
import 'package:demeter/services/sale_details_service.dart';

class SalesPage extends StatelessWidget {
  final SaleService saleService = SaleService();
  final SaleDetailsService saleDetailsService = SaleDetailsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD69C67),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                'Ventas Pendientes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<SaleModel>>(
                future: saleService.getSales(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final List<SaleModel> sales = snapshot.data!;
                    return GridView.builder(
                      padding: EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: sales.length,
                      itemBuilder: (context, index) {
                        final SaleModel sale = sales[index];
                        return Card(
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
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
