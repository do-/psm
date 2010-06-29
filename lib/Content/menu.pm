################################################################################

sub select_menu_for_admin {

	sql (users_options => [[id_user => $_USER -> {id}]], 'options(name)', sub {$_USER -> {can} -> {$i -> {option} -> {name}} = 1});

	return [
		{
			name  => 'orgs',
			label => '&�������',
			off   => !$_USER -> {can} -> {orgs},
		},
		{
			name  => 'users',
			label => '&������������',
		},
		{
			name  => 'log',
			label => '��&������',
		},		
		{
			name  => '_info',
			label => '&������',
		},
	];

}

################################################################################

sub select_menu {
	return [];
}

1;
