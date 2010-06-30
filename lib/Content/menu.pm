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
			name    => '_vocs',
			label   => '�����������',
			no_page => 1,
			off   => !$_USER -> {can} -> {vocs},
			items   => [
				{
					name  => 'voc_ages',
					label => '���������� ���������',
				},
				{
					name  => 'voc_res_types',
					label => '���� ��������',
				},
				{
					name  => '_resources',
					label => '�������',
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
			label   => '����� �������',
			no_page => 1,
			off   => !$_USER -> {can} -> {move},
			items   => [
			
				map {{
					label  => $_ -> {label},
					href   => "/?type=users&action=move&id_org=$_->{id}",
					target => 'invisible',
				}} grep {$_ -> {id} != $_USER -> {id_org}} ({id => 0, label => '[��� �������]'}, @{sql_select_all ('SELECT * FROM orgs WHERE fake = 0 ORDER BY label')})
			
			],			
		},
		{
			name    => '_admin',
			label   => '�������',
			no_page => 1,
			off   => !$_USER -> {can} -> {admin},
			items   => [
				{
					name  => 'log',
					label => '��������',
				},		
				{
					name  => '_info',
					label => '������',
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
