
```yml
Assunto: Expiração de Pendência

Prezado(a) <OTRS_OWNER_UserFirstname> <OTRS_OWNER_UserLastname>,

Seu chamado de número <OTRS_TICKET_TicketNumber> está com pendência expirando, assim é de sua responsabilidade o tratamento do chamado ou a prorrogação da data de pendência.

Atenciosamente,
Central de Serviços
Email: suporte@inmetro.gov.br    Ramal: 3200
```


-----------------------------

```yml
Assunto: Atenção: Chamado vencendo prazo de SLA!


Prezado(a) <OTRS_OWNER_UserFirstname> <OTRS_OWNER_UserLastname>,

Seu chamado de número <OTRS_TICKET_TicketNumber> está vencendo o SLA em:

Data: <OTRS_TICKET_EscalationDestinationDate>
Escalação em: <OTRS_TICKET_EscalationDestinationIn>

Assim é de sua responsabilidade o tratamento do chamado ou a inclusão de pendência, caso não dependa de sua ação.

Atenciosamente,
Central de Serviços
Email: suporte@inmetro.gov.br    Ramal: 3200
```


----------------------

```yml
Assunto: Pendência no Protocolo de Serviço: <OTRS_TICKET_TicketNumber>

Prezado(a) <OTRS_CUSTOMER_REALNAME>,

Seu chamado de número <OTRS_TICKET_TicketNumber> está com pendência no atendimento pelos seguintes motivos:

----------Pendência----------
<OTRS_AGENT_BODY>
-----------------------------------

Você pode consultar o andamento através do link http://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>customer.pl

Atenciosamente,
Central de Serviços
Email: suporte@inmetro.gov.br    Ramal: 3200
```
