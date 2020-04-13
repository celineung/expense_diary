import 'package:expense_diary/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Type {
  String text;
  Widget icon;

  Type(String text, Widget icon) {
    this.text = text;
    this.icon = icon;
  }
}

class InputTypeService {
  static final Type income = new Type('Income', Icon(Icons.local_bar));
  static final Type expense = new Type('Expense', Icon(Icons.local_bar));

  static List<Type> all() {
    return [
      income,
      expense,
    ];
  }
}

class CategoryService {
  static final Type entertainment =
      new Type('Entertainment', Icon(Icons.local_bar));
  static final Type friends =
      new Type('Friends', Icon(Icons.supervisor_account));
  static final Type home = new Type('Home', Icon(Icons.home));

  static final Type dailyLiving =
      new Type('Daily living', Icon(Icons.local_grocery_store));
  static final Type healthCare =
      new Type('Health care', Icon(Icons.local_hospital));
  static final Type salary = new Type('Salary', Icon(Icons.work));
  static final Type shopping = new Type('Shopping', Icon(Icons.local_mall));
  static final Type taxes = new Type('Taxes', Icon(Icons.account_balance));
  static final Type transportation =
      new Type('Transportation', Icon(Icons.subway));

  static List<Type> all() {
    return [
      entertainment,
      friends,
      home,
      dailyLiving,
      healthCare,
      salary,
      shopping,
      taxes,
      transportation,
    ];
  }
}

class ExpenseCreation extends StatefulWidget {
  ExpenseCreation({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ExpenseCreationState createState() => _ExpenseCreationState();
}

class _ExpenseCreationState extends State<ExpenseCreation> {
  final _formKey = GlobalKey<FormState>();

  String _selectedInputType = InputTypeService.expense.text;
  String _selectedCategory = CategoryService.dailyLiving.text;
  TextEditingController datePickerCtrl =
      new TextEditingController(text: DateUtils.toDateStr(DateTime.now()));
  TextEditingController amountCtrl = new TextEditingController(text: "0");

  @override
  void dispose() {
    datePickerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New entry'),
        ),
        body: _buildForm());
  }

  Widget _buildForm() {
    return Builder(
      builder: (context) => Container(
          margin: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Wrap(runSpacing: 10, children: <Widget>[
                _buildInputTypeDropDown(),
                _buildAmountInput(),
                _buildDatePickerInput(),
                _buildCategoryDropDown(),
                _buildSubmitButton(context)
              ]))),
    );
  }

  Widget _buildInputTypeDropDown() {
    return ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<String>(
            value: _selectedInputType,
            items: _buildInputTypeDropdownMenuItems(),
            decoration:
                InputDecoration(labelText: 'Type', fillColor: Colors.white),
            onChanged: (String newValue) {
              setState(() {
                _selectedInputType = newValue;
              });
            }));
  }

  List<DropdownMenuItem<String>> _buildInputTypeDropdownMenuItems() {
    return InputTypeService.all()
        .map<DropdownMenuItem<String>>((Type inputType) {
      return DropdownMenuItem<String>(
          value: inputType.text,
          child: Row(children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 10), child: inputType.icon),
            Text(inputType.text)
          ]));
    }).toList();
  }

  Widget _buildAmountInput() {
    String originalAmount = '0';
    return TextFormField(
      controller: amountCtrl,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          labelText: 'Amount', suffixIcon: Icon(Icons.euro_symbol)),
      onTap: () {
        originalAmount = amountCtrl.text;
        amountCtrl.clear();
      },
      onEditingComplete: () {
        if (amountCtrl.text.isEmpty || double.parse(amountCtrl.text) == 0) {
          setState(() {
            amountCtrl.text = originalAmount;
          });
        }
      },
      validator: (value) {
        print(value);
        if (value.isEmpty || double.parse(value) == 0) {
          return 'Please enter a value';
        }
        return null;
      },
    );
  }

  Widget _buildDatePickerInput() {
    return InkWell(
        onTap: () {
          _showDatePicker();
        },
        child: IgnorePointer(
          child: new TextFormField(
            controller: datePickerCtrl,
            decoration: InputDecoration(
                labelText: 'Transaction date',
                suffixIcon:
                    Icon(Icons.arrow_drop_down, color: Colors.grey.shade700)),
          ),
        ));
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(3000),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    ).then((date) {
      setState(() {
        if (date == null) {
          return;
        }
        datePickerCtrl.text = DateUtils.toDateStr(date);
      });
    });
  }

  Widget _buildCategoryDropDown() {
    return ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<String>(
          value: _selectedCategory,
          items: _buildCategoryDropdownMenuItems(),
          decoration: InputDecoration(
            labelText: 'Category',
          ),
          onChanged: (String newValue) {
            setState(() {
              _selectedCategory = newValue;
            });
          },
        ));
  }

  List<DropdownMenuItem<String>> _buildCategoryDropdownMenuItems() {
    return CategoryService.all().map<DropdownMenuItem<String>>((Type category) {
      return DropdownMenuItem<String>(
          value: category.text,
          child: Row(children: <Widget>[
            Container(
                padding: EdgeInsets.only(right: 10), child: category.icon),
            Text(category.text)
          ]));
    }).toList();
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 35),
        child: Center(
            child: RaisedButton(
          child: Text('Submit'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('New entry saved'),
                duration: Duration(seconds: 3),
                action: SnackBarAction(
                  label: 'Hide',
                  onPressed: () {
                    Scaffold.of(context).hideCurrentSnackBar();
                  },
                ),
              ));
            }
            print(datePickerCtrl.text +
                " " +
                _selectedInputType +
                " " +
                _selectedCategory +
                " " +
                amountCtrl.text);
          },
        )));
  }
}
