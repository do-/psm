

################################################################################

sub draw_item_of_orgs {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'orgs', name => action_type_label},
				{type => 'orgs', name => $data -> {label}, id => $data -> {id}},
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

sub draw_orgs {

	my ($data) = @_;

	return

		draw_table (

			[
				'Наименование',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=orgs&id=$$i{id}",
				},[
	
					$i -> {label},

				])

			},

			$data -> {orgs},

			{
				
				name => 't1',
				
				title => {label => action_type_label},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&Добавить',
						href  => '?type=orgs&action=create',
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
