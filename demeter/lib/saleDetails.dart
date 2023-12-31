import 'package:flutter/material.dart';
import 'package:demeter/models/sale_model.dart';
import 'package:demeter/services/sale_details_service.dart';

class SaleDetailsPage extends StatefulWidget {
  final SaleModel sale;
  final List<Map<String, dynamic>> saleDetails;

  SaleDetailsPage({required this.sale, required this.saleDetails});

  @override
  _SaleDetailsPageState createState() => _SaleDetailsPageState();
}

class _SaleDetailsPageState extends State<SaleDetailsPage> {
  String selectedPaymentMethod = 'Efectivo'; // Valor predeterminado
  final SaleDetailsService saleDetailsService = SaleDetailsService();

  Future<void> _confirmarPago() async {
    try {
      final saleId = widget.sale.id;
      final String paymentMethod = selectedPaymentMethod;

      await saleDetailsService.updateSalePayment(saleId, paymentMethod);

      // Puedes mostrar un mensaje de éxito o realizar otras acciones después de un pago exitoso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pago confirmado con éxito'),
          duration: Duration(seconds: 2),
        ),
      );

      // Cierra la pantalla o realiza otras acciones según sea necesario
      Navigator.of(context).pop();
    } catch (error) {
      // Maneja errores, por ejemplo, muestra un mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al confirmar el pago'),
          duration: Duration(seconds: 2),
        ),
      );
      print('Error al confirmar el pago: $error');
    }
  }

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
              onPressed: _confirmarPago,
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
