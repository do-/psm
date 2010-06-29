

################################################################################

sub draw_item_of_voc_res_types {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'voc_res_types', name => action_type_label},
				{type => 'voc_res_types', name => $data -> {label}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[
			{
				name    => 'label',
				label   => '������������',
				size    => 40,
				max_len => 255,
			},
			
			'is_bound',

		],

	)

}

################################################################################

sub draw_voc_res_types {

	my ($data) = @_;

	return

		draw_table (

			[
				'������������',
				'�������� �� � �������',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=voc_res_types&id=$$i{id}",
				},[
	
					$i -> {label},
					
					$i -> {is_bound} ? '��������' : '�� ��������',

				])

			},

			$data -> {voc_res_types},

			{
				
				name => 't1',
				
				title => {label => action_type_label},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&��������',
						href  => '?type=voc_res_types&action=create',
					},

					{
						type  => 'input_text',
						label => '������',
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
