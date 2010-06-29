label => 'Возрастные категории',

columns => {

	label    => 'string',         # Наименование

	age_from => {TYPE_NAME => 'tinyint', NULLABLE => 0, COLUMN_DEF => 0}, # Возраст от
	age_to   => {TYPE_NAME => 'tinyint', NULLABLE => 0, COLUMN_DEF => 0}, # Возраст до

},

keys => {
	label => 'label',
},


