# SalePro
 Projeto Interdisciplinar 4 ADS 

 ***É necessário ter o FortesReportes, Cef4Delphi, Zeos e RXLibrary***

Este guia fornece instruções detalhadas sobre como compilar o projeto SalePro ERP usando Delphi 11 e preparar o ambiente de execução.

Passos para Compilação
1. Ignorar Erros ao Compilar
Ao compilar o projeto SalePro ERP no Delphi 11, alguns erros podem ocorrer. Estes erros são conhecidos e podem ser ignorados. Continue com a compilação apesar dos erros.

2. Preparar o Banco de Dados
Certifique-se de ter um servidor MySQL configurado e em execução. Em seguida, adicione o banco de dados necessário para o projeto.

Criar o banco de dados:
sql
Copiar código

CREATE DATABASE vendas;

3. Descompactar Bibliotecas
descompactar a pasta integração desse link https://drive.google.com/drive/folders/1Trcif5xKCvNc4FZcLfpi6s1F80LkSEqy?usp=sharing e colocar dentro da pasta Win32/Debug

4. Certifique-se de que o arquivo libmysql.dll também esteja presente no diretório win32/debug/.
5. Configurar o Acesso ao MySQL
Após a compilação do projeto, você precisa configurar o acesso ao banco de dados MySQL.

Configurar Vendas.ini:

Após compilar o projeto, localize o arquivo Vendas.ini na pasta win32/debug/.
Edite o arquivo Vendas.ini para incluir as configurações de acesso ao MySQL, especificando o usuário e a senha.
Exemplo de configuração do Vendas.ini:

ini
Copiar código
[SERVER]
TipoDataBase=MYSQL
HostName=localhost
Port=3306
User=root
Password=
Database=vendas

[Settings]
SwitchState=1

6. Executar o Projeto
Após completar os passos acima, você pode executar o projeto SalePro ERP.

7. Informações de Login
Para acessar o sistema, utilize as credenciais padrão fornecidas:

Usuário: admin
Senha: padrao

8. Gerenciamento de Usuários
O sistema SalePro ERP permite criar novos usuários, gerenciar permissões e permitir que os usuários logados alterem suas próprias senhas.

Criar novos usuários: Acesse o módulo de gerenciamento de usuários no sistema.
Remover permissões: Ajuste as permissões de acordo com as necessidades.
Alterar senha: Usuários logados podem alterar suas próprias senhas através da interface do sistema.
Conclusão
Seguindo esses passos, você deve ser capaz de compilar e executar o projeto SalePro ERP. Caso encontre problemas, certifique-se de que todos os arquivos e bibliotecas estão no lugar correto e que o banco de dados está configurado corretamente. Se persistirem problemas, consulte a documentação ou entre em contato com o suporte técnico.

OBS: NO MOMENTO ESTÁ FUNCIONANDO 100% APENAS COM O XAMPP( O MYSQL DELE) NO PRÓPRIO MYSQL ESTÁ COM ALGUNS BUGS QUE NÃO FORAM CORRIGIDOS MAS EM BREVE DEVE SER CORRIGIDO E ATUALIZADO NO REPOSITÓRIO.
OBS2: TODA VEZ QUE MUDAR A COR, TEM QUE APLICAR O MODO DARK E DESAPLICAR, AI A COR MUDA. SOBRE O TEMPO DE NOTIFICAÇÃO, TEM QUE REINCIAR A APLICAÇÃO E APENAS ESSES DETALHES, NO MOMENTO SOBRE AS FONTES, NÃO ESTÁ POSSÍVEL A MUDANÇA.
