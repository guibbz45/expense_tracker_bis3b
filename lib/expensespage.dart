import 'package:flutter/material.dart';

class ExpensesHomePage extends StatefulWidget {
  const ExpensesHomePage({super.key});

  @override
  State<ExpensesHomePage> createState() => _ExpensesHomePageState();
}

class _ExpensesHomePageState extends State<ExpensesHomePage> {
  final List<String> _expenses = [];

  Future<void> _navigateAndShowResult({int? editIndex}) async {
    final initial = editIndex != null ? _expenses[editIndex] : null;
    final title = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (ctx) => AddExpensePage(initialTitle: initial),
      ),
    );

    if (!mounted) return;

    if (title != null && title.isNotEmpty) {
      setState(() {
        if (editIndex != null) {
          _expenses[editIndex] = title;
        } else {
          _expenses.add(title);
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(editIndex != null ? 'Updated: $title' : 'Added: $title'),
        ),
      );
    }
  }

  void _deleteExpense(int index) {
    final removed = _expenses.removeAt(index);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deleted: $removed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: '+ Add',
            onPressed: _navigateAndShowResult,
          ),
        ],
      ),
      body: _expenses.isEmpty
          ? const Center(child: Text('No expenses yet.'))
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (ctx, i) => ListTile(
                title: Text(_expenses[i]),
                onTap: () => _navigateAndShowResult(editIndex: i),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteExpense(i),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndShowResult,
        tooltip: '+ Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}


class AddExpensePage extends StatefulWidget {
  /// If [initialTitle] is provided the page is being used for editing;
  /// otherwise it's creating a new expense.
  final String? initialTitle;

  const AddExpensePage({super.key, this.initialTitle});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialTitle ?? '';
  }

  void _save() {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title.')),
      );
      return;
    }
    Navigator.pop(context, text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Expense title'),
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
