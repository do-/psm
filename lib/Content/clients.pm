################################################################################

sub select_clients { # Клиенты

	exists $_REQUEST {id_org} or $_REQUEST {id_org} ||= $_USER -> {id_org};

	my $data = sql (
	
		add_vocabularies ({},
		
			orgs => {},
		),
	
		clients => [
	
			'id_org',
			
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],
			
		'colls(*)',

	);	
	
	my @today = Date::Calc::Today ();

	foreach my $i (@{$data -> {clients}}) {
	
		($i -> {age}) = Date::Calc::Delta_YMD (dt_y_m_d ($i -> {dt_birth}), @today);
	
	}
	
	return $data;

}

################################################################################

sub do_update_clients {

	$_REQUEST {_label} or croak "#_label#:Вы забыли ввести ФИО";
	
	$_REQUEST {_id_voc_role} or croak "#_id_voc_role#:Вы забыли выбрать степень родства";
	
	my (@dt_birth) = vld_date ('dt_birth');
	
	if ($_REQUEST {_phone}) {
	
		$_REQUEST {_phone} =~ s{[\(\)\+\-\s]}{}g;
		
		$_REQUEST {_phone} =~ /^\d{7,12}$/ or die "#_phone#:Некорректный номер телефона";
		
		$_REQUEST {_phone} =~ s{(\d\d\d)?(\d\d\d)(\d\d)(\d\d)$}{ ($1) $2-$3-$4};

		$_REQUEST {_phone} =~ s{^\s+}{};
	
	}
	
	if ($_REQUEST {_mail}) {
	
		$_REQUEST {_mail} =~ /^[\w\.]+\@[\w\.]+\.[a-z]{2,3}$/ or die "#_mail#:некорректный E-mail";
	
	}
	
	Date::Calc::Delta_Days (@dt_birth, Date::Calc::Today ()) > 0 or die "#_dt_birth#:дата рождения не может находиться в будущем";

	do_update_DEFAULT ();
	
}

################################################################################

sub get_item_of_clients { # Клиент

	my $data = sql (clients => ['id'], 'colls');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	sql ($data, clients => [
	
		['id <>'  => $data -> {id} ],
	
		[ id_coll => $data -> {id_coll} ],
				
	], 'voc_roles');

	my @today = Date::Calc::Today ();

	foreach my $i (@{$data -> {clients}}) {
	
		($i -> {age}) = Date::Calc::Delta_YMD (dt_y_m_d ($i -> {dt_birth}), @today);
	
	}

	return $data;

}


1;
