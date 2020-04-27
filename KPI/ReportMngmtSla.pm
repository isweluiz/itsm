# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Stats::Static::ReportMngmtSla;
## nofilter(TidyAll::Plugin::OTRS::Perl::Time)

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Language',
    'Kernel::System::DB',
    'Kernel::System::DateTime',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

#
# Esta opcao permite que a estatistica seja apresentada no Dashboard
#
sub GetObjectBehaviours {
    my ( $Self, %Param ) = @_;

    my %Behaviours = (
        ProvidesDashboardWidget => 1,
    );

    return %Behaviours;
}

sub Param {
    my $Self = shift;

    my $DateTimeObject = $Kernel::OM->Create('Kernel::System::DateTime');

    # get one month before
    # $DateTimeObject->Subtract( Months => 1 );
    my $DateTimeSettings = $DateTimeObject->Get();

    # create possible time selections
    my %Year = map { $_ => $_; } ( $DateTimeSettings->{Year} - 10 .. $DateTimeSettings->{Year} );
    my %Month = map { $_ => sprintf( "%02d", $_ ); } ( 1 .. 12 );

    my @Params = (
        {
            Frontend   => 'Year',
            Name       => 'Year',
            Multiple   => 0,
            Size       => 0,
            SelectedID => $DateTimeSettings->{Year},
            Data       => \%Year,
        },
        {
            Frontend   => 'Month',
            Name       => 'Month',
            Multiple   => 0,
            Size       => 0,
            SelectedID => $DateTimeSettings->{Month},
            Data       => \%Month,
        },
    );
    return @Params;
}

sub Run {
    my ( $Self, %Param ) = @_;

    return if !$Param{Year} || !$Param{Month};

    # get language object
    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');

    my $Year  = $Param{Year};
    my $Month = $Param{Month};

    my @Data;
    my @Columns = ();
    my @Rows = ();
    my $Qtd = 0;

    @Columns = ('Chamado','Criação','Titulo','Canal','Tipo','Sit. Atual','Fila Resolucao','Finalizado','Proprietario','Servico','SLA','SLA horas','Pendente','Solucao');

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    $DBObject->Prepare(
        SQL => "
              SELECT tn, create_time, title, communication_channel, type_name, 
                state_name, queue_finish, finish_time, user_finish, service_name, sla_name, 
                sla_solution_time, time_pending, time_solution FROM vw_kpi_tickets 
                WHERE ((YEAR(create_time) = $Year and MONTH(create_time) = $Month)
                or
                (YEAR(finish_time) = $Year and MONTH(finish_time) = $Month))",);
    while ( my @Row = $DBObject->FetchrowArray() ){
        $Qtd++;
        push @Data, \@Row;
    }

    @Rows = ('Total de registros:', $Qtd);
    push @Data, \@Rows;

    # Titulo composto por: Título do Relatório + 
    my $Title = " (Filtro: $Month/$Year)";
    return ( [$Title],[ @Columns ], @Data );
}

1;
