import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class ShortenerForm {
  ShortenerForm(this.context) : super();

  BuildContext context;
  final GlobalKey<FormState> urlFormKey = GlobalKey<FormState>();
  String urlToShort = '';

  submitForm () {
    urlFormKey.currentState?.save();
    if (urlToShort.isNotEmpty) {

    } else {
      print('HERE');
      const SnackBar _snackBar = SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(30.0),
          content: Text('Error',
              textAlign: TextAlign.center));
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      });
    }
  }//

  clearForm () {
    urlFormKey.currentState?.reset();
  }//

  Widget form() {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
                autovalidateMode: AutovalidateMode.always,
                key: urlFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: 300,
                        height: 70,
                        child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.name,
                          textCapitalization: TextCapitalization.words,
                          autocorrect: true,
                          maxLines: 1,
                          validator: (String? link) {
                            if (!isURL(link!) && link != '') {
                              return 'Wrong URL, please check this value';
                            }
                            return null;
                          },
                          onChanged: (String? data){
                            urlToShort = data!.trim();
                          },
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.link),
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 20.0),
                            isDense: true,
                            labelText: 'Enter URL to shrink here',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                        )),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: clearForm,
                          child: const Text('Clear'),
                        ),
                        const SizedBox(width: 30),
                        ElevatedButton(
                          onPressed: submitForm,
                          child: const Text('Short it'),
                        ),
                      ],
                    ),
                  ],
                )));
  } //submitUrlForm

} //
