import 'package:cargo_loop_app/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Container(child: Center(child: Text("Inicio"))),
    // MisPedidosScreen(),  // Asegúrate de importar esta pantalla si la usas
    ProfileScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/home');
        break;
      case 1:
        Navigator.pushNamed(context, '/profile'); // Ruta para 'Mis Pedidos'
        break;
      case 2:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SizedBox(
          height: 60,
          child: Image.asset('assets/images/Carga-loop-icon.png'),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hola!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Bienvenido Jesus Daniel',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400, width: 1.5),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tus Cargas en Tiempo real\nhas click para ver tus Pedido Actuales',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.green, width: 2),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'EN VIVO',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.circle, color: Colors.red, size: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  //  Image.asset('assets/truck.png', width: 100),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(26, 0, 176, 1),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 40,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                // Navega a la pantalla de crear pedido
                Navigator.pushNamed(context, '/create_order');
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Crea un Pedido',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.add, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Mis Pedidos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ListTile(
                    //  leading: Image.asset('assets/package.png', width: 50),
                    title: Text(
                      'ID-00078\n22/01/2024\nPropiedades Radio',
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: Text(
                      '*Finalizado',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: Text(
                'ver mas',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Mis Pedidos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: Colors.blue.shade800,
      ),
    );
  }
}
