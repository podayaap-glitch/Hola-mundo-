import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(home: AppCortador(), debugShowCheckedModeBanner: false));

class AppCortador extends StatefulWidget { @override _AppCortadorState createState() => _AppCortadorState(); }

class _AppCortadorState extends State<AppCortador> {
  bool disponible = false;
  String nombre = "";
  String barrio = "González Catán";
  bool pedidoEntrante = true; // simulamos que entró uno

  Future<void> aceptarPedido() async {
    String url = "https://www.google.com/maps/search/?api=1&query=-34.7746,-58.6433";
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black, title: Text("PODA-YA CORTADOR", style: TextStyle(color: Color(0xFF00FF88))), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // REGISTRO RAPIDO
            if(nombre.isEmpty)
              Column(children: [
                TextField(decoration: InputDecoration(labelText: "Tu Nombre", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), onChanged: (v)=> nombre=v),
                SizedBox(height: 10),
                TextField(decoration: InputDecoration(labelText: "Barrio", hintText: "Ej: Catán, Laferrere", filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), onChanged: (v)=> barrio=v),
                SizedBox(height: 20),
                SizedBox(width: double.infinity, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00FF88), padding: EdgeInsets.symmetric(vertical: 15)), onPressed: ()=> setState((){}), child: Text("GUARDAR Y EMPEZAR", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
              ])
            else ...[
              // BOTON DISPONIBLE
              SizedBox(height: 20),
              GestureDetector(
                onTap: ()=> setState(()=> disponible = !disponible),
                child: Container(
                  width: double.infinity, height: 150,
                  decoration: BoxDecoration(color: disponible ? Color(0xFF00FF88) : Colors.grey[800], borderRadius: BorderRadius.circular(25)),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(disponible ? Icons.check_circle : Icons.power_settings_new, size: 50, color: disponible ? Colors.black : Colors.white),
                    SizedBox(height: 10),
                    Text(disponible ? "ESTÁS DISPONIBLE" : "ESTÁS DESCONECTADO", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: disponible ? Colors.black : Colors.white)),
                  ]),
                ),
              ),
              SizedBox(height: 20),
              if(disponible && pedidoEntrante)
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("¡NUEVO PEDIDO CERCA!", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    SizedBox(height: 10),
                    Text("Corte de 85 m² en $barrio - a 400m"),
                    Text("Pagan: \$80.750 para vos (95%)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    Row(children: [
                      Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF00FF88)), onPressed: aceptarPedido, child: Text("ACEPTAR E IR", style: TextStyle(color: Colors.black)))),
                      SizedBox(width: 10),
                      Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[300]), onPressed: ()=> setState(()=> pedidoEntrante=false), child: Text("RECHAZAR", style: TextStyle(color: Colors.black)))),
                    ])
                  ]),
                ),
              Spacer(),
              Text("Ganancia de hoy: \$0 | Cortes: 0", style: TextStyle(color: Colors.white70)),
            ]
          ],
        ),
      ),
    );
  }
}
