
################################################################################

sub do_update_colls {

	$_REQUEST {_label}     or die "#_label#:Вы забыли ввести наименование коллективного клиента";

	$_REQUEST {_street}    or die "#_street#:Вы забыли ввести название улицы (площади, переулка...)";
	$_REQUEST {_building}  or die "#_building#:Вы забыли ввести номер дома";
	$_REQUEST {_apartment} or die "#_apartment#:Вы забыли ввести номер квартиры (офиса)";
	
	$_REQUEST {_address}  = "$_REQUEST{_street}, д.$_REQUEST{_building}";
	$_REQUEST {_address} .= ", корп. $_REQUEST{_corpus}" if $_REQUEST {_corpus};
	$_REQUEST {_address} .= ", кв. $_REQUEST{_apartment}";

	if ($_REQUEST {_phone}) {
	
		$_REQUEST {_phone} =~ s{[\(\)\+\-\s]}{}g;
		
		$_REQUEST {_phone} =~ /^\d{7,12}$/ or die "#_phone#:Некорректный номер телефона";
		
		$_REQUEST {_phone} =~ s{(\d\d\d)?(\d\d\d)(\d\d)(\d\d)$}{ ($1) $2-$3-$4};

		$_REQUEST {_phone} =~ s{\(\)}{};
		$_REQUEST {_phone} =~ s{^\s+}{};
	
	}

	$_REQUEST {_no}        or die "#_no#:Вы забыли ввести номер карты";
	
	do_update_DEFAULT ();
	
	sql_do ('UPDATE colls SET dt = NOW() WHERE id = ? AND dt IS NULL', $_REQUEST {id});

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
