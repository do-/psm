label => '������������ �������',

columns => {

	id_org           => '(orgs)', 					# �������
	id_voc_coll_type => 'radio(voc_coll_types)', 	# ���
	label            => 'string',         			# ������������
	no               => 'string',         			# ����� �����
	street           => 'string',         			# �����
	building         => 'string',         			# ���
	corpus           => 'string',         			# ������
	apartment        => 'string',         			# ��������
	address          => 'string',         			# �����
	phone            => 'string',         			# �������
	dt               => 'date',         			# ���� �����������

},

keys => {
	label => 'id_org, label',
},


