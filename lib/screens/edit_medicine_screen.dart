import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/medicine_image_picker.dart';

import '../providers/medicines_provider.dart';
// import '../widgets/edit_medicine_form.dart';

import '../models/medicine.dart';

class EditMedicineScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditMedicineScreenState createState() => _EditMedicineScreenState();
}

class _EditMedicineScreenState extends State<EditMedicineScreen> {
  final _formKey = GlobalKey<FormState>();
  var _title = 'Add Medicine';
  var _isInit = true;
  var _isLoading = false;
  Medicine medicine;
  File _pickedImage;

  void _pickImage(File image) {
    _pickedImage = image;
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final medicineId = ModalRoute.of(context).settings.arguments as String;
      if (medicineId != null) {
        medicine = Provider.of<MedicinesProvider>(context, listen: false)
            .findById(medicineId);

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

        _title = 'Edit ${medicine.name}';
      } else {
        medicine = Medicine(
          id: '',
          name: '',
          consumerPrice: 0.0,
          listPrice: 0.0,
          qty: 0.0,
          createdAt: Timestamp.now(),
          modifiedAt: Timestamp.now(),
        );
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
          !_isLoading
              ? IconButton(
                  disabledColor: Colors.grey,
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.save),
                  onPressed: _trySubmit,
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
        ],
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: medicine.name,
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (_) {
                      //FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      medicine = medicine.copyWith(name: value);
                    },
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter name';
                      return null;
                    },
                  ),
                  TextFormField(
                    maxLines: 3,
                    keyboardType: TextInputType.text,
                    initialValue: medicine.description,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.sentences,
                    onFieldSubmitted: (_) {
                      //FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      medicine = medicine.copyWith(description: value);
                    },
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          initialValue: medicine.listPrice != 0
                              ? medicine.listPrice.toString()
                              : null,
                          decoration: InputDecoration(
                            labelText: 'List Price',
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.sentences,
                          onFieldSubmitted: (_) {
                            //FocusScope.of(context).requestFocus(_priceFocusNode);
                          },
                          onSaved: (value) {
                            medicine = medicine.copyWith(
                                listPrice: double.parse(value));
                          },
                          validator: (value) {
                            if (value.isEmpty) return 'Please enter list price';
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Flexible(
                        child: TextFormField(
                          initialValue: medicine.consumerPrice != 0
                              ? medicine.consumerPrice.toString()
                              : null,
                          decoration: InputDecoration(
                            labelText: 'Consumer Price',
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.sentences,
                          onFieldSubmitted: (_) {
                            //FocusScope.of(context).requestFocus(_priceFocusNode);
                          },
                          onSaved: (value) {
                            medicine = medicine.copyWith(
                                consumerPrice: double.parse(value));
                          },
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please enter consumer price';
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue:
                        medicine.qty != 0 ? medicine.qty.toString() : null,
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                    ),
                    // textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.sentences,
                    onFieldSubmitted: (_) {
                      //FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      var qty = 0.0;
                      final values = value.split('+');
                      values.forEach((element) {
                        qty += double.parse(element);
                      });

                      medicine = medicine.copyWith(qty: qty);
                    },
                    validator: (value) {
                      if (value.isEmpty) return 'Please enter quantity';
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  MedicineImagePicker(_pickImage, medicine.imageUrl),
                ],
              ),
            ),
          )

          /*EditMedicineForm(
          _submitForm,
          medicine ??
              Medicine(
                id: '',
                name: '',
                consumerPrice: 0.0,
                listPrice: 0.0,
                qty: 0.0,
                createdAt: Timestamp.now(),
                modifiedAt: Timestamp.now(),
              ),
            ),*/
          ),
    );
  }

  void _trySubmit() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });

      try {
        var imageUrl = medicine.imageUrl;

        if (_pickedImage != null) {
          final ref = FirebaseStorage.instance
              .ref()
              .child('medicines')
              .child('${medicine.name}.jpg');

          await ref.putFile(_pickedImage);
          imageUrl = await ref.getDownloadURL();
        }
        final user = FirebaseAuth.instance.currentUser;
        if (medicine.id == '') {
          await Provider.of<MedicinesProvider>(context, listen: false)
              .addMedicine({
            'name': medicine.name,
            'listPrice': medicine.listPrice,
            'consumerPrice': medicine.consumerPrice,
            'qty': medicine.qty,
            'soldQty': 0.0,
            'soldAmount': 0.0,
            'description': medicine.description ?? '',
            'imageUrl': imageUrl,
            'createdAt': Timestamp.now(),
            'createdById': user.uid,
            'createdByName': user.displayName,
            'modifiedAt': Timestamp.now(),
            'modifiedById': user.uid,
            'modifiedByName': user.displayName,
          });
        } else {
          await Provider.of<MedicinesProvider>(context, listen: false)
              .editMedicine(medicine.id, {
            'name': medicine.name,
            'listPrice': medicine.listPrice,
            'consumerPrice': medicine.consumerPrice,
            'qty': medicine.qty,
            'soldQty': medicine.soldQty,
            'soldAmount': medicine.soldAmount,
            'description': medicine.description ?? '',
            'imageUrl': imageUrl,
            'createdAt': medicine.createdAt,
            'createdById': medicine.createdById,
            'createdByName': medicine.createdByName,
            'modifiedAt': Timestamp.now(),
            'modifiedById': user.uid,
            'modifiedByName': user.displayName,
          });
        }
        Navigator.of(context).pop();
      } on Exception catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
