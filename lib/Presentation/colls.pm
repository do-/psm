

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
				name    => 'dt',
				label   => 'Дата регистрации',
				type    => 'static',
				off     => !$data -> {dt},
			},
			{
				name    => 'label',
				label   => 'Наименование',
				size    => 40,
				max_len => 255,
			},
			{
				name    => 'address',
				label   => 'Адрес',
				type    => 'static',
				off     => !$_REQUEST {__read_only},
			},
			{
				label   => 'Адрес',
				type    => 'hgroup',
				off     => $_REQUEST {__read_only},
				items   => [
				
					{
						name     => 'street',
						size     => 30,
						max_len  => 255,
						label    => '',
					},
					{
						name     => 'building',
						size     => 5,
						max_len  => 255,
						label    => 'д.',
						no_colon => 1,
					},
					{
						name     => 'corpus',
						size     => 5,
						max_len  => 255,
						label    => 'корп.',
						no_colon => 1,
					},
					{
						name     => 'apartment',
						size     => 5,
						max_len  => 255,
						label    => 'кв.',
						no_colon => 1,
					},
				
				],

			},
			
			{
				name    => 'phone',
				label   => 'Телефон',
				size    => 15,
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
		
		[
			'ФИО',
			'Роль',
			'ДР',
			'Возраст',
			'Моб.',
			'E-mail',
			
		],

		sub {
		
			__d ($i);
		
			draw_cells ({
				href  => "/?type=clients&id=$i->{id}",
			},[
				
				$i -> {label},
				$i -> {voc_role} -> {label},
				$i -> {dt_birth},
				{
					label   => $i -> {age},
					picture => '###',
				},
				$i -> {phone},
				{
					label => $i -> {mail},
					href  => "mailto:$i->{mail}",
				}
				
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

			[
				'Карта',
				'Наименование',
				'Тип',
				'Адрес',
				'Телефон',
			],

			sub {

				__d ($i);

				draw_cells ({
					href => "/?type=colls&id=$$i{id}",
				},[
	
					$i -> {no},
					$i -> {label},
					$i -> {voc_coll_type} -> {label},
					$i -> {address},
					$i -> {phone},

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
