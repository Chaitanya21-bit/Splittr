import 'package:flutter/material.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/services/personal_transaction_service.dart';
import '../providers/providers.dart';
import '../utils/get_provider.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({super.key, required this.transItem});
  final PersonalTransaction transItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff9CC4DD),
      margin: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      elevation: 8,
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color(0xff3A8ABD),
          width: 4,
        ),

        borderRadius: BorderRadius.circular(18),
      ),
      child: Dismissible(
        key: Key(transItem.tid),
        background: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.only(right: 20.0),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) async {
          await getProvider<PersonalTransactionProvider>(context)
              .deleteTransaction(transItem);
        },
        confirmDismiss: (DismissDirection direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm"),
                content: const Text(
                    "Are you sure you wish to delete this transaction?"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("CANCEL"),
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text("DELETE")),
                ],
              );
            },
          );
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {},
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      transItem.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(
                          '${transItem.amount}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          transItem.date.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 25.0)),
                  Text(transItem.remarks,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
