import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cargo_loop_app/utils/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedIndex = 0;
  String nombre = '';
  Map<String, dynamic>? pedidoEnProceso;
  List<Map<String, dynamic>> pedidosFiltrados = [];

  @override
  void initState() {
    super.initState();
    _loadInfoUser();
    _fetchPedidos();
  }

  Future<void> _loadInfoUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('user_name') ?? 'Usuario';
    setState(() {
      nombre = userName;
    });
  }

  Future<void> _fetchPedidos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final clienteId = prefs.getInt('user_id');

      // 🚚 Obtener el pedido actual
      final actualRes = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/client/pedidoActual'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"cliente_id": clienteId}),
      );

      if (actualRes.statusCode == 200) {
        final actualData = json.decode(actualRes.body);
        setState(() {
          pedidoEnProceso = actualData['pedido'];
        });
      }

      // 📦 Obtener todos los pedidos
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/client/pedidos'),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List data = jsonData['data'];

        final filtrados = data
            .where((p) => p['estado_pedido'] != 'disponible')
            .toList()
            .cast<Map<String, dynamic>>();

        setState(() {
          pedidosFiltrados = filtrados;
        });
      }
    } catch (e) {
      debugPrint('❌ Error al cargar pedidos: $e');
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/create_order');
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: SizedBox(
            height: 60,
            child: Image.asset('assets/images/Carga-loop-icon.png'),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(Icons.notifications_outlined, color: Colors.black),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 👤 Usuario
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.deepPurple,
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Hola!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(
                        'Bienvenido ${nombre.length > 18 ? nombre.substring(0, 18) + '…' : nombre}',
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // 🚨 Card EN VIVO
              if (pedidoEnProceso != null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tus Cargas en Tiempo real\nHaz click para ver tus Pedidos Actuales',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  '/pedido_en_vivo',
                                  arguments: pedidoEnProceso,
                                );
                              },
                              icon: const Icon(Icons.circle,
                                  color: Colors.red, size: 12),
                              label: const Text(
                                'EN VIVO',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(color: Colors.green),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // ➕ Crear pedido
              Center(
                child: ElevatedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/create_order'),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Crea un Pedido',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A00B0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text('Mis Pedidos',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // 📜 Lista de pedidos
              Expanded(
                child: pedidosFiltrados.isEmpty
                    ? const Center(child: Text("No hay pedidos aún."))
                    : ListView.builder(
                        itemCount: pedidosFiltrados.length,
                        itemBuilder: (context, index) {
                          final pedido = pedidosFiltrados[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: Icon(Icons.local_shipping,
                                  color: Colors.blue.shade700),
                              title: Text(
                                'ID-${pedido['id']}\n${pedido['fecha_carga'] ?? ''}\n${pedido['nombre_contacto']}',
                              ),
                              trailing: Text(
                                '*${pedido['estado_pedido']}',
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text('Ver más',
                      style: TextStyle(color: Colors.grey.shade600)),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey.shade600,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt), label: 'Pedido'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}
