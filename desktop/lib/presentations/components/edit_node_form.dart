import 'package:desktop/dal/models/node_ui.dart';
import 'package:desktop/utils/colors.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';

// class UniqueEmailAsyncValidator extends AsyncValidator<dynamic> {
//   @override
//   Future<Map<String, dynamic>?> validate(
//       AbstractControl<dynamic> control) async {
//     final error = {'unique': false};

//     final isUniqueEmail = await _getIsUniqueEmail(control.value.toString());
//     if (!isUniqueEmail) {
//       control.markAsTouched();
//       return error;
//     }

//     return null;
//   }

//   /// Simulates a time consuming operation (i.e. a Server request)
//   Future<bool> _getIsUniqueEmail(String email) {
//     // simple array that simulates emails stored in the Server DB.
//     final storedEmails = ['johndoe@email.com', 'john@email.com'];

//     return Future.delayed(
//       const Duration(seconds: 5),
//       () => !storedEmails.contains(email),
//     );
//   }
// }

// ignore: must_be_immutable
class EditNodeForm extends StatefulWidget {
  Function onSubmit;
  NodeUi? selectedNode;

  EditNodeForm({this.selectedNode, required this.onSubmit, super.key});

  @override
  State<EditNodeForm> createState() => _EditNodeFormState();
}

class _EditNodeFormState extends State<EditNodeForm> {
  FormGroup buildForm(NodeUi? selectedNode) => fb.group(<String, Object>{
        'name': FormControl<String>(
            value: selectedNode?.name ?? "", validators: [Validators.required]),
        'path':
            FormControl<String>(value: selectedNode?.path ?? "", validators: [
          Validators.required,
          Validators.minLength(8),
        ]),
      });

  bool _loading = false;

  @override
  void initState() {
    syncInit();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EditNodeForm oldWidget) {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 500))
        .then((value) => setState(() => _loading = false));
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      replacement: const Center(child: CircularProgressIndicator()),
      visible: !_loading,
      child: ReactiveFormBuilder(
        key: widget.key,
        form: () => buildForm(widget.selectedNode),
        builder: (context, form, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: ReactiveTextField(
                  formControlName: 'name',
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'The name must not be empty',
                  },
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CustomColors.accentBlue)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    labelText: 'Name',
                    helperText: '',
                    helperStyle: TextStyle(height: 0.7),
                    errorStyle: TextStyle(height: 0.7),
                  ),
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
              Tooltip(
                message: form.value["path"].toString(),
                child: ReactiveTextField(
                  formControlName: 'path',
                  validationMessages: {
                    ValidationMessage.required: (_) =>
                        'The Path must not be empty',
                    ValidationMessage.minLength: (_) =>
                        'The Path must be at least 8 characters',
                  },
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: CustomColors.accentBlue)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    labelText: 'Path',
                    helperText: '',
                    helperStyle: TextStyle(height: 0.7),
                    errorStyle: TextStyle(height: 0.7),
                  ),
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _onUpdate(form),
                child: Text(widget.selectedNode != null ? "Update" : 'Create'),
              ),
            ],
          );
        },
      ),
    );
  }

  void syncInit() {}

  void _onUpdate(form) {
    if (form.valid) {
      form.resetState(
        {
          'name': ControlState<String>(value: ''),
          'path': ControlState<String>(value: ''),
        },
        removeFocus: true,
      );
      widget.onSubmit(form.value['name'], form.value['path']);
    } else {
      form.markAllAsTouched();
    }
  }
}
