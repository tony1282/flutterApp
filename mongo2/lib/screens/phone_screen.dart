import 'package:flutter/material.dart';
import 'package:mongo2/models/phone_model.dart';
import 'package:mongo2/services/mongo_service.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  List<PhoneModel> phones = [];

  @override
  void initState() {
    super.initState();
    _fetchPhones();
  }

  @override
  void dispose(){
    // destruir esta screen cuando la app salga de esta ventana
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario de telefonos'),
      ),
      body: ListView.builder(
        itemCount: phones.length,
        itemBuilder: (context, index){
          var phone = phones [index];
          return oneTile(phone);
        }),
    );
  }

    void _fetchPhones() async {
    phones = await MongoService().getPhones();
    setState(() {});
  }


ListTile oneTile(PhoneModel phone) {
  return ListTile(
    title: Text(phone.marca),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(phone.modelo),
        SizedBox(height: 4), 
        Text('Existencia: ${phone.existencia}'),
        SizedBox(height: 4),
        Text('Precio: \$${phone.precio.toStringAsFixed(2)}'), 
      ],
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            // Agregar funcionalidad de edición
            print('Edit button pressed');
          },
          icon: Icon(Icons.edit),
        ),
        IconButton(
          onPressed: () {
            // Agregar funcionalidad de eliminación
            print('Delete button pressed');
          },
          icon: Icon(Icons.delete),
        ),
      ],
    ),
  );
}

}