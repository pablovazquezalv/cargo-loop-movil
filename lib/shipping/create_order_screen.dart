import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Crear un Pedido',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2600B0),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Caracteristicas del generador de carga',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Fecha de carga',
              _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              suffixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 10),
            //boton para el lugar de carga
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/mapa');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2600B0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Seleccionar lugar de carga',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Lugar de Destino',
              null,
              suffixIcon: Icons.location_on,
            ),
            const SizedBox(height: 10),
            _buildTextField('Tipo de Unidad', null),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2600B0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Seleccionar tipo de Carga',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField('Descripcion de la carga', null, maxLines: 4),
            const SizedBox(height: 10),
            _buildTextField('Especificacion de la carga', null),
            const SizedBox(height: 10),
            _buildTextField('Nombre de persona (contacto)', null),
            const SizedBox(height: 10),
            _buildTextField(
              'Valor de Cargo',
              null,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            _buildFileUploadField('Adjuntar el Seguro de Carga'),
            const SizedBox(height: 10),
            _buildFileUploadField(
              'Adjuntar Cartaporte (pesos ,valor de la carga)',
            ),
            const SizedBox(height: 20),
            const Text(
              '¿Aplica Seguro?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    value: true,
                    groupValue: true,
                    onChanged: (value) {},
                    title: const Text('Si'),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: false,
                    groupValue: true,
                    onChanged: (value) {},
                    title: const Text('No'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField('Observaciones', null, maxLines: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController? controller, {
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
    IconData? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
    );
  }

  Widget _buildFileUploadField(String label) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Icon(Icons.image, size: 40, color: Colors.grey),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
