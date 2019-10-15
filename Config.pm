# --
# Kernel/Config.pm - Config file for OTRS kernel
# Copyright (C) 2001-2013 OTRS AG, http://otrs.org/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
#  Note:
#
#  -->> Most OTRS configuration should be done via the OTRS web interface
#       and the SysConfig. Only for some configuration, such as database
#       credentials and customer data source changes, you should edit this
#       file. For changes do customer data sources you can copy the definitions
#       from Kernel/Config/Defaults.pm and paste them in this file.
#       Config.pm will not be overwritten when updating OTRS.
# --

package Kernel::Config;

use strict;
use warnings;
use utf8;

sub Load {
    my $Self = shift;

# Clientes LDAP

# Na proxima aula


# Agentes
    $Self->{'AuthModule'} = 'Kernel::System::Auth::LDAP';
    $Self->{'AuthModule::LDAP::Host'} = '...br';
    $Self->{'AuthModule::LDAP::BaseDN'} = 'DC=,DC=,DC=,DC=br';
    $Self->{'AuthModule::LDAP::UID'} = 'sAMAccountName';

    $Self->{'AuthModule::LDAP::SearchUserDN'} = 'CN=,OU=,OU=Usuarios_Administrativos,OU=Administracao,DC=,DC=,DC=,DC=br';
    $Self->{'AuthModule::LDAP::SearchUserPw'} = '@';

    $Self->{'AuthModule::LDAP::UserAttr'} = 'sAMAccountName';
    $Self->{'AuthModule::LDAP::AlwaysFilter'} = '(objectClass=organizationalPerson)';

    $Self->{'AuthSyncModule'} = 'Kernel::System::Auth::Sync::LDAP';
    $Self->{'AuthSyncModule::LDAP::Host'} = '.br';
    $Self->{'AuthSyncModule::LDAP::BaseDN'} = 'DC=,DC=,DC=,DC=br';
    $Self->{'AuthSyncModule::LDAP::UID'} = 'sAMAccountName';
    $Self->{'AuthSyncModule::LDAP::SearchUserDN'} = 'CN=,OU=,OU=Usuarios_Administrativos,OU=Administracao,DC=,DC=,DC=,DC=br';
    $Self->{'AuthSyncModule::LDAP::SearchUserPw'} = '@';

    $Self->{'AuthSyncModule::LDAP::UserSyncMap'} = {
        UserFirstname => 'givenName',
        UserLastname => 'sn',
	UserEmail => 'mail',
    };

$Self->{'AuthSyncModule::LDAP::UserSyncRolesDefinition'} = {
 # Primeiro grupo mapeado
 # Grupo no Active Directory – Administradores do OTRS no AD
 'OU=,OU=Usuarios_Administrativos,OU=Administracao,DC=,DC=,DC=,DC=br' => {
 # Papel no OTRS - Administrador
 'Administrador' => 1,
 },
 # Segundo Mapeamento
 'CN=Service Desk,OU=OTRS Groups,DC=complemento,DC=net,DC=br' => {
 # Papel no OTRS
 'Atendente de Primeiro Nível' => 1,
 },
 # Terceiro Mapeamento
 'CN=Desenvolvedores,OU=OTRS Groups,DC=complemento,DC=net,DC=br' => {
 'Desenvolvedor' => 1,
# Você pode definir mais que um papél para o mesmo grupo do AD
# 'Papel 2' => 1,
 },
 }; 


######### Usuários do AD como Clientes do OTRS #########
$Self->{CustomerUser1} = {
 Name => 'Active Directory',
 Module => 'Kernel::System::CustomerUser::LDAP',
 Params => {
 Host => '.br',
 BaseDN => 'DC=,DC=,DC=,DC=br',
 SSCOPE => 'sub',
 UserDN => 'CN=,OU=,OU=Usuarios_Administrativos,OU=Administracao,DC=,DC=,DC=,DC=br',
 #Password
 UserPw => '',
 # A linha abaixo serve para não trazer usuarios desativados:
 # Fonte: http://www.petri.co.il/ldap_search_samples_for_windows_2003_and_exchange.htm
 AlwaysFilter =>
'(&(objectclass=user)(!(objectclass=computer))(!(userAccountControl:1.2.840.113556.1.4.803:=2)))',
 SourceCharset => 'utf-8',
 DestCharset => 'utf-8',
 Params => {
 port => 389,
 timeout => 120,
 async => 0,
 version => 3,
 },
 },
 CustomerKey => 'sAMAccountName',
 CustomerID => 'mail',
 CustomerUserListFields => ['cn','mail'],
 CustomerUserSearchFields => ['sAMAccountName', 'cn', 'mail','givenname', 'sn'],
 CustomerUserSearchPrefix => '*',
 CustomerUserSearchSuffix => '*',
 CustomerUserSearchListLimit => 500,
 CustomerUserPostMasterSearchFields => ['mail'],
 CustomerUserNameFields => ['givenname', 'sn'],
 CustomerUserEmailUniqCheck => 0,
 CustomerUserExcludePrimaryCustomerID => 0,
 AdminSetPreferences => 0,
 ReadOnly => 1,
 CacheTTL => 180,
 Map => [
 # note: Login, Email and CustomerID are mandatory!
 # var, frontend, storage, shown (1=always,2=lite), required, storage-type, http-link, readonly
 [ 'UserTitle', 'Title', 'title', 1, 0, 'var', '', 0 ],
 [ 'UserFirstname', 'Firstname', 'givenname', 1, 1, 'var', '', 0 ],
 [ 'UserLastname', 'Lastname', 'sn', 1, 1, 'var', '', 0 ],
 [ 'UserLogin', 'Username', 'sAMAccountName', 1, 1, 'var', '', 0 ],
 [ 'UserEmail', 'Email', 'mail', 1, 1, 'var', '', 0 ],
 [ 'UserCustomerID', 'CustomerID', 'sAMAccountName', 0, 1, 'var', '', 0 ],
 [ 'UserPhone', 'Phone', 'telephonenumber', 1, 0, 'var', '', 0 ],
 [ 'UserAddress', 'Address', 'postaladdress', 1, 0, 'var', '', 0 ],
 [ 'UserComment', 'Comment', 'dn', 1, 0, 'var', '', 0 ],
 [ 'DN', 'DN', 'dn', 1, 0, 'var', '', 0 ],
 ],
};


##### Autenticação de Cliente no Active Directory
$Self->{'Customer::AuthModule1'} = 'Kernel::System::CustomerAuth::LDAP';
$Self->{'Customer::AuthModule::LDAP::Host1'} = '.br';
$Self->{'Customer::AuthModule::LDAP::BaseDN1'} = 'DC=,DC=,DC=,DC=br';
$Self->{'Customer::AuthModule::LDAP::UID1'} = 'sAMAccountName';
$Self->{'Customer::AuthModule::LDAP::AccessAttr1'} = 'member';
$Self->{'Customer::AuthModule::LDAP::SearchUserDN1'} = 'CN=,OU=,OU=Usuarios_Administrativos,OU=Administracao,DC=,DC=,DC=,DC=br';
$Self->{'Customer::AuthModule::LDAP::SearchUserPw1'} = '@';
# A linha abaixo serve para não trazer usuarios desativados: (!(userAccountControl:1.2.840.113556.1.4.803:=2))
# Fonte: http://www.petri.co.il/ldap_search_samples_for_windows_2003_and_exchange.htm
$Self->{'Customer::AuthModule::LDAP::AlwaysFilter1'} =
 '(&(objectclass=user)(!(objectclass=computer))(!(userAccountControl:1.2.840.113556.1.4.803:=2)))';
# $Self->{'Customer::AuthModule::LDAP::Die1'} = 0;
# A linha abaixo serve para permitir que apenas usuários de um determinado grupo acessem o sistema como clientes
# $Self->{'Customer::AuthModule::LDAP::GroupDN1'} = 'CN=Clientes OTRS,OU=OTRS Groups,DC=complemento,DC=net,DC=br';



    # ---------------------------------------------------- #
    # database settings                                    #
    # ---------------------------------------------------- #

    # The database host
    $Self->{'DatabaseHost'} = 'localhost';

    # The database name
    $Self->{'Database'} = "otrs";

    # The database user
    $Self->{'DatabaseUser'} = "otrs";

    # The password of database user. You also can use bin/otrs.CryptPassword.pl
    # for crypted passwords
    $Self->{'DatabasePw'} = '';

    # The database DSN for MySQL ==> more: "perldoc DBD::mysql"
    $Self->{'DatabaseDSN'} = "DBI:mysql:database=$Self->{Database};host=$Self->{DatabaseHost}";

    # The database DSN for PostgreSQL ==> more: "perldoc DBD::Pg"
    # if you want to use a local socket connection
#    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};";
    # if you want to use a TCP/IP connection
#    $Self->{DatabaseDSN} = "DBI:Pg:dbname=$Self->{Database};host=$Self->{DatabaseHost};";
    # if you have PostgresSQL 8.1 or earlier, activate the legacy driver with this line:
#    $Self->{DatabasePostgresqlBefore82} = 1;

    # The database DSN for Microsoft SQL Server - only supported if OTRS is
    # installed on Windows as well
#    $Self->{DatabaseDSN} = "DBI:ODBC:driver={SQL Server};Database=$Self->{Database};Server=$Self->{DatabaseHost},1433";

    # The database DSN for Oracle ==> more: "perldoc DBD::oracle"
#    $ENV{ORACLE_HOME} = '/u01/app/oracle/product/10.2.0/client_1';
#    $ENV{NLS_DATE_FORMAT} = 'YYYY-MM-DD HH24:MI:SS';
#    $ENV{NLS_LANG} = "american_america.utf8";

#    $Self->{DatabaseDSN} = "DBI:Oracle:sid=OTRS;host=$Self->{DatabaseHost};port=1522;";

    # ---------------------------------------------------- #
    # fs root directory
    # ---------------------------------------------------- #
    $Self->{Home} = '/opt/otrs';

    # ---------------------------------------------------- #
    # insert your own config settings "here"               #
    # config settings taken from Kernel/Config/Defaults.pm #
    # ---------------------------------------------------- #
    # $Self->{SessionUseCookie} = 0;
    # $Self->{CheckMXRecord} = 0;

    # ---------------------------------------------------- #

    # ---------------------------------------------------- #
    # data inserted by installer                           #
    # ---------------------------------------------------- #
    # $DIBI$

    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
    #                                                      #
    # end of your own config options!!!                    #
    #                                                      #
    # ---------------------------------------------------- #
    # ---------------------------------------------------- #
}

# ---------------------------------------------------- #
# needed system stuff (don't edit this)                #
# ---------------------------------------------------- #

use base qw(Kernel::Config::Defaults);

# -----------------------------------------------------#

1;
