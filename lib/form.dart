import 'package:flutter/material.dart';
import 'package:myapp/details.dart'; // Assuming 'details.dart' is where you want to display the client information

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _registrationDateController = TextEditingController();

  bool _isActive = true; // Default value for active status
  DateTime? _selectedDate; // To store the selected registration date

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _registrationDateController.dispose();
    super.dispose();
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.deepPurple.shade300, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: Colors.deepPurple, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.deepPurple, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _registrationDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text("Registro de Cliente"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            MyTextField(
              myController: _idController,
              fieldName: "ID del Cliente",
              myIcon: Icons.perm_identity,
              prefixIconColor: Colors.deepPurple.shade300,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10.0),
            MyTextField(
              myController: _nameController,
              fieldName: "Nombre",
              myIcon: Icons.person,
              prefixIconColor: Colors.deepPurple.shade300,
            ),
            const SizedBox(height: 10.0),
            MyTextField(
              myController: _emailController,
              fieldName: "Email",
              myIcon: Icons.email,
              prefixIconColor: Colors.deepPurple.shade300,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10.0),
            MyTextField(
              myController: _phoneController,
              fieldName: "Teléfono",
              myIcon: Icons.phone,
              prefixIconColor: Colors.deepPurple.shade300,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10.0),
            MyTextField(
              myController: _addressController,
              fieldName: "Dirección",
              myIcon: Icons.location_on,
              prefixIconColor: Colors.deepPurple.shade300,
              maxLines: 3, // Allow multiple lines for address
            ),
            const SizedBox(height: 10.0),
            ListTile(
              title: const Text("Cliente Activo"),
              trailing: Switch(
                value: _isActive,
                onChanged: (bool value) {
                  setState(() {
                    _isActive = value;
                  });
                },
                activeColor: Colors.deepPurple.shade300,
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: MyTextField(
                  myController: _registrationDateController,
                  fieldName: "Fecha de Registro",
                  myIcon: Icons.calendar_today,
                  prefixIconColor: Colors.deepPurple.shade300,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            myBtn(context),
          ],
        ),
      ),
    );
  }

  // Function that returns OutlinedButton Widget also it pass data to Details Screen
  OutlinedButton myBtn(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            // Pass all the collected data to the Details screen
            return Details(
              clientId: _idController.text,
              clientName: _nameController.text,
              clientEmail: _emailController.text,
              clientPhone: _phoneController.text,
              clientAddress: _addressController.text,
              clientIsActive: _isActive,
              clientRegistrationDate: _registrationDateController.text,
            );
          }),
        );
      },
      child: Text(
        "Enviar Formulario".toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

//Custom Stateless Widget Class that helps re-usability
class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    required this.fieldName,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIconColor = Colors.blueAccent,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  final TextEditingController myController;
  final String fieldName;
  final IconData myIcon;
  final Color prefixIconColor;
  final TextInputType keyboardType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(myIcon, color: prefixIconColor),
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple.shade300),
        ),
        labelStyle: const TextStyle(color: Colors.deepPurple),
      ),
    );
  }
}