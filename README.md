# reserva_wbc

## Descrição

Projeto realizado como desafio para a WBC Sistemas. Nesse caso, foi escolhido o desafio:

2. Criar um processo de reserva de churrasqueiras, permitindo que os usuários visualizem as churrasqueiras disponíveis em tempo real e façam suas reservas de forma rápida e eficiente.

## Instalação e Versão

### Versões
Foram criadas duas versões para esse projeto, a mais básica e a mais complexa, porém ambas atendem os requisitos do desafio.

A versão básica é encontrada na branch `main`.

A versão mais complexa é encontrada na branch `v2`. Essa apresenta métodos de inserção e remoção das reservas.

Ambas as versões foram criadas com SQLFlite, utilizando o padrão de design Repository, juntamente com o Provider. A maior diferença é que a versão `v2` integra algumas funções do backend na UI, mas as duas versões possuem um CRUD básico desenvolvido no backend.

### Instalação

É possível baixar o código das branches e executar eles diretamente na IDE da sua escolha (Recomendado Android Studio ou VS Code com emulador de Android).

Também é possível executar um 'git pull' em um projeto previamente criado e rodar a partir desse.

Os projetos utilizam das seguintes bibliotecas:

  sqflite: ^2.2.6
  path_provider: ^2.0.13
  provider: ^6.0.5

** O projeto foi criado e testado utilizando a API 33 do Android, dessa forma, é possível que versões anteriores da API não rodem de forma adequada.
 Para garantir que seu projeto esteja rodando na versão API 33, navegue até `seu_projeto/android/app/build.gradle`  adicione `compileSdkVersion 33` dentro da tag `android{}` **
