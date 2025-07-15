import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final String kGoogleApiKey = "AIzaSyC7GBzybImx9U1QpZfYfk1qkBbGXLq7I3g";
  final String apiUrl = "https://cargo-loop.com/api/pedido/crear";

  DateTime? _selectedDate;
  double? recogerLat;
  double? recogerLong;
  double? entregarLat;
  double? entregarLong;
  String? _idUser;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _addressSearchController =
      TextEditingController();
  final TextEditingController _deliveryAddressController =
      TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _contactoController = TextEditingController();
  final TextEditingController _valor_cargaController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _observacionesController =
      TextEditingController();
  final TextEditingController _tipoMaterialController = TextEditingController();
  final TextEditingController _tipoPagoController = TextEditingController();
  final TextEditingController _cartaporteController = TextEditingController();
  final TextEditingController _estadoPedidoController = TextEditingController();

  final List<String> unidadOptions = [
    'Camioneta 750 kgs',
    'Camioneta 1.5 ton',
    'Camión de 3 toneladas',
    'Camión 5 ton',
    'Tráiler 25 Ton',
  ];

  String? selectedUnidad;
  bool aplicaSeguro = false;
  File? _selectedImage;

  @override
  void dispose() {
    _dateController.dispose();
    _addressSearchController.dispose();
    _deliveryAddressController.dispose();
    _descripcionController.dispose();
    _contactoController.dispose();
    _valor_cargaController.dispose();
    _cantidadController.dispose();
    _observacionesController.dispose();
    _tipoMaterialController.dispose();
    _tipoPagoController.dispose();
    _cartaporteController.dispose();
    _estadoPedidoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadInfoUser(); // <- ahora sí se ejecuta al crear la pantalla
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

  Future<void> _loadInfoUser() async {
    // Aquí puedes cargar la información del usuario desde SharedPreferences o tu servicio de autenticación
    // Por ejemplo:
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('user_id') ?? null;
    setState(() {
      _idUser = id;
    });
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
        _dateController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  Future<void> _submitOrder(BuildContext context) async {
    if (_selectedDate == null ||
        recogerLat == null ||
        recogerLong == null ||
        entregarLat == null ||
        entregarLong == null ||
        selectedUnidad == null ||
        _descripcionController.text.isEmpty ||
        _cantidadController.text.isEmpty ||
        _contactoController.text.isEmpty ||
        _valor_cargaController.text.isEmpty ||
        _tipoMaterialController.text.isEmpty ||
        _tipoPagoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos requeridos.'),
        ),
      );
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      print(_idUser);
      request.fields.addAll({
        "fecha_carga": _selectedDate!.toIso8601String(),
        "descripcion_carga": _descripcionController.text,
        "especificacion_carga": "Manipular con cuidado, frágil",
        "valor_carga": _valor_cargaController.text,
        "aplica_seguro": aplicaSeguro ? "true" : "false",
        "observaciones": _observacionesController.text,
        "tipo_De_vehiculo": selectedUnidad!,
        "seguro_carga": "Cobertura total", // texto para API
        "cartaporte": _cartaporteController.text,
        "estado_pedido": "disponible", // texto para API
        "id_company": "3", // <-- Reemplaza por la compañía real
        "cliente_id": _idUser.toString(), // <-- Reemplaza por cliente real
        "ubicacion_recoger_lat": recogerLat.toString(),
        "ubicacion_recoger_long": recogerLong.toString(),
        "ubicacion_recoger_descripcion": _addressSearchController.text,
        "ubicacion_entregar_direccion": _deliveryAddressController.text,
        "ubicacion_entregar_lat": entregarLat.toString(),
        "ubicacion_entregar_long": entregarLong.toString(),
        "cantidad": _cantidadController.text,
        "tipo_de_material": _tipoMaterialController.text,
        "tipo_de_pago": _tipoPagoController.text,
        "nombre_contacto": _contactoController.text,
      });

      if (_selectedImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'archivo_seguro',
            _selectedImage!.path,
            filename: basename(_selectedImage!.path),
          ),
        );
      }

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pedido enviado exitosamente ✅')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar: $responseBody')),
        );
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crear Pedido",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: const Color(0xFF2600B0),
        elevation: 4,
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Datos del Pedido',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2600B0),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              '📅 Fecha de carga',
              _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              suffixIcon: Icons.calendar_today,
            ),
            const SizedBox(height: 12),
            _buildGooglePlacesField(
              _addressSearchController,
              '📍 Dirección de recogida',
              onPlaceSelected: (lat, lng) {
                recogerLat = lat;
                recogerLong = lng;
              },
            ),
            const SizedBox(height: 12),
            _buildGooglePlacesField(
              _deliveryAddressController,
              '🏠 Dirección de entrega',
              onPlaceSelected: (lat, lng) {
                entregarLat = lat;
                entregarLong = lng;
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: '🚛 Tipo de Vehículo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              value: selectedUnidad,
              items:
                  unidadOptions.map((unidad) {
                    return DropdownMenuItem(value: unidad, child: Text(unidad));
                  }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedUnidad = value;
                });
              },
            ),
            const SizedBox(height: 12),
            _buildTextField('📦 Descripción de carga', _descripcionController),
            const SizedBox(height: 8),
            _buildTextField(
              '🔢 Cantidad',
              _cantidadController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            _buildTextField('🛠️ Tipo de Material', _tipoMaterialController),
            const SizedBox(height: 8),
            _buildTextField('💳 Tipo de Pago', _tipoPagoController),
            const SizedBox(height: 8),
            _buildTextField('👤 Nombre Contacto', _contactoController),
            const SizedBox(height: 8),
            _buildTextField(
              '💲 Valor Carga',
              _valor_cargaController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            _buildTextField('📄 Cartaporte', _cartaporteController),
            const SizedBox(height: 8),

            const SizedBox(height: 12),
            Row(
              children: [
                Checkbox(
                  value: aplicaSeguro,
                  onChanged: (value) {
                    setState(() {
                      aplicaSeguro = value ?? false;
                    });
                  },
                  activeColor: const Color(0xFF2600B0),
                ),
                const Text("Aplica Seguro", style: TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _selectImage,
              icon: const Icon(Icons.upload_file, size: 20),
              label: const Text('Seleccionar archivo de Seguro'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (_selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _selectedImage!,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _submitOrder(context),
              icon: const Icon(Icons.send, size: 22),
              label: const Text(
                'Enviar Pedido',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2600B0),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    VoidCallback? onTap,
    IconData? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
    );
  }

  Widget _buildGooglePlacesField(
    TextEditingController controller,
    String label, {
    required Function(double lat, double lng) onPlaceSelected,
  }) {
    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller,
      googleAPIKey: kGoogleApiKey,
      inputDecoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      debounceTime: 800,
      countries: const ["mx"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (Prediction prediction) {
        if (prediction.lat != null && prediction.lng != null) {
          setState(() {
            controller.text = prediction.description ?? "";
            onPlaceSelected(
              double.parse(prediction.lat!),
              double.parse(prediction.lng!),
            );
          });
        }
      },
      itemClick: (Prediction prediction) {
        setState(() {
          controller.text = prediction.description ?? "";
        });
      },
      itemBuilder: (context, index, prediction) {
        return ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(prediction.description ?? ""),
        );
      },
    );
  }
}
