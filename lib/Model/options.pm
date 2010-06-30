label => 'Привилегии в системе',

columns => {

	name    => 'string',         # Символическое имя
	label   => 'string',         # Наименование

},

keys => {
	label => 'label',
},

data => [
	{name => 'users', fake => 0, label => 'Администрирование пользователей'},
	{name => 'orgs',  fake => 0, label => 'Администрирование филиалов'},
	{name => 'vocs',  fake => 0, label => 'Администрирование справочников'},
	{name => 'move',  fake => 0, label => 'Смена филиала'},
	{name => 'admin', fake => 0, label => 'Системные функции'},
],
