 
### Enable owner/reponsible on stats
> - Stats::UseAgentElementInStats


### Enbale responsible for tickets
> - Ticket::Responsible

#### Opcionais 
> - Ticket::Frontend::AgentTicketNote###Responsible
> - Ticket::Frontend::AgentTicketOwner###Responsible
> - Ticket::Frontend::AgentTicketAddtlITSMField###Responsible
> - Ticket::Hook
> - Ticket::IncludeUnknownTicketCustomers
> - Ticket::IncludeUnknownTicketCustomers
> - Ticket::Watcher
Ativa ou desativa a funcionalidade de observador de ticket, para acompanhar tickets sem ser proprietário nem responsável.
> - Ticket::ZoomTimeDisplay
> - DashboardBackend###0270-TicketQueueOverview
> - Ticket::Service::Default::UnknownCustomer
- - (Permite selecionar serviços padrão para clientes não existentes)
> - Ticket::Frontend::AgentTicketSearch###SearchLimit
> - Daemon::SchedulerGenericAgentTaskManager::TicketLimit (Número máximo de tickets impactados por job)
> - Stats::SearchLimit (Define o limite de pesquisa para as estatísticas.)
> - Ticket::Closed::Order (Which close should be considered on Stats.)
> - NotificationSenderEmail (E-mail das notificações) 
> - PostmasterFollowUpStateClosed  - 
Define o estado do chamado se ele for revisado e o chamado já estiver fechado.
> - PostmasterFollowUpState
> - PostmasterFollowUpStateClosed
> - Ticket::Frontend::CustomerTicketZoom###StateDefault
> - Ticket::Frontend::AgentTicketAddtlITSMField###StateDefault
> - Ticket::Frontend::AgentTicketBounce###StateDefault
> - Ticket::Frontend::AgentTicketBulk###StateDefault
> - Ticket::Frontend::AgentTicketCompose###StateDefault
> - Ticket::Frontend::AgentTicketDecision###StateDefault
> - Ticket::Frontend::AgentTicketEmail###StateDefault
> - Ticket::Frontend::AgentTicketEmailOutbound###StateDefault
> - Ticket::Frontend::AgentTicketFreeText###StateDefault
> - Ticket::Frontend::AgentTicketOwner###StateDefault
> - Ticket::Frontend::AgentTicketPhone###StateDefault
> - Ticket::Frontend::AgentTicketPhoneInbound###State
> - Ticket::Frontend::AgentTicketPhoneOutbound###State
> - Ticket::Frontend::AgentTicketPriority###StateDefault
> - Ticket::Frontend::AgentTicketResponsible###StateDefault
> - Ticket::Frontend::CustomerTicketZoom###StateDefault

## ITSM VIEW  
#### Funções
- fncTempoPendente
- - StateID's = 6,7,8,4(remover)

- 


### Permissions
```yml
SYSCONFIG
G::::zsonda
AdminACL:::/otrs/index.pl?Action=AdminACL
AdminPostMasterFilter:::
AdminITSMCIPAllocate:::otrs/index.pl?Action=AdminITSMCIPAllocate
AdminSystemConfiguration:::/otrs/index.pl?Action=AdminSystemConfiguration
Frontend::Module###AdminDynamicField:::/otrs/index.pl?Action=AdminDynamicField
Frontend::Module###AdminGenericAgent:::
Frontend::Module###AdminImportExport
Frontend::Module###AdminSelectBox
Frontend::Module###AdminSystemConfiguration
Frontend::Module###AdminSystemConfigurationDeployment
Frontend::Module###AdminSystemConfigurationGroup
```








