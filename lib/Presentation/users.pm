################################################################################

sub draw_item_of_users {

	my ($data) = @_;	
	
	$_REQUEST {__focused_input} = '_label';
	
	draw_form ({
	
		right_buttons => [ del ($data) ],
	
		path => [
			{type => 'users', name => 'Пользователи'},
			{type => 'users', name => $data -> {label}, id => $data -> {id}},
		],

	}, $data,
		[
			{
				name  => 'label',
				label => 'ФИО',
			},
			{
				name  => 'login',
				label => '&Login',
			},
			{
				name  => 'password',
				label => 'Парол&ь',
				type  => 'password',
			},
			{
				name  => 'password2',
				label => 'Повтор пароля',
				type  => 'password',
			},
			{
				name  => 'id_org',
				empty => '',
			},
			{
				name  => 'users_options',
				label => 'Опции',
				type  => 'checkboxes',
				values => $data -> {options},
			},
		]
	)
	
}

################################################################################

sub draw_users {
	
	my ($data) = @_;
	
	return
	
		draw_table (
		
			[
				'ФИО',
				'Филиал',
				'login',
			],

			sub {
					
				draw_text_cells ({
					href => "/?type=users&id=$$i{id}",
				}, [
					$i -> {label},
					$i -> {org} -> {label},
					$i -> {login},
				])
								
			},
			
			$data -> {users},			
			
			{		
			
				title => {label => 'Пользователи'},
		
				top_toolbar => [
				
					{keep_params => ['type']},
					
					{
						icon => 'create',
						label => '&Добавить',
						href => "?type=users&action=create",
					},
		
					{
						type   => 'input_text',
						label  => 'Искать',
						name   => 'q',
					},
					
					{
						type   => 'input_select',
						values => $data -> {orgs},
						empty  => '[Все филиалы]',
						name   => 'id_org',
					},
					
					{
						type    => 'pager',
						cnt     => 0 + @{$data -> {users}},
						total   => $data -> {cnt},
						portion => $data -> {portion},
					},
					
					fake_select (),
					
				],
			
			},			
			
		)
		
}

1;
