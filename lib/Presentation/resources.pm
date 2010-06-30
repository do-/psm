

################################################################################

sub draw_item_of_resources {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'resources', name => action_type_label},
				{type => 'resources', name => $data -> {label}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[
		
			{
				name    => 'voc_res_type.label',
				label   => 'Тип',
				type    => 'static',
			},
			{
				name    => 'org.label',
				label   => 'Филиал',
				type    => 'static',
				off     => !$data -> {id_org},
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

sub draw_resources {

	my ($data) = @_;

	return

		draw_table (

			[
				'Наименование',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=resources&id=$$i{id}",
				},[
	
					$i -> {label},

				])

			},

			$data -> {resources},

			{
				
				name => 't1',
				
				title => {label => join ' / ', grep {$_} ("Ресурсы типа '$data->{label}'", $data -> {org} -> {label})},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&Добавить',
						href  => {action => 'create'},
						off   => $data -> {id} == 1,
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
