label => '�������',

columns => {

	id_org  	=> '(orgs)', 			# ������
	id_coll 	=> '(colls)', 			# ������������ ������
	id_voc_role	=> 'select(voc_roles)',	# ������� �������

	label   	=> 'string',         	# ���
	mail    	=> 'string',         	# e-mail	
	phone   	=> 'string',         	# ��������� �������
	dt_birth    => 'date',           	# ���� ��������

},

keys => {
	id_org => 'id_org, label',
},


