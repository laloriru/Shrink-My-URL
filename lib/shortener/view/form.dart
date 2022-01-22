import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import 'package:clipboard/clipboard.dart';
import 'package:shortmyurl/shortener/bloc/shortener_cubit.dart';
import 'package:shortmyurl/shortener/model/links_db.dart' as database;

class ShortenerForm {
  ShortenerForm({required this.context}) : super();

  BuildContext context;
  final GlobalKey<FormState> urlFormKey = GlobalKey<FormState>();
  final urlTextFieldController = TextEditingController();
  String urlToShort = '';
  bool setFocus = true;

  submitForm() {
    urlFormKey.currentState?.save();
    if (urlToShort.isNotEmpty && isURL(urlToShort)) {
      BlocProvider.of<ShortenerCubit>(context).shrinkUrl(urlToShort);
    } else {
      const SnackBar _snackBar = SnackBar(
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(30.0),
          content: Text(
            'Incorrect URL submitted',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ));
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(_snackBar);
      });
    }
  } //

  pasteFromClipboard() {
    FlutterClipboard.paste().then((value) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        urlTextFieldController.text = value;
        urlToShort = value;
      });
    });
  } //

  clearForm() {
    urlFormKey.currentState?.reset();
  } //

  Widget form() {
    if (database.links.isNotEmpty) setFocus = false;
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: urlFormKey,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                          width: 280,
                          height: 80,
                          child: TextFormField(
                            autofocus: setFocus,
                            controller: urlTextFieldController,
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
                            onChanged: (String? data) {
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
                      IconButton(
                        icon: const Icon(Icons.content_paste, size: 25),
                        tooltip: 'Paste URL from clipboard',
                        onPressed: pasteFromClipboard,
                      )
                    ],
                  ))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: clearForm,
                child: const Text('Clear'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Short it'),
              ),
            ],
          )
        ]);
  } //submitUrlForm

} //
