import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:monex/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:monex/bloc/get_categories_bloc/get_categories_bloc.dart';
import 'package:monex/category_creation.dart';
import 'package:monex/packages/category.dart';
import 'package:monex/packages/expense.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selectDate = DateTime.now();
  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    expense = Expense.empty;
    expense.expenseId = const Uuid().v1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          Navigator.pop(context, expense); // Return the created expense
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
                builder: (context, state) {
              if (state is GetCategoriesSuccess) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Add Expenses",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: 250,
                        child: TextFormField(
                          controller: expenseController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              hintText: 'Expense',
                              prefixIcon: Icon(
                                Icons.money,
                                color: Colors.grey.shade500,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: categoryController,
                        readOnly: true,
                        onTap: () {},
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: expense.category == Category.empty
                                ? Colors.grey.shade100
                                : Color(expense.category.color),
                            hintText: 'Category',
                            prefixIcon: expense.category == Category.empty
                                ? Icon(
                                    Icons.list,
                                    color: Colors.grey.shade500,
                                  )
                                : Image.asset(
                                    'lib/images/${expense.category.icon}.png',
                                    height: 24.0,
                                    width: 24.0,
                                  ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                var newCategory =
                                    await getCategoryCreation(context);
                                print(newCategory);
                                setState(() {
                                  state.categories.insert(0, newCategory);
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                            )),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                          ),
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                                itemCount: state.categories.length,
                                itemBuilder: (context, int i) {
                                  return Card(
                                      child: ListTile(
                                    onTap: () {
                                      setState(() {
                                        expense.category = state.categories[i];
                                        categoryController.text =
                                            expense.category.name;
                                      });
                                    },
                                    leading: Image.asset(
                                      'lib/images/${state.categories[i].icon}.png',
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    title: Text(state.categories[i].name),
                                    tileColor: Color(state.categories[i].color),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ));
                                }),
                          )),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: expense.date,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                          );
                          if (newDate != null) {
                            setState(() {
                              dateController.text =
                                  DateFormat("dd/MM/yyyy").format(newDate);
                              expense.date = newDate;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintText: 'Date',
                            prefixIcon: Icon(
                              Icons.access_time,
                              color: Colors.grey.shade500,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      SizedBox(
                        height: kToolbarHeight,
                        width: double.infinity,
                        child: isLoading
                            ? Center(child: CircularProgressIndicator())
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    expense.amount =
                                        int.parse(expenseController.text);
                                  });
                                  context
                                      .read<CreateExpenseBloc>()
                                      .add(CreateExpense(expense));
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
      ),
    );
  }
}
