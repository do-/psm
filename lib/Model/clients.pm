label => 'Клиенты',

columns => {

	id_org  	=> '(orgs)', 			# Филиал
	id_coll 	=> '(colls)', 			# Коллективный клиент

	label   	=> 'string',         	# ФИО
	dt_birth    => 'date',           	# Дата рождения

},

keys => {
	id_org => 'id_org, label',
},


