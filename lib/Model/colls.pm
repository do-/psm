label => 'Коллективные клиенты',

columns => {

	id_org           => '(orgs)', 					# Филииал
	id_voc_coll_type => 'radio(voc_coll_types)', 	# Тип
	label            => 'string',         			# Наименование
	no               => 'string',         			# Номер карты
	street           => 'string',         			# Улица
	building         => 'string',         			# Дом
	corpus           => 'string',         			# Корпус
	apartment        => 'string',         			# Квартира
	address          => 'string',         			# Адрес
	phone            => 'string',         			# Телефон
	dt               => 'date',         			# Дата регистрации

},

keys => {
	label => 'id_org, label',
},


