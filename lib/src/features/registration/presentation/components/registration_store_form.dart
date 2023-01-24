import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possch/src/core/extensions/double_extension.dart';
import 'package:possch/src/features/product_type/presentation/product_type_widget.dart';
import 'package:possch/src/features/registration/presentation/cubit/registration_data_cubit.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/inputs/text_input_field.dart';
import '../cubit/product_type_cubit.dart';

class RegistrationStoreForm extends StatelessWidget {
  RegistrationStoreForm({super.key});

  final productTypes = [
    {
      "code": "food",
      "value": "FOOD",
    },
    {
      "code": "beverages",
      "value": "BEVERAGES",
    },
    {
      "code": "fnb",
      "value": "FOOD & BEVERAGES",
    },
  ];

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultPadding.heightSizedBox,
        BlocBuilder<StoreValidationCubit, String?>(
          builder: (context, state) {
            return TextInputField(
                    controller: _nameController,
                    labelText: "input your store name here",
                    errorText: state)
                .child;
          },
        ),
        defaultPadding.heightSizedBox,
        const Text("Your Product Type"),
        defaultPadding.heightSizedBox,
        const ProductTypeWidget(),
        Flexible(
          fit: FlexFit.tight,
          child: Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: () {
                  context
                      .read<StoreValidationCubit>()
                      .validate(name: _nameController.text);
                  context.read<RegistrationDataCubit>().initStore(
                      name: _nameController.text,
                      type: context.read<ProductTypeCubit>().state);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 30,
                )),
          ),
        )
      ],
    );
  }
}

class StoreValidationCubit extends Cubit<String?> {
  StoreValidationCubit() : super(null);

  validate({String? name}) {
    emit((name ?? '').isEmpty ? "Store Name couldn't empty" : null);
  }
}
