Name:       harbour-spiritlevel

# >> macros
%define _binary_payload w2.xzdio
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}

Summary:    A spirit level for sailfish
Version:    0.5
Release:    1
License:    BSD
BuildArch:  noarch
URL:        https://github.com/poetaster/spiritlevel
Source0:    %{name}-%{version}.tar.bz2
Requires:   sailfishsilica-qt5 >= 0.10.9
Requires:   libsailfishapp-launcher
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.3
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  qt5-qtdeclarative-import-sensors
BuildRequires:  qt5-qtsensors
BuildRequires:  qt5-qtdeclarative-import-multimedia
BuildRequires:  qt5-qtdeclarative-import-localstorageplugin
BuildRequires:  desktop-file-utils
BuildRequires:  qt5-qttools-linguist

%description
A spiritlevel based on Based Vatupassi, 2014 - 2022 Bruno Valdrighi Luvizotto
%if "%{?vendor}" == "chum"
PackageName: Spritradar
Type: desktop-application
Categories:
 - Uitility
DeveloperName: Bruno Luvizotto, Mark Washeim (poetaster)
Custom:
 - Repo: https://github.com/poetaster/harbour-spiritlevel
Icon: https://github.com/poetaster/spiritlevel/blob/cdc5797734bce5f977b255798d34f0251257929b/icons/172x172/harbour-spiritlevel.png
Screenshots:
 - https://github.com/poetaster/spiritlevel/blob/cdc5797734bce5f977b255798d34f0251257929b/Screenshot_001.png
 - https://github.com/poetaster/spiritlevel/blob/cdc5797734bce5f977b255798d34f0251257929b/Screenshot_002.png
 - https://github.com/poetaster/spiritlevel/blob/cdc5797734bce5f977b255798d34f0251257929b/Screenshot_003.png
%endif

%prep
%setup -q -n %{name}-%{version}

%build

%qmake5 

%make_build


%install
%qmake5_install


desktop-file-install --delete-original         --dir %{buildroot}%{_datadir}/applications                %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%defattr(0644,root,root,-)
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
