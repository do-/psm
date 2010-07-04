

################################################################################

sub do_update_clients {

	$_REQUEST {_label} or croak "#_label#:Âû çàáûëè ââåñòè ÔÈÎ";
	
	my (@dt_birth) = vld_date ('dt_birth');
	
	Date::Calc::Delta_Days (@dt_birth, Date::Calc::Today ()) > 0 or die "#_dt_birth#:äàòà ğîæäåíèÿ íå ìîæåò íàõîäèòüñÿ â áóäóùåì";

	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_clients { # Êëèåíò

	my $data = sql ('clients');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	return $data;

}


1;
