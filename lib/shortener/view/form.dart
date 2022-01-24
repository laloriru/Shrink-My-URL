import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import 'package:clipboard/clipboard.dart';
import 'package:shortmyurl/shortener/controller/shortener_cubit.dart';
import 'package:shortmyurl/snackbar.dart';

class ShortenerForm extends StatelessWidget {
  ShortenerForm() : super(key: const Key('ShortenerForm'));

  GlobalKey<FormState> urlFormKey = GlobalKey<FormState>();
  TextEditingController urlTextFieldController = TextEditingController();
  String urlToShrink = '';

  @override
  Widget build(BuildContext context) {
    submitForm() async {
      urlFormKey.currentState?.save();
      if (urlToShrink.isNotEmpty && isURL(urlToShrink)) {
        BlocProvider.of<ShortenerCubit>(context).shrinkUrl(urlToShrink);
      } else {
        CustomSnackbar(context)
            .show('Incorrect URL submitted', Colors.red, Colors.white);
      }
    } //

    pasteFromClipboard() {
      FlutterClipboard.paste().then((value) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          urlTextFieldController.text = value;
          urlToShrink = value;
        });
      });
    } //

    clearForm() {
      urlToShrink = '';
      urlFormKey.currentState?.reset();
    } //

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
          color: Colors.white70,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          child: Center(
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
                            autofocus: false,
                            controller: urlTextFieldController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            autocorrect: true,
                            maxLines: 1,
                            validator: (String? link) {
                              if (!isURL(link!) && link.trim() != '') {
                                return 'Wrong URL, please check this value';
                              }
                              return null;
                            },
                            onChanged: (String? data) {
                              urlToShrink = data!.trim();
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
                  )))),
      Container(
          color: Colors.white70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: clearForm,
                child: const Text('Clear form'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: submitForm,
                child: const Text('Short it'),
              ),
            ],
          ))
    ]);
  } //submitUrlForm

} //
