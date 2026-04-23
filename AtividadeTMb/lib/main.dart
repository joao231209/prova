import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController idadeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  String genero = "masculino";
  String atividade = "sedentario";

  double resultado = 0;

  void calcularTMB() {
  double idade = double.tryParse(idadeController.text) ?? 0;
  double peso = double.tryParse(pesoController.text) ?? 0;
  double altura = double.tryParse(alturaController.text) ?? 0;

  if (idade == 0 || peso == 0 || altura == 0) {
    setState(() {
      resultado = 0;
    });
    return;
  }

  double tmb;

  if (genero == "masculino") {
    tmb = 88.36 + (13.4 * peso) + (4.8 * altura) - (5.7 * idade);
  } else {
    tmb = 447.6 + (9.2 * peso) + (3.1 * altura) - (4.3 * idade);
  }

  double fatorAtividade;

  switch (atividade) {
    case "sedentario":
      fatorAtividade = 1.2;
      break;
    case "leve":
      fatorAtividade = 1.375;
      break;
    case "moderado":
      fatorAtividade = 1.55;
      break;
    case "ativo":
      fatorAtividade = 1.725;
      break;
    default:
      fatorAtividade = 1.2;
  }

  setState(() {
    resultado = tmb * fatorAtividade;
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Calculadora de TMB"),
        backgroundColor: const Color.fromARGB(255, 233, 242, 248)),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Idade",
                prefixIcon: Icon(Icons.account_box_outlined)),
              ),
              TextField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Peso (kg)",
                prefixIcon: Icon(Icons.align_vertical_bottom)),
              ),
              TextField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Altura (cm)",
                prefixIcon: Icon(Icons.keyboard_double_arrow_up_outlined)),
                ),
              

              const SizedBox(height: 40),

              Text(
               "Qual o seu genêro ? ",
                
              ),
              const SizedBox(height: 40),

              Row(
                children: [

                  Expanded(
                    child: RadioListTile(
                      title: const Text("Masculino"),
                      value: "masculino",
                      groupValue: genero,
                      onChanged: (value) {
                        setState(() {
                          genero = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      title: const Text("Feminino"),
                      value: "feminino",
                      groupValue: genero,
                      onChanged: (value) {
                        setState(() {
                          genero = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              Text(
               "Qual o seu nível de atividade física ? ",
                
              ),

              const SizedBox(height: 25),
              DropdownButton<String>(
                value: atividade,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(value: "sedentario", child: Text("Sedentário")),
                  DropdownMenuItem(value: "leve", child: Text("Levemente ativo")),
                  DropdownMenuItem(value: "moderado", child: Text("Moderado")),
                  DropdownMenuItem(value: "ativo", child: Text("Ativo")),
                ],
                onChanged: (value) {
                  setState(() {
                    atividade = value!;
                  });
                },
              ),

              const SizedBox(height: 80),

              ElevatedButton(
                onPressed: calcularTMB,
                child: const Text("Calcular"),
              ),

              const SizedBox(height: 20),

              Text("Resultado: ${resultado.toStringAsFixed(2)} kcal"),
            ],
          ),
        ),
      ),
    );
  }
}