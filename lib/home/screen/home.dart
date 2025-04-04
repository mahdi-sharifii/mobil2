import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile2/home/cubit/home_cubit.dart';
import 'package:mobile2/home/data/models/name_model_db/name_model.dart';
import 'package:mobile2/locator.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sizer/sizer.dart';

/// home
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController = TextEditingController();
  final List<Color> colors = const [
    Color.fromARGB(255, 178, 221, 255),
    Color.fromARGB(255, 166, 244, 197),
    Color.fromARGB(255, 254, 223, 137),
    Color.fromARGB(255, 254, 205, 202),
    Color.fromARGB(255, 179, 158, 215),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(locator()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// TextField
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),

                  /// Color and Send BTN
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<HomeCubit, HomeState>(
                        buildWhen: (p, c) => p.color != c.color,
                        builder: (context, state) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,

                            /// colors
                            children: List.generate(
                              colors.length,
                              (i) {
                                return InkWell(
                                  onTap: () {
                                    BlocProvider.of<HomeCubit>(context)
                                        .changeColor(colors[i]);
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      border: state.color == colors[i]
                                          ? Border.all(width: 1)
                                          : null,
                                      shape: BoxShape.circle,
                                      color: colors[i],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),

                      /// Send BTN
                      BlocConsumer<HomeCubit, HomeState>(
                        listenWhen: (p, c) =>
                            p.addNameStatus != c.addNameStatus,

                        // buildWhen: (p, c) => p.addNameStatus != c.addNameStatus,
                        listener: (context, state) {
                          /// if is OK
                          if (state.addNameStatus is AddNameCompleted) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            nameController.clear();

                            BlocProvider.of<HomeCubit>(context)
                                .changeColor(null);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("ثبت شد!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }

                          /// if have error
                          if (state.addNameStatus is AddNameError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("خطا در ثبت"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          /// load
                          if (state.addNameStatus is AddNameLoading) {
                            return const CircularProgressIndicator();
                          }

                          ///
                          return ElevatedButton(
                            onPressed: () {
                              if (nameController.text == "") return;

                              if (state.color == null) return;

                              BlocProvider.of<HomeCubit>(context).addName(
                                NameModel(
                                  name: nameController.text,
                                  dateTime: DateTime.now(),
                                  color: state.color?.value,
                                ),
                              );
                            },
                            child: const Text('Send!'),
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 35),

                  /// show alert Names
                  ElevatedButton(
                    onPressed: () {
                      /// Cubit instants
                      final HomeCubit cubit =
                          BlocProvider.of<HomeCubit>(context);

                      /// call get all Names
                      cubit.getAllName();

                      /// show names
                      showNames(cubit, context);
                    },
                    child: const Text("Show name"),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  /// Custom alert
  void showNames(HomeCubit cubit, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Names"),
        content: BlocProvider<HomeCubit>.value(
          value: cubit,
          child: Builder(
            builder: (context) {
              return BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.allNameStatus is AllNameCompleted) {
                    final List<NameModel> data =
                        (state.allNameStatus as AllNameCompleted).data;

                    return SizedBox(
                      width: 70.w,
                      height: 50.h,
                      /// List Names
                      child: AnimationList(
                          shrinkWrap: true,
                          children: List.generate(data.length, (index) {
                            return Card(
                              margin: const EdgeInsets.all(10),
                              elevation: 10,
                              color: data[index].color == null
                                  ? null
                                  : Color(data[index].color as int),
                              child: ListTile(
                                subtitle: Text(
                                    format1(data[index].dateTime!.toJalali())),
                                title: Text(data[index].name!),
                                trailing: IconButton(
                                  onPressed: () => cubit.deleteName(index),
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            );
                          })),
                    );
                  }

                  return const CircularProgressIndicator();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

String format1(Date d) {
  final f = d.formatter;

  return '${f.wN} ${f.d} ${f.mN} ${f.yy}';
}
