import 'package:flutter/material.dart';

class EditMedicineScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditMedicineScreenState createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> {
  var _isInit = true;
  var _title = 'Add Medicine';

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final medicineId = ModalRoute.of(context).settings.arguments as String;
      if (medicineId != null) {
        /*final product =
            Provider.of<Products>(context, listen: false).findById(productId);
        _editedProduct = product;
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          // 'imageUrl': _editedProduct.imageUrl,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;*/

        //_title = 'Edit ${_editedMedicine.title}';
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            disabledColor: Colors.grey,
            color: Colors.white,
            icon: Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
