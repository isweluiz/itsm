# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Stats::Static::ReportMngmtSolved;
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

    @Columns = (    
        'ticket',
        'TicketID',
        'state_name',
        'user_finish',
        'user_create',
        'create_time',
        'finish_time');

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    $DBObject->Prepare(
        SQL => " 
                select * from
                (select
                tn as tn,
                th.ticket_id,
                ts.name AS state_name,
                u1.first_name user_finish,
                u2.first_name user_create,
                t.create_time,
                max(th.change_time) as finish_time
                from
                    ticket_history th
                inner join ticket t on t.id= th.ticket_id  
                inner join ticket_state ts on th.state_id = ts.id
                left join users u1 on t.change_by = u1.id
                left join users u2 on t.create_by = u2.id
                where
                    th.state_id=13 and th.history_type_id=27 
                group by t.tn,th.ticket_id,t.create_time, ts.name) as a
               WHERE ((YEAR(a.create_time) = $Year and MONTH(a.create_time) = $Month)
                or
              (YEAR(a.finish_time) = $Year and MONTH(a.finish_time) = $Month))
              ",
        #Bind => [ \$Year, \$Month ],
    );
    while ( my @Row = $DBObject->FetchrowArray() ){
        $Qtd++;
        push @Data, \@Row;
    }

    @Rows = ('Total de registros:', $Qtd);
    push @Data, \@Rows;

    # Titulo composto por: Título do Relatório + 
    my $Title = " (Filtro: $Month/$Year)";
    return ( [$Title],[@Columns], @Data );
}
1;
