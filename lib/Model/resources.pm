label => '�������',

columns => {

	id_voc_res_type => '(voc_res_types)', # ��� �������
	id_user         => '(users)',         # ������ �� ����������
	id_org          => 'select (orgs)'  , # ������
	label           => 'string',          # ������������

},

keys => {
	id_org          => 'id_org,label',
	id_voc_res_type => 'id_voc_res_type,label',
	label           => 'label',
	id_user         => 'id_user',
},


