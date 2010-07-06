

################################################################################

sub draw_item_of_clients {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'clients', name => action_type_label},
				{type => 'clients', name => $data -> {label}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[
			{
				name    => 'label',
				label   => 'ФИО',
				size    => 80,
				max_len => 255,
			},
			
			{
				name    => 'id_voc_role',
				empty   => '[Выберите степень родства]',
			},
			
			'dt_birth',

		],

	)

}


1;
