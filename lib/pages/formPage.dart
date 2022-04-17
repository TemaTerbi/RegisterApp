import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _nameConroller = TextEditingController();
  final _emailConroller = TextEditingController();
  final _passlConroller = TextEditingController();
  final _passConfirmlConroller = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameConroller.dispose();
    _emailConroller.dispose();
    _passlConroller.dispose();
    _passConfirmlConroller.dispose();
    super.dispose();
  }

  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Страница регистрации'),
        centerTitle: true,
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameConroller,
              decoration: InputDecoration(
                labelText: 'Имя',
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
                hintText: 'Введите ваше имя',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.cyan),
                ),
              ),
              validator: _validateName,
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _emailConroller,
              decoration: InputDecoration(
                labelText: 'Почта',
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
                hintText: 'Введите вашу почту',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.cyan),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: _validateEmail,
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _passlConroller,
              maxLength: 10,
              obscureText: _hidePass,
              decoration: InputDecoration(
                labelText: 'Пароль',
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
                hintText: 'Придумайте пароль',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                  icon: Icon(Icons.visibility),
                ),
              ),
              validator: _validatePass,
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _passConfirmlConroller,
              maxLength: 10,
              obscureText: _hidePass,
              decoration: InputDecoration(
                labelText: 'Повтор пароля',
                labelStyle: TextStyle(
                  fontSize: 25,
                ),
                hintText: 'Повторите пароль',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.cyan),
                ),
              ),
              validator: _validatePass,
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () {
                _submitRegistration();
              },
              child: Text('Регистрация'),
              color: Colors.green,
              textColor: Colors.white,
              elevation: 10,
            ),
            SizedBox(height: 5,),
            RaisedButton(
              onPressed: () {
                _cleanForm();
              },
              child: Text('Отчистить форму'),
              color: Colors.redAccent,
              textColor: Colors.white,
              elevation: 10,
            ),
          ],
        ),
      ),
    );
  }

  void _submitRegistration() {
    if (_keyForm.currentState!.validate()) {
      print('Форма валидная');
      print('Имя: ${_nameConroller.text}');
      print('Почта: ${_emailConroller.text}');
    }
  }

  void _cleanForm(){
    _nameConroller.clear();
    _emailConroller.clear();
    _passlConroller.clear();
    _passConfirmlConroller.clear();
  }

  String? _validateName(value) {
    final _nameExp = RegExp(r'^[А-яа-я]+$');
    if (value.isEmpty) {
      return 'Нужно обязательно заполнить имя!';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Вводите только буквы!';
    } else {
      return null;
    }
  }

  String? _validateEmail(value) {
    if (value.isEmpty) {
      return 'Нужно обязательно заполнить почту';
    } else if (!_emailConroller.text.contains('@')) {
      return 'Неверный формат почты!';
    } else {
      return null;
    }
  }

  String? _validatePass(value) {
    if (value.isEmpty) {
      return 'Нужно обязательно заполнить пароль';
    } else if (_passlConroller.text != _passConfirmlConroller.text) {
      return 'Пароли не совпадают';
    } else if (_passlConroller.text.length != 10) {
      return 'Нужно 10 символов!';
    } else {
      return null;
    }
  }
}
