

################################################################################

sub do_update_clients {

	$_REQUEST {_label} or croak "#_label#:�� ������ ������ ���";
	
	$_REQUEST {_id_voc_role} or croak "#_id_voc_role#:�� ������ ������� ������� �������";
	
	my (@dt_birth) = vld_date ('dt_birth');
	
	if ($_REQUEST {_phone}) {
	
		$_REQUEST {_phone} =~ s{[\(\)\+\-\s]}{}g;
		
		$_REQUEST {_phone} =~ /^\d{7,12}$/ or die "#_phone#:������������ ����� ��������";
		
		$_REQUEST {_phone} =~ s{(\d\d\d)?(\d\d\d)(\d\d)(\d\d)$}{ ($1) $2-$3-$4};

		$_REQUEST {_phone} =~ s{^\s+}{};
	
	}
	
	if ($_REQUEST {_mail}) {
	
		$_REQUEST {_mail} =~ /^[\w\.]+\@[\w\.]+\.[a-z]{2,3}$/ or die "#_mail#:������������ E-mail";
	
	}
	
	Date::Calc::Delta_Days (@dt_birth, Date::Calc::Today ()) > 0 or die "#_dt_birth#:���� �������� �� ����� ���������� � �������";

	do_update_DEFAULT ();

}

################################################################################

sub get_item_of_clients { # ������

	my $data = sql ('clients');

#	$data -> {no_del} ||= 1 if $data -> {id_user} != $_USER -> {id};

	$_REQUEST {__read_only} ||= !($_REQUEST {__edit} || $data -> {fake} > 0);

	return $data;

}


1;
