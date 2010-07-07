label => 'Клиенты',

columns => {

	id_org  	=> '(orgs)', 			# Филиал
	id_coll 	=> '(colls)', 			# Коллективный клиент
	id_voc_role	=> 'select(voc_roles)',	# Степень родства

	label   	=> 'string',         	# ФИО
	mail    	=> 'string',         	# e-mail	
	phone   	=> 'string',         	# Мобильный телефон
	dt_birth    => 'date',           	# Дата рождения

},

keys => {
	id_org => 'id_org, label',
},


