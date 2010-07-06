

################################################################################

sub draw_item_of_colls {

	my $data = __d ($_[0]);	

	$_REQUEST {__focused_input} = '_label';

	draw_form ({
	
			right_buttons => [del ($data)],
			
			no_edit => $data -> {no_del},
			
			path => [
				{type => 'colls', name => action_type_label},
				{type => 'colls', name => $data -> {label}, id => $data -> {id}},
			],
			
		},
		
		$data,
		
		[
		
			{
				name    => 'org.label',
				label   => 'Филиал',
				type    => 'static',
			},
			{
				name    => 'label',
				label   => 'Наименование',
				size    => 40,
				max_len => 255,
			},
			{
				name    => 'no',
				label   => 'Номер карты',
				size    => 40,
				max_len => 255,
			},

			{
				name   => 'id_voc_coll_type',
				label  => 'Тип',
				type   => 'radio',
				values => $data -> {voc_coll_types},
			},

		],

	)

	.

	draw_table (

		sub {
		
			__d ($i);
		
			draw_cells ({
				href  => "/?type=clients&id=$i->{id}",
			},[
				
				$i -> {label},
				$i -> {dt_birth},
				$i -> {voc_role} -> {label},
				
			]),
		
		},
		
		$data -> {clients},
		
		{
			
			title => {label => 'Состав'},
			
			off   => !$_REQUEST{__read_only},
			
			name  => 't1',
						
			top_toolbar => [
			
				{
					keep_params => ['type', 'id'],
				},

				{
					icon  => 'create',
					label => '&Добавить',
					href  => "?type=clients&action=create&id_coll=$data->{id}&id_org=$data->{id_org}",
				},

			],
			
		}

	);

}



################################################################################

sub draw_colls {

	my ($data) = @_;

	return

		draw_table (

#			[
#				'Наименование',
#			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=colls&id=$$i{id}",
				},[
	
					$i -> {no},
					$i -> {label},
					$i -> {voc_coll_type} -> {label},

				])

			},

			$data -> {colls},

			{
				
				name => 't1',
				
				title => {label => action_type_label},

				top_toolbar => [{
						keep_params => ['type', 'select'],
					},

					{
						icon  => 'create',
						label => '&Добавить',
						href  => '?type=colls&action=create',
					},
					
					{
						type  => 'input_text',
						label => 'Искать',
						name  => 'q',
						keep_params => [],
					},

					{
						type   => 'input_select',
						name   => 'id_voc_coll_type',
						values => $data -> {voc_coll_types},
						empty  => '[Все типы]',
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
