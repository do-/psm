

################################################################################

sub do_update_orgs {

	$_REQUEST {_label} or die "#_label#:Âû çàáûëè ââåñòè íàèìåíîâàíèå";
	
	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_orgs { # Êàğòî÷êà ôèëèàëà

	my $data = sql ('orgs');

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	return $data;

}

################################################################################

sub select_orgs { # Ôèëèàëû

	sql (
	
		{},
		
		orgs => [
				
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],
					
	);
	
}

1;
