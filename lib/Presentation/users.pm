################################################################################

sub draw_item_of_users {

	my ($data) = @_;	
	
	$_REQUEST {__focused_input} = '_label';
	
	draw_form ({
	
		right_buttons => [ del ($data) ],
	
		path => [
			{type => 'users', name => '������������'},
			{type => 'users', name => $data -> {label}, id => $data -> {id}},
		],

	}, $data,
		[
			{
				name  => 'label',
				label => '���',
			},
			{
				name  => 'login',
				label => '&Login',
			},
			{
				name  => 'password',
				label => '�����&�',
				type  => 'password',
			},
			{
				name  => 'password2',
				label => '������ ������',
				type  => 'password',
			},
			{
				name  => 'id_org',
				empty => '',
			},
			{
				name  => 'users_options',
				label => '�����',
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
				'���',
				'������',
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
			
				title => {label => '������������'},
		
				top_toolbar => [
				
					{keep_params => ['type']},
					
					{
						icon => 'create',
						label => '&��������',
						href => "?type=users&action=create",
					},
		
					{
						type   => 'input_text',
						label  => '������',
						name   => 'q',
					},
					
					{
						type   => 'input_select',
						values => $data -> {orgs},
						empty  => '[��� �������]',
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
