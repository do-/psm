label => 'Типы ресурсов',

columns => {

	is_bound => 'checkbox',       # Привязан ли к филиалу
	label    => 'string',         # Наименование

},

keys => {
	label => 'label',
},

data => [
	{id => 1, fake => 0, is_bound => 0, label => 'Преподаватель'},
	{id => 2, fake => 0, is_bound => 1, label => 'Помещение'},
],
