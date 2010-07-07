

################################################################################

sub draw_clients {

	my ($data) = @_;

	return

		draw_table (

		[
			'ФИО',
			'ДР',
			'Возраст',
			'Дом.',
			'Моб.',
			'E-mail',
			'Адрес',
			
		],

		sub {
		
			__d ($i);
		
			draw_cells ({
				href  => "/?type=clients&id=$i->{id}",
			},[
				
				$i -> {label},
				$i -> {dt_birth},
				{
					label   => $i -> {age},
					picture => '###',
				},
				$i -> {coll} -> {phone},
				$i -> {phone},
				{
					label => $i -> {mail},
					href  => "mailto:$i->{mail}",
				},
				$i -> {coll} -> {address},
				
			]),
		
		},

			$data -> {clients},

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
						off   => !$_REQUEST {id_org},
					},

					{
						type  => 'input_text',
						label => 'Искать',
						name  => 'q',
						keep_params => [],
					},

					{
						type   => 'input_select',
						name   => 'id_org',
						values => $data -> {orgs},
						empty  => '[Все филиалы]',
					},

					{
						type    => 'pager',
					},

					fake_select (),

				],

			}

		);

}



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
				type    => 'banner',
				label   => 'СЕМЕЙНЫЕ ДАННЫЕ',
			},

			{
				type    => 'static',
				label   => 'Номер карты',
				name    => 'coll.no',
				href    => "/?type=colls&id=$data->{id_coll}",
			},
			{
				type    => 'static',
				label   => 'Адрес',
				name    => 'coll.address',
				href    => "/?type=colls&id=$data->{id_coll}",
			},
			{
				type    => 'static',
				label   => 'Домашний телефон',
				name    => 'coll.phone',
				href    => "/?type=colls&id=$data->{id_coll}",
			},

			{
				type    => 'banner',
				label   => 'ЛИЧНЫЕ ДАННЫЕ',
			},

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
			
			{
				name    => 'dt_birth',
				label   => 'Дата рождения',
			},

			{
				name    => 'phone',
				label   => 'Мобильный телефон',
				size    => 15,
			},

			{
				name    => 'mail',
				label   => 'E-mail',
				size    => 80,
				max_len => 255,
				href    => "mailto:$data->{mail}",
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
			
			title => {label => 'Родственники'},
			
			off   => !$_REQUEST{__read_only},
			
			name  => 't1',
						
			top_toolbar => [
			
				{
					keep_params => ['type', 'id'],
				},

				{
					icon  => 'create',
					label => '&Добавить',
					href  => "?type=clients&action=create&id_coll=$data->{id_coll}&id_org=$data->{id_org}",
				},

			],
			
		}

	);

}


1;
