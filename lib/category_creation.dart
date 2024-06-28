import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';
import '../../bloc/create_categorybloc/create_category_bloc.dart';
import '../../packages/expense_repository.dart';

Future getCategoryCreation(BuildContext context) {
  List<String> myCategoriesIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel'
  ];
  return showDialog(
      context: context,
      builder: (ctx) {
        bool isExpanded = false;
        String iconSelected = "";
        Color categoryColor = Colors.white;
        TextEditingController categoryNameController = TextEditingController();
        TextEditingController categoryIconController = TextEditingController();
        TextEditingController categoryColorController = TextEditingController();
        bool isLoading = false;
        Category category = Category.empty;

        return BlocProvider.value(
          value: context.read<CreateCategoryBloc>(),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return BlocListener<CreateCategoryBloc, CreateCategoryState>(
                  listener: (context, state) {
                    if (state is CreateCategorySuccess) {
                      Navigator.pop(ctx, category);
                    } else if (state is CreateCategoryLoading) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                  },
                  child: AlertDialog(
                    title: Text('Create a Category'),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: categoryNameController,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                hintText: 'Name',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: categoryIconController,
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.expand_more,
                                  size: 12,
                                ),
                                isDense: true,
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                hintText: 'Icon',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: isExpanded
                                        ? BorderRadius.vertical(
                                            top: Radius.circular(12),
                                          )
                                        : BorderRadius.circular(12))),
                          ),
                          isExpanded
                              ? Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GridView.builder(
                                        shrinkWrap: true,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5,
                                        ),
                                        itemCount: myCategoriesIcons.length,
                                        itemBuilder: (context, int i) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                iconSelected =
                                                    myCategoriesIcons[i];
                                              });
                                            },
                                            child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 3,
                                                        color: iconSelected ==
                                                                myCategoriesIcons[
                                                                    i]
                                                            ? Colors.blue
                                                            : Colors.grey),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "lib/images/${myCategoriesIcons[i]}.png")))),
                                          );
                                        }),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(12),
                                      )),
                                )
                              : Container(),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: categoryColorController,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx2) {
                                  return AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ColorPicker(
                                            pickerColor: categoryColor,
                                            onColorChanged: (value) {
                                              setState(() {
                                                categoryColor = value;
                                              });
                                            }),
                                        SizedBox(
                                          width: double.infinity,
                                          height: kToolbarHeight,
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.pop(ctx2);
                                            },
                                            style: TextButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12))),
                                            child: const Text(
                                              'Save Color',
                                              style: TextStyle(
                                                fontSize: 27,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: categoryColor,
                                hintText: 'Color',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: kToolbarHeight,
                            child: isLoading == true
                                ? Center(child: CircularProgressIndicator())
                                : TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLoading = !isLoading;
                                        category.categoryId = const Uuid().v1();
                                        category.name =
                                            categoryNameController.text;
                                        category.icon = iconSelected;
                                        category.color = categoryColor.value;
                                      });

                                      context
                                          .read<CreateCategoryBloc>()
                                          .add(CreateCategory(category));
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                        fontSize: 27,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        );
      });
}
