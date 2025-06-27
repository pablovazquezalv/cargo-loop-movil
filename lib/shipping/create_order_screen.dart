import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final String kGoogleApiKey = "AIzaSyC7GBzybImx9U1QpZfYfk1qkBbGXLq7I3g";
  final String apiUrl =
      "https://cargo-loop.com/api/pedido/crear"; // Reemplaza con tu endpoint real

  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressSearchController =
      TextEditingController();
  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _contactoController = TextEditingController();
  final TextEditingController _valor_cargaController = TextEditingController();
  //cantidad
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _observacionesController =
      TextEditingController();

  final List<String> unidadOptions = [
    'Camioneta 750 kgs',
    'Camioneta 1.5 ton',
    'Camión 3.5 ton',
    'Camión 5 ton',
    'Thorton 15-17 ton (pvb)',
    'Thorton plataforma 15-17 ton (pbv)',
    'Tráiler 25 Ton (pbv)',
    'Tráiler doble remolque 75 Ton (pbv)',
    'Tráiler plataforma 25 Ton (pbv)',
    'Tráiler doble semirremolque plataforma 75 Ton (pbv)',
  ];

  String? selectedUnidad;
  File? _selectedImage;

  @override
  void dispose() {
    _dateController.dispose();
    _addressSearchController.dispose();
    _deliveryAddressController.dispose();
    _descripcionController.dispose();
    _contactoController.dispose();
    _valor_cargaController.dispose();
    _observacionesController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _submitOrder(BuildContext context) async {
    if (_selectedDate == null ||
        _addressSearchController.text.isEmpty ||
        _deliveryAddressController.text.isEmpty ||
        selectedUnidad == null ||
        _descripcionController.text.isEmpty ||
        _cantidadController.text.isEmpty ||
        _contactoController.text.isEmpty ||
        _valor_cargaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos requeridos.'),
        ),
      );
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.fields['fecha_carga'] = _selectedDate!.toIso8601String();
      //ubicacion_recoger_description
      request.fields['ubicacion_recoger_descripcion'] =
          _addressSearchController.text;
      request.fields['ubicacion_entregar_direccion'] =
          _deliveryAddressController.text;
      request.fields['tipo_De_vehiculo'] = selectedUnidad!;
      request.fields['descripcion'] = _descripcionController.text;
      request.fields['nombre_contacto'] = _contactoController.text;
      request.fields['valor_carga'] = _valor_cargaController.text;
      request.fields['observaciones'] = _observacionesController.text;
      request.fields['cantidad'] = _cantidadController.text;

      if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'seguro_carga',
            _selectedImage!.path,
            filename: basename(_selectedImage!.path),
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pedido enviado exitosamente')),
        );
      } else {
        final responseBody = await response.stream.bytesToString();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar: ${responseBody}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
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
              'Características del generador de carga',
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
            const SizedBox(height: 20),
            const Text(
              'Dirección de Origen',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildGooglePlacesField(
              _addressSearchController,
              onPlaceSelected: (_, __) {},
            ),
            const SizedBox(height: 20),
            const Text(
              'Dirección de Entrega',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildGooglePlacesField(
              _deliveryAddressController,
              onPlaceSelected: (_, __) {},
            ),
            const SizedBox(height: 20),
            const Text(
              'Tipo de Unidad',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              value: selectedUnidad,
              hint: const Text('Selecciona el tipo de unidad'),
              items:
                  unidadOptions.map((unidad) {
                    return DropdownMenuItem<String>(
                      value: unidad,
                      child: Text(unidad, overflow: TextOverflow.ellipsis),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => selectedUnidad = value),
            ),
            const SizedBox(height: 20),
            const Text(
              'Cantidad de carga',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            _buildTextField(
              'Cantidad',
              _cantidadController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            _buildTextField(
              'Descripción de la carga',
              _descripcionController,
              maxLines: 4,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'Nombre de persona (contacto)',
              _contactoController,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              'valor_carga (valor)',
              _valor_cargaController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _selectImage,
              child: _buildFileUploadField('Adjuntar el Seguro de Carga'),
            ),
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.file(
                  _selectedImage!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            _buildTextField(
              'Observaciones',
              _observacionesController,
              maxLines: 4,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => _submitOrder(context),
              icon: const Icon(Icons.send),
              label: const Text('Enviar pedido'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2600B0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGooglePlacesField(
    TextEditingController controller, {
    required Function(double lat, double lng) onPlaceSelected,
  }) {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller,
      googleAPIKey: kGoogleApiKey,
      inputDecoration: InputDecoration(
        labelText: 'Buscar dirección...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: const Icon(Icons.search),
      ),
      debounceTime: 800,
      countries: const ["mx"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (Prediction prediction) {
        if (prediction.lat != null &&
            prediction.lng != null &&
            prediction.lat!.isNotEmpty &&
            prediction.lng!.isNotEmpty) {
          setState(() {
            controller.text = prediction.description ?? "";
            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );
          });
          onPlaceSelected(
            double.parse(prediction.lat!),
            double.parse(prediction.lng!),
          );
        }
      },
      itemClick: (Prediction prediction) {
        setState(() {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        });
      },
      itemBuilder: (BuildContext ctx, int index, Prediction prediction) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 7),
              Expanded(child: Text(prediction.description ?? "")),
            ],
          ),
        );
      },
      seperatedBuilder: const Divider(),
      isCrossBtnShown: true,
      containerHorizontalPadding: 0,
      placeType: PlaceType.address,
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.image, size: 40, color: Colors.grey),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
