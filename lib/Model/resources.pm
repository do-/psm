label => 'Ğåñóğñû',

columns => {

	id_voc_res_type => '(voc_res_types)', # Òèï ğåñóğñà
	id_user         => '(users)',         # Ññûëêà íà ñîòğóäíèêà
	id_org          => 'select (orgs)'  , # Ôèëèàë
	label           => 'string',          # Íàèìåíîâàíèå

},

keys => {
	id_org          => 'id_org,label',
	id_voc_res_type => 'id_voc_res_type,label',
	label           => 'label',
	id_user         => 'id_user',
},


