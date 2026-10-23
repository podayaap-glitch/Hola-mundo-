import 'package:flutter/material.dart';

void main() => runApp(PodaYaApp());

class PodaYaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomePodaYa(),
    );
  }
}

class HomePodaYa extends StatefulWidget {
  @override
  _HomePodaYaState createState() => _HomePodaYaState();
}

class _HomePodaYaState extends State<HomePodaYa> {
  double m2 = 20;
  double precioPorM2 = 1000;
  
  double get total => m2 * precioPorM2;
  double get paraVos => total * 0.05;
  double get paraCortador => total * 0.95;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // HEADER UBER
          Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PODA-YA", style: TextStyle(color: Color(0xFF00FF88), fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: 2)),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  decoration: BoxDecoration(color: Color(0xFF1C1C1E), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 10),
                      Text("¿Dónde querés cortar? González Catán", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // MAPA FALSO (luego va el real)
          Container(
            height: 200,
            width: double.infinity,
            color: Color(0xFF2C2C2E),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.map, size: 100, color: Colors.grey[800]),
                Positioned(
                  child: Icon(Icons.location_on, size: 50, color: Color(0xFF00FF88)),
                ),
                Positioned(
                  bottom: 10,
                  child: Text("MAPA GPS EN VIVO - Próximamente", style: TextStyle(color: Colors.grey)),
                )
              ],
            ),
          ),

          // CONTROLES
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Tamaño del terreno", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                  Slider(
                    value: m2,
                    min: 5,
                    max: 100,
                    divisions: 19,
                    activeColor: Color(0xFF00FF88),
                    onChanged: (v) => setState(() => m2 = v),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${m2.toInt()} m²", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("\$${total.toInt()}", style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text("Tu ganancia 5%: \$${paraVos.toInt()}  |  Cortador: \$${paraCortador.toInt()}", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  
                  Divider(height: 25),
                  
                  Text("Cortadores cerca tuyo", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      _cortador("Lio", "4.9", "2 min"),
                      _cortador("Carlos", "4.8", "5 min"),
                      _cortador("Juan", "5.0", "7 min"),
                    ],
                  ),
                  
                  Spacer(),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00FF88), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pedido enviado a Lio.129 - \$${paraCortador.toInt()} para él")));
                      },
                      child: Text("CONFIRMAR PEDIDO \$${total.toInt()}", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cortador(String nombre, String estrellas, String tiempo) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Color(0xFFF2F2F7), borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            CircleAvatar(backgroundColor: Colors.black, child: Text(nombre[0], style: TextStyle(color: Color(0xFF00FF88)))),
            SizedBox(height: 5),
            Text(nombre, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
            Text("⭐ $estrellas - $tiempo", style: TextStyle(color: Colors.grey[700], fontSize: 10)),
          ],
        ),
      ),
    );
  }
}
