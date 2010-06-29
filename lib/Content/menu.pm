################################################################################

sub select_menu_for_admin {

	sql (users_options => [[id_user => $_USER -> {id}]], 'options(name)', sub {$_USER -> {can} -> {$i -> {option} -> {name}} = 1});

	return [
		{
			name  => 'orgs',
			label => '&Филиалы',
			off   => !$_USER -> {can} -> {orgs},
		},
		{
			name  => 'users',
			label => '&Пользователи',
		},
		{
			name    => '_vocs',
			label   => 'Справочники',
			no_page => 1,
			off   => !$_USER -> {can} -> {vocs},
			items   => [
				{
					name  => 'voc_ages',
					label => 'Возрастные категории',
				},
			],
		},
		{
			name    => '_admin',
			label   => 'Система',
			no_page => 1,
			off   => !$_USER -> {can} -> {admin},
			items   => [
				{
					name  => 'log',
					label => 'Протокол',
				},		
				{
					name  => '_info',
					label => 'Версии',
				},
			],			
		},
	];

}

################################################################################

sub select_menu {
	return [];
}

1;
