import 'package:flutter/material.dart';
import 'package:demeter/models/sale_model.dart';

class SaleDetailsPage extends StatefulWidget {
  final SaleModel sale;
  final List<Map<String, dynamic>> saleDetails;

  SaleDetailsPage({required this.sale, required this.saleDetails});

  @override
  _SaleDetailsPageState createState() => _SaleDetailsPageState();
}

class _SaleDetailsPageState extends State<SaleDetailsPage> {
  String selectedPaymentMethod = 'Efectivo'; // Valor predeterminado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar pago'),
        backgroundColor: Color(0xFFD69C67),
      ),
      backgroundColor: Color(0xFFD69C67),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Venta : ${widget.sale.id}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Cantidad')),
                  DataColumn(label: Text('Producto')),
                  DataColumn(label: Text('Precio')),
                ],
                rows: widget.saleDetails.map((detail) {
                  return DataRow(
                    cells: [
                      DataCell(Text(detail['Lot'].toString())),
                      DataCell(
                          Text(detail['Product']['Name_Products'].toString())),
                      DataCell(
                          Text(detail['Product']['Price_Product'].toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            const SizedBox(height: 16),
            Text(
              'Seleccionar método de pago',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedPaymentMethod = 'QR';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: selectedPaymentMethod == 'QR'
                          ? Color.fromARGB(255, 218, 130, 59)
                          : Color(0xFFA67B58),
                    ),
                    child: Text('QR'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedPaymentMethod = 'Efectivo';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: selectedPaymentMethod == 'Efectivo'
                          ? Color.fromARGB(255, 218, 130, 59)
                          : Color(0xFFA67B58),
                    ),
                    child: Text('Efectivo'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selectedPaymentMethod = 'Tarjeta';
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: selectedPaymentMethod == 'Tarjeta'
                          ? Color.fromARGB(255, 218, 130, 59)
                          : Color(0xFFA67B58),
                    ),
                    child: Text('Tarjeta'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(
              color: Colors.black,
              thickness: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Lógica para confirmar el pago
                // Puedes implementar la lógica de confirmación aquí
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 218, 130, 59),
              ),
              child: Text('Confirmar Pago'),
            ),
          ],
        ),
      ),
    );
  }
}
