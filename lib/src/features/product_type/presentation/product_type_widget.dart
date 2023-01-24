import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:possch/src/core/widgets/texts/sub_title_text.dart';
import 'package:possch/src/features/product_type/domain/entities/product_type.dart';
import 'package:possch/src/features/registration/presentation/cubit/product_type_cubit.dart';
import 'package:possch/src/service_locator.dart';

import '../domain/usecase/fetch_product_type_usecase.dart';

class ProductTypeWidget extends StatelessWidget {
  const ProductTypeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductType>>(
        stream: sl<FetchProductTypeUseCase>().fetch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              List<ProductType> items = snapshot.data ?? [];
              context.read<ProductTypeCubit>().init(items[0]);
              if (items.isNotEmpty) {
                return BlocBuilder<ProductTypeCubit, ProductType?>(
                  builder: (context, state) {
                    return DropdownButton<ProductType>(
                        isExpanded: true,
                        value: state ?? items[0],
                        items: items
                            .map((e) => DropdownMenuItem<ProductType>(
                                value: e, child: Text(e.name!.toUpperCase())))
                            .toList(),
                        onChanged: (val) {
                          context.read<ProductTypeCubit>().update(val!);
                        });
                  },
                );
              }
            }
            return SubTitleText(
              text: "no found product type",
              color: Colors.grey.shade300,
              textAlign: TextAlign.center,
            ).child;
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
