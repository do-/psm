################################################################################

sub draw_item_of_users {

	my ($data) = @_;	
	
	$_REQUEST {__focused_input} = '_label';
	
	draw_form ({
	
		right_buttons => [ del ($data) ],
	
	}, $data,
		[
			{
				name  => 'label',
				label => '���',
			},
			{
				name  => 'login',
				label => '&login',
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
		]
	)
	
}

################################################################################

sub draw_users {
	
	my ($data) = @_;
	
	return
	
		draw_table (
		
			['���', 'login'],

			sub {
					
				draw_text_cells ({
					href => "/?type=users&id=$$i{id}",
				}, [
					$i -> {label},
					$i -> {login},
				])
								
			},
			
			$data -> {users},			
			
			{		
			
				title => {label => '������������'},
		
				top_toolbar => [
				
					{},
					
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
