################################################################################

sub select_users { # Список пользователей

	sql (
	
		add_vocabularies ({},
			orgs => {},
		),
		
		users => [
	
			'id_org',
			
			['label LIKE %?%' => $_REQUEST {q}],
			
			[ LIMIT => 'start, 50'],
		
		],
			
		'orgs'
		
	);
	
}

################################################################################

sub get_item_of_users {

	my $data = sql_select_hash ("users");
	
	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);
	
	sql ($data, options => [], [users_options => [

		[id_user => $data -> {id}],

	]]);
	
	foreach my $i (@{$data -> {options}}) {
	
		$i -> {users_option} -> {id} or next;
		
		push @{$data -> {users_options}}, $i -> {id};
	
	}
		
	return $data;
	
}

################################################################################

sub do_update_users {

	$_REQUEST {_id_role} = 1;

	$_REQUEST {_label} or die "#_label#:Вы забыли ввести ФИО";

	$_REQUEST {_login} or die "#_login#:Вы забыли ввести login";
	
	vld_unique ('users', {
		field => 'login',
	}) or die "#_login#:этот login уже занят";
	
	if ($_REQUEST {_password}) {
	
		$_REQUEST {_password} eq $_REQUEST {_password2} or die "#_password2#:пароль не сходится";
	
		$_REQUEST {_password} = sql_select_scalar ('SELECT PASSWORD(?)', $_REQUEST {_password});
	
	}
	else {
	
		delete $_REQUEST {_password};
	
	}
	
	do_update_DEFAULT ();
	
	wish (table_data =>
	
		[map {{	fake => 0, id_option => $_ }} get_ids ('users_options')], {
		
			table   => 'users_options',
			root    => {id_user => $_REQUEST {id}},
			key     => 'id_option',
			delayed => 1,
			
		}
		
	);

}

################################################################################

sub do_create_users {

	$_REQUEST {id} = sql_do_insert ('users', {
		label => 'Фамилия И. О.',
	});
	
}

1;
