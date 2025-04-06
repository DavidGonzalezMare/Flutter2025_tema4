import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const titol = 'Formulari amb validacions';

    return MaterialApp(
      title: titol,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(titol),
        ),
        body: const MyRegisterForm(),
      ),
    );
  }
}

// Creamos un widget con estado
class MyRegisterForm extends StatefulWidget {
  const MyRegisterForm({super.key});

  @override
  MyRegisterFormState createState() {
    return MyRegisterFormState();
  }
}

// Creamos una clase de tipo State
class MyRegisterFormState extends State<MyRegisterForm> {
  // Para esta clase vamos a crear una clve global, de tipo
  // FormState que nos sirva para identificar el widget en 
  // el árbolo de widgets y por tanto poder validar el formulario.

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _controlador = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      // Añadimos como clave del formulario la clave _formKey que hemos generado
      key: _formKey,
      // Organizamos los diferentes widgets del formulario en un ListView
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // Para crear los distintos widgets hemos creado los tres métodos siguientes
          // de manera que aligeremos el código del método build:
          createRegisterNameFormField(),
          createCheckboxConditionsFormField(),
          createSubmitButton(context),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Inicializamos el texto del controlador
    _controlador.text = "";
  }

  @override
  void dispose() {
    // Liberamos el controlador cuando el widget se elimine
    _controlador.dispose();
    super.dispose();
  }

  TextFormField createRegisterNameFormField() {
    // Crea el widget de tipo TextFormField
    return TextFormField(
      // Definimos el controlador
      controller: _controlador,
      // Con la propiedad validator definimos las validaciones
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'El nombre no puede estar vacío';
        }
        // Expresión regular para validar un correo electrónico
        final regexCorreu = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

        // Validación del correo con la expresión regular
        if (!regexCorreu.hasMatch(value ?? "")) {
          return 'La dirección de correo no es válida';
        }
        return null;
      },

      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          icon: const Icon(Icons.email),
          labelText: "Dirección de correo"),
    );
  }

  FormField<bool> createCheckboxConditionsFormField() {
    // Creamos un FormField para envolver al Checkbox
    return FormField(
      // Damos un valor inicial
      initialValue: false,
      // Definimos las validaciones sobre el valor
      validator: (value) {
        if (!value!) {
          return 'Ha de aceptar las condiciones';
        }
        return null;
      },
      // Constructor del widget. Recibimos en field 
      // el estado del FormField.
      builder: (FormFieldState<dynamic> field) {
        return CheckboxListTile(
          // El valor del widget será el que tenga el FormField
          value: field.value,
          title: const Text("He leído y acepto las condiciones"),
          // Utilizamos el subtítulo para indicar los mensajes de error
          subtitle: Text(
            field.errorText ?? "",
            style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 12,
                color: Colors.red[700],
                height: 0.5),
          ),
          // Cuando se haga click en el checkbox,
          // se llama a onChanged, que habrá de notificar al
          // formField que este ha cambiado de valor haciondo uso
          // del método didChange (sin necesidad de llamar a setState!)
          onChanged: (bool? value) {
            field.didChange(value);
          },
        );
      },
    );
  }

  // Botón para enviar el formulario previa validación
  Widget createSubmitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          // Accedemos al formulario haciendo uso de _formKey.
          // Desde aquí accedemos al estado actual mediante currentState,
          // y lo validamos con el método "validate".
          // Este método llamará a todas las validaciones de cada widget.
          // Si todas son válidas, el formulario es válido.

          if (_formKey.currentState?.validate() ?? false) {
            // De momento, mostraremos un Snackbar para indicar
            // que el formulario es correcto.

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'Los datos se han procesado correctamente: ${_controlador.text}'),
              ),
            );
          }
        },
        child: const Text('Regístrate'),
      ),
    );
  }
}