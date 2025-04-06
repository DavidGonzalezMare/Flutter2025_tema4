import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: EjemploForms2(),
        ),
      ),
    );
  }
}


// En primer lugar, definimos el widget como un widget con estado
class EjemploForms2 extends StatefulWidget {
  const EjemploForms2({super.key});

  // Sobreescrimbimos el método createState() para crear el estado  @override
  State<EjemploForms2> createState() => _EjemploForms2State();
}

// Clase para el estado
class _EjemploForms2State extends State<EjemploForms2> {
  // Definimos el contenido como propiedad
  String? contenido;

  @override
  void initState() {
    super.initState();
    // Inicializamos el contenido
    contenido = "";
  }

  // Construimos el widget
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (text) {
            // Cuando cambie el contenido, actualizaremos
            // la propiedad correspondiente de el estado y 
            // lo notificaremos con setStat
            setState(() {
              contenido = text;
            });
          },
        ),
        const Divider(),
        // Añadimos un segundo widget de tipo texto que 
        // muestra el contenido
        Text("$contenido"),
      ]),
    );
  }
}
