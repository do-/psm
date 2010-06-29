

################################################################################

sub do_update_voc_ages { # И что это за процедура?


	$_REQUEST {_age_from} =~ /^\d+$/ or croak "#_age_from#:Некорректный возраст";
	$_REQUEST {_age_to}   =~ /^\d+$/ or croak "#_age_to#:Некорректный возраст";

	$_REQUEST {_age_to} >= $_REQUEST {_age_from} or croak "#_age_to#:Возраст 'до' должен быть не меньше, чем 'от'";

	$_REQUEST {_label}  =~ s{^от \d+ до \d+$}{};
	$_REQUEST {_label} ||= "от $_REQUEST{_age_from} до $_REQUEST{_age_to}";
	
	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_voc_ages {

	my $data = sql ('voc_ages');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	return $data;

}

################################################################################

sub select_voc_ages { # Возрастные категории

	sql (
	
		{},
		
		voc_ages => [
				
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],
					
	);	

}

1;
