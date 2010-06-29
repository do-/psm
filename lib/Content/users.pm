################################################################################

sub select_users {
	
	my $item = {
		portion => $conf -> {portion},
	};
	
	my $filter = '';
	my @params = ();
	
	if ($_REQUEST {q}) {		
		$filter .= ' AND users.label LIKE ?';
		push @params, '%' . $_REQUEST {q} . '%';		
	}

	my $start = $_REQUEST {start} + 0;

	($item -> {users}, $item -> {cnt}) = sql_select_all_cnt (<<EOS, @params, {fake => 'users'});
		SELECT
			users.*
			, roles.label AS role_label
		FROM
			users
			LEFT JOIN roles ON users.id_role = roles.id
		WHERE
			1=1
			$filter
		ORDER BY
			users.label
		LIMIT
			$start, $$item{portion}
EOS

	return $item;

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

	$_REQUEST {_label} or die "#_label#:�� ������ ������ ���";

	$_REQUEST {_login} or die "#_login#:�� ������ ������ login";
	
	vld_unique ('users', {
		field => 'login',
	}) or die "#_login#:���� login ��� �����";
	
	if ($_REQUEST {_password}) {
	
		$_REQUEST {_password} eq $_REQUEST {_password2} or die "#_password2#:������ �� ��������";
	
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
		label => '������� �. �.',
	});
	
}

1;
