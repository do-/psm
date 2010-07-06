

################################################################################

sub draw_item_of_voc_roles {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'voc_roles', name => action_type_label},
				{type => 'voc_roles', name => $data -> {label}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[
			{
				name    => 'label',
				label   => 'Наименование',
				size    => 40,
				max_len => 255,
			},

		],

	)

}

################################################################################

sub draw_voc_roles {

	my ($data) = @_;

	return

		draw_table (

			[
				'Наименование',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=voc_roles&id=$$i{id}",
				},[
	
					$i -> {label},

				])

			},

			$data -> {voc_roles},

			{
				
				name => 't1',
				
				title => {label => action_type_label},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&Добавить',
						href  => '?type=voc_roles&action=create',
					},
					
					{
						type  => 'input_text',
						label => 'Искать',
						name  => 'q',
						keep_params => [],
					},
					
					{
						type    => 'pager',
					},

					fake_select (),

				],
				
			}

		);

}


1;
