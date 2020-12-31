import 'package:Medicines/models/customer.dart';
import 'package:Medicines/providers/customers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditCustomerScreen extends StatefulWidget {
  static const routeName = '/edit-customer';
  @override
  _EditCustomerScreenState createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  var _title = 'Add Customer';
  var _isInit = true;
  var _isLoading = false;

  RegExp phoneReg = RegExp(r'^01[0-9]{9}$');

  Customer customer;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final customerId = ModalRoute.of(context).settings.arguments as String;
      if (customerId != null) {
        customer = Provider.of<CustomersProvider>(context, listen: false)
            .findById(customerId);

        _title = 'Edit ${customer.name}';
      } else {
        customer = Customer(
          id: '',
          name: '',
          phone: '',
          paidAmt: 0.0,
          balanceAmt: 0.0,
          purchasedAmt: 0.0,
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
                  initialValue: customer.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    customer = customer.copyWith(name: value);
                  },
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter name';
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  initialValue: customer.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    hintText: '01*********',
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (value) {
                    customer = customer.copyWith(phone: value);
                  },
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter phone';
                    else if (!phoneReg.hasMatch(value)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
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
        if (customer.id == '') {
          await Provider.of<CustomersProvider>(context, listen: false)
              .addCustomer({
            'name': customer.name,
            'phone': customer.phone,
            'balanceAmt': 0.0,
            'purchasedAmt': 0.0,
            'paidAmt': 0.0,
          });
        }

        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
