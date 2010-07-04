label => 'Коллективные клиенты',

columns => {

	id_org           => '(orgs)', 					# Филииал
	id_voc_coll_type => 'radio(voc_coll_types)', 	# Тип
	label            => 'string',         			# Наименование
	no               => 'string',         			# Номер карты

},

keys => {
	label => 'id_org, label',
},


