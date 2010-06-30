

################################################################################

sub do_update_resources { # И что это за процедура?

	$_REQUEST {_label} or croak "#_label#:Вы забыли ввести наименование";
	
	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_resources {

	my $data = sql (resources => $_REQUEST {id}, 'voc_res_types', 'orgs');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

#	add_vocabularies ($data,
#		orgs => {}
#	);

	return $data;

}

################################################################################

sub select_resources { # Реестр ресурсов

	my $data = sql (voc_res_types => $_REQUEST {id_voc_res_type});
	
	add_vocabularies ($data, 'orgs');
	
	$_REQUEST {id_org} ||= $_USER -> {id_org};
	
	$data -> {is_bound} or delete $_REQUEST {id_org};

	$data -> {org} = sql (orgs => $_REQUEST {id_org}) if $_REQUEST {id_org};

	sql (
	
		$data,
			
		resources => [
	
			'id_voc_res_type',
			'id_org',
			
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],
			
		'orgs'
		
	);
	
}

1;
