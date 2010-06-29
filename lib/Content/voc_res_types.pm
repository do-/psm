
################################################################################

sub do_update_voc_res_types {

	$_REQUEST {_label} or croak "#_label#:Âû çàáûëè ââåñòè íàèìåíîâàíèå";
	
	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_voc_res_types {

	my $data = sql ('voc_res_types');

	$data -> {no_del} ||= 1 if $data -> {id} < 3;

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	return $data;

}

################################################################################

sub select_voc_res_types { # Òèïû ğåñóğñîâ


	sql (
	
		{},
		
		voc_res_types => [
				
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],
					
	);	

}

1;
