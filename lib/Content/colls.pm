
################################################################################

sub do_update_colls {

	$_REQUEST {_label} or croak "#_label#:Вы забыли ввести наименование коллективного клиента";
	$_REQUEST {_no}    or croak "#_no#:Вы забыли ввести номер карты";
	
	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_colls {

	my $data = sql (colls => ['id'], 'orgs', 'voc_coll_types');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

#	add_vocabularies ($data,
#		voc_foo => {order => "id", filter => "id=$$data{id_colls}"}
#	);

	sql ($data, clients => [
	
		[ id_coll => $data -> {id} ],
		
		[ LIMIT   => 'start, 15'],
		
	], 'voc_roles');
	
	my @today = Date::Calc::Today ();
	
	foreach my $i (@{$data -> {clients}}) {
	
		($i -> {age}) = Date::Calc::Delta_YMD (dt_y_m_d ($i -> {dt_birth}), @today);
	
	}

	return $data;

}

################################################################################

sub do_create_colls { # И что это за процедура?

	$_REQUEST {id} = sql_do_insert (colls => {
	
		id_voc_coll_type => 1,
	
		id_org  		 => $_USER -> {id_org},
		
	});

}

################################################################################

sub select_colls { # Коллективные клиенты

	$_REQUEST {id_org} = $_USER -> {id_org};

	sql (
	
		add_vocabularies ({},
			voc_coll_types => {},
		),
		
		colls => [
		
			'id_org',
	
			'id_voc_coll_type',
			
			['(label LIKE %?% OR no = ?)' => [$_REQUEST {q}, $_REQUEST {q}]],
			
			[ LIMIT => 'start, 50'],
		
		],
			
		'voc_coll_types'
		
	);
	

}


1;
