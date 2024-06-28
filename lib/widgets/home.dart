import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:monex/bloc/create_categorybloc/create_category_bloc.dart';
import 'package:monex/bloc/create_expense_bloc/create_expense_bloc.dart';
import 'package:monex/bloc/get_categories_bloc/get_categories_bloc.dart';
import 'package:monex/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:monex/packages/expense.dart';
import 'package:monex/packages/src/firebase_expense_repo.dart';
import 'package:monex/widgets/expenses_list/add_expense.dart';
import 'package:monex/widgets/stats.dart';

class Home extends StatefulWidget {
  final List<Expense> expenses;
  const Home({Key? key, required this.expenses}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  Color selectedColor = Colors.blue;
  Color unselectedColor = Colors.grey;

  final List<Widget> widgetList = [Home(expenses: []), Stats()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GetExpensesBloc, GetExpensesState>(
        builder: (context, state) {
          if (state is GetExpensesSuccess) {
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: BottomNavigationBar(
                    onTap: (value) {
                      setState(() {
                        index = value;
                      });
                      print(value);
                    },
                    elevation: 3,
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          color: index == 0 ? selectedColor : unselectedColor,
                        ),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.show_chart,
                          color: index == 1 ? selectedColor : unselectedColor,
                        ),
                        label: "Stats",
                      ),
                    ],
                  ),
                ),
              ),
              body: index == 0
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 24, // Adjusted icon size
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Column(children: [
                                    Text(
                                      "Welcome!",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade400),
                                    ),
                                    Text(
                                      "John Doe",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey.shade400),
                                    ),
                                  ]),
                                ]),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.settings),
                                  iconSize: 24, // Adjusted icon size
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 390,
                              height: 260,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 4,
                                        color: Colors.grey.shade300,
                                        offset: Offset(5, 5))
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Text(
                                    "\$ 4800.0",
                                    style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.arrow_upward,
                                                    color: Colors.greenAccent,
                                                    size:
                                                        16, // Adjusted icon size
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Income",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '\$2500.00',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 25,
                                                height: 25,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.arrow_downward,
                                                    color: Colors.red,
                                                    size:
                                                        16, // Adjusted icon size
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Expenses",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    '\$800.00',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Transactions",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.expenses.length,
                              itemBuilder: (context, int i) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                        color: Color(widget
                                                            .expenses[i]
                                                            .category
                                                            .color),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    Image.asset(
                                                      'lib/images/${widget.expenses[i].category.icon}.png',
                                                      color: Colors.white,
                                                      width:
                                                          24, // Adjusted icon size
                                                      height:
                                                          24, // Adjusted icon size
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  widget.expenses[i].category
                                                      .name,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onBackground,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '-\$${widget.expenses[i].amount.toString()}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onBackground,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                    widget.expenses[i].date),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  : Stats(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  var newExpense = await Navigator.push(
                    context,
                    MaterialPageRoute<Expense>(
                        builder: (BuildContext context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                  create: (context) =>
                                      CreateCategoryBloc(FirebaseExpenseRepo()),
                                ),
                                BlocProvider(
                                    create: (context) =>
                                        GetCategoriesBloc(FirebaseExpenseRepo())
                                          ..add(GetCategories())),
                                BlocProvider(
                                  create: (context) =>
                                      CreateExpenseBloc(FirebaseExpenseRepo()),
                                ),
                              ],
                              child: AddExpense(),
                            )),
                  );
                  if (newExpense != null) {
                    setState(() {
                      state.expenses.insert(0, newExpense);
                    });
                  }
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
