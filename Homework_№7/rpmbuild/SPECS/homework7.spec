Name:           homework7
Version:        1
Release:        0
Summary:        A Bash Script for homework #7

Group:          Admin
BuildArch:      noarch
License:        GPL
URL:            git@github.com:pipetky/epam_devops_data.git
Source0:        homework7.tar.gz

%description
The script outputs words count stored in file.

%prep
%setup -q
%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/etc/homework7
install -m 0600 textfile.txt $RPM_BUILD_ROOT/etc/homework7/textfile.txt
install -m 0755 homework7.sh $RPM_BUILD_ROOT/etc/homework7/homework7.sh

%files
/etc/homework7
/etc/homework7/textfile.txt
/etc/homework7/homework7.sh

%changelog
* Tue Dec 24 2021 Alexandr Karabchevskiy  1.0.0
  - Initial rpm release
