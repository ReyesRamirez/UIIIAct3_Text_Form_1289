import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String clientId;
  final String clientName;
  final String clientEmail;
  final String clientPhone;
  final String clientAddress;
  final bool clientIsActive;
  final String clientRegistrationDate;

  const Details({
    Key? key,
    required this.clientId,
    required this.clientName,
    required this.clientEmail,
    required this.clientPhone,
    required this.clientAddress,
    required this.clientIsActive,
    required this.clientRegistrationDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        centerTitle: true,
        title: const Text("Detalles del Cliente"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            _buildDetailRow(
              icon: Icons.perm_identity,
              label: "ID del Cliente:",
              value: clientId,
            ),
            _buildDetailRow(
              icon: Icons.person,
              label: "Nombre:",
              value: clientName,
            ),
            _buildDetailRow(
              icon: Icons.email,
              label: "Email:",
              value: clientEmail,
            ),
            _buildDetailRow(
              icon: Icons.phone,
              label: "Teléfono:",
              value: clientPhone,
            ),
            _buildDetailRow(
              icon: Icons.location_on,
              label: "Dirección:",
              value: clientAddress,
            ),
            _buildDetailRow(
              icon: Icons.check_circle_outline,
              label: "Activo:",
              value: clientIsActive ? 'Sí' : 'No',
              valueColor: clientIsActive ? Colors.green : Colors.red,
            ),
            _buildDetailRow(
              icon: Icons.calendar_today,
              label: "Fecha de Registro:",
              value: clientRegistrationDate,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build consistent detail rows
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color valueColor = Colors.black87, // Default text color
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color.fromARGB(255, 136, 117, 205), size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    color: valueColor,
                  ),
                  softWrap: true, // Allow text to wrap for long values like addresses
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}