Característica: Criar Tarefa
  Para poder organizar as tarefas de meus projetos
  Como uma pessoa atarefada
  Eu gostaria de criar uma tarefa classificando sua prioridade e definindo quem deve executá-la

  Cenário: Criar uma tarefa com prioridade Baixa
    Dado que estou na página de criação de uma tarefa
    E eu preencho a tarefa "Enviar e-mail para blogueiros" como sendo de prioridade Baixa
    Quando eu clico no botão "Salvar"
    Então eu devo ver uma mensagem de sucesso "Sua tarefa foi criada com sucesso"
    E eu devo estar na página de lista de tarefas
    E eu devo ver a Tarefa "Enviar e-mail para blogueiros" no rol de Tarefas como prioridade Baixa

  Cenário: Criar uma tarefa com prioridade Alta
    Dado que estou na página de criação de uma tarefa
    E eu preencho a tarefa "Cadastrar um anúncio no AdManager" como sendo de prioridade Alta
    Quando eu clico no botão "Salvar"
    Então eu devo ver uma mensagem de sucesso "Sua tarefa foi criada com sucesso"
    E eu devo estar na página de lista de tarefas
    E eu devo ver a Tarefa "Cadastrar um anúncio no AdManager" no rol de Tarefas como prioridade Alta

  Cenário: Criar uma tarefa inválida
    Dado que estou na página de criação de uma tarefa
    E eu preencho a tarefa "" sem prioridade
    Quando eu clico no botão "Salvar"
    Então eu devo ver uma mensagem de erro "Nome da tarefa não pode ser vazia"


