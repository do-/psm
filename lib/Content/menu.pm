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
				{
					name  => 'voc_res_types',
					label => 'Типы ресурсов',
				},
				{
					name  => '_resources',
					label => 'Ресурсы',
					items => [					
						map {{
							label => $_ -> {label},
							href  => "/?type=resources&id_voc_res_type=$_->{id}",
						}} @{sql_select_all ('SELECT * FROM voc_res_types WHERE fake = 0 ORDER BY label')}				
					]
				},
			],
		},
		{
			name    => '_move',
			label   => 'Смена филиала',
			no_page => 1,
			off   => !$_USER -> {can} -> {move},
			items   => [
			
				map {{
					label  => $_ -> {label},
					href   => "/?type=users&action=move&id_org=$_->{id}",
					target => 'invisible',
				}} grep {$_ -> {id} != $_USER -> {id_org}} ({id => 0, label => '[Все филиалы]'}, @{sql_select_all ('SELECT * FROM orgs WHERE fake = 0 ORDER BY label')})
			
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
