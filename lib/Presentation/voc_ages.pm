

################################################################################

sub draw_item_of_voc_ages {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_age_from';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'voc_ages', name => action_type_label},
				{type => 'voc_ages', name => $data -> {label}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[
			
			{	
				type    => 'hgroup',
				label   => 'От',
				items   => [
					{
						name     => 'age_from',
						label    => ' ',
						no_colon => 1,
						size     => 3,
						picture  => '###',
					},
					{
						name     => 'age_to',
						label    => ' ',
						no_colon => 1,
						size     => 3,
						picture  => '###',
					},
				]
			},

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

sub draw_voc_ages {

	my ($data) = @_;

	return

		draw_table (

			[
				'Наименование',
				'От',
				'До',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=voc_ages&id=$$i{id}",
				},[
	
					$i -> {label},
					{
						label   => $i -> {age_from},
						picture => '###',
					},
					{
						label   => $i -> {age_to},
						picture => '###',
					},

				])

			},

			$data -> {voc_ages},

			{
				
				name => 't1',
				
				title => {label => action_type_label},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&Добавить',
						href  => '?type=voc_ages&action=create',
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
