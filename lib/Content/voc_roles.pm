

################################################################################

sub do_update_voc_roles {

	$_REQUEST {_label} or croak "#_label#:Вы забыли ввести наименование";
	
	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_voc_roles {

	my $data = sql ('voc_roles');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	return $data;

}

################################################################################

sub select_voc_roles { # Степени родства

	sql (
	
		{},
				
		voc_roles => [
				
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],
					
	);	

}


1;
