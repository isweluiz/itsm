# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Stats::Static::KPIRate50;
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

    @Columns = ('0%-50%','50%-60%','60%-70%','70%-80%','80%-90%','90%-100%','>100%');

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
    $DBObject->Prepare(
        SQL => "
              select 
                count(*) as total,
                round((sum(case when rate_solution < 50 then 1 else 0 end)*100)/count(*),2) as rate_0_50,
                round((sum(case when rate_solution >= 50 and rate_solution < 60 then 1 else 0 end)*100)/count(*),2) as rate_50_60,
                round((sum(case when rate_solution >= 60 and rate_solution < 70 then 1 else 0 end)*100)/count(*),2) as rate_60_70,
                round((sum(case when rate_solution >= 70 and rate_solution < 80 then 1 else 0 end)*100)/count(*),2) as rate_70_80,
                round((sum(case when rate_solution >= 80 and rate_solution < 90 then 1 else 0 end)*100)/count(*),2) as rate_80_90,
                round((sum(case when rate_solution >= 90 and rate_solution <= 100 then 1 else 0 end)*100)/count(*),2) as rate_90_100,
                round((sum(case when rate_solution > 100 then 1 else 0 end)*100)/count(*),2) as rate_100
                from vw_kpi_rate
                WHERE YEAR(create_time) = $Year and MONTH(create_time) = $Month
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
    return ( [$Title], [ $LanguageObject->Translate('Total'), @Columns ], @Data );
}

1;
