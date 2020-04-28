# Define functions
%define ifdef()     %if %{expand:%%{?%{1}:1}%%{!?%{1}:0}}
%define _defaultRel 0.%(date "+%y%m%d%H%M")

%ifdef trueRel
    %define rel %{trueRel}
%else
    %define rel %{_defaultRel}
%endif

Name:           steppe-test
Version:        0.0.1
Release:        %{rel}%{?dist}
Summary:        Test RPM for testing yum functionality

License:        None
URL:            https://github.com/msteppe91/bash-scripts
#Source0:

#BuildRequires:
#Requires:

%description
This RPM is purely used to test yum functionality when installed/uninstalled

%prep

%build

%install

%clean

%files

%changelog
* Mon Apr 27 2020 Michael Steppe <msteppe91@users.noreply.github.com>
- First whack at new RPM
