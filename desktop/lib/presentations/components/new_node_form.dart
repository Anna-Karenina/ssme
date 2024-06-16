import 'package:desktop/utils/colors.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';

// ignore: must_be_immutable
class EditNodeForm extends StatelessWidget {
  Function onSubmit;

  EditNodeForm({required this.onSubmit, super.key});

  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(
          validators: [Validators.required],
        ),
        'path': ['', Validators.required, Validators.minLength(8)],
      });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: buildForm,
      builder: (context, form, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReactiveTextField<String>(
              formControlName: 'name',
              validationMessages: {
                ValidationMessage.required: (_) => 'The name must not be empty',
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.accentBlue)),
                contentPadding: EdgeInsets.symmetric(vertical: 1),
                labelText: 'Name',
                helperText: '',
                helperStyle: TextStyle(height: 0.7),
                errorStyle: TextStyle(height: 0.7),
              ),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
            ReactiveTextField<String>(
              formControlName: 'path',
              obscureText: true,
              validationMessages: {
                ValidationMessage.required: (_) => 'The Path must not be empty',
                ValidationMessage.minLength: (_) =>
                    'The Path must be at least 8 characters',
              },
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.accentBlue)),
                contentPadding: EdgeInsets.symmetric(vertical: 1),
                labelText: 'Path',
                helperText: '',
                helperStyle: TextStyle(height: 0.7),
                errorStyle: TextStyle(height: 0.7),
              ),
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (form.valid) {
                  form.resetState(
                    {
                      'name': ControlState<String>(value: ''),
                      'path': ControlState<String>(value: ''),
                    },
                    removeFocus: true,
                  );
                  onSubmit(form.value['name'], form.value['path']);
                } else {
                  form.markAllAsTouched();
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
