import 'package:flutter/cupertino.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "IMPORTANTE\n\n\nAplicação em desenvolvimento.\n\nPor favor use o menu.\n\nO botão abaixo ativa os serviços de localização.\nPor favor, ative-os e assegure-se de emular uma localização em Portugal antes de utilizar as funcionalidades da aplicação, em particular antes de abrir a página 'Jogos Perto' (5ª secção).\nCaso contrário, a página não abrirá.",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
