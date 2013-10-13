# Original file: fedora-lxde-packages.ks ; cwickert@fedoraproject.org
# fedora-awesome-packages.ks
#
# Description:
# - Fedora Live Spin with the light-weight Awesome Window Manager
#
# Maintainer(s):
# - Simon A. Erat <erat.simon@gmail.com>

%packages
### Awesome desktop
awesome*
@lxde-desktop
-gigolo
-leafpad
gedit
#@lxde-apps
#@lxde-media
-asunder
-pnmixer
#@lxde-office
-osmo
#firefox

# pam-fprint causes a segfault in LXDM when enabled
-fprintd-pam


# LXDE has lxpolkit. Make sure no other authentication agents end up in the spin.
-polkit-gnome
-polkit-kde
#-*kde*
#-*gnome*

# make sure xfce4-notifyd is not pulled in
notification-daemon
-xfce4-notifyd

# make sure xfwm4 is not pulled in for firstboot
# https://bugzilla.redhat.com/show_bug.cgi?id=643416
metacity


# dictionaries are big
-aspell-*
-hunspell-*
-man-pages-*
-words

# use ssmtp instead of sendmail
-sendmail
-ssmtp

# save some space
-autofs
-acpid
-gimp-help
-desktop-backgrounds-basic
-realmd                     # only seems to be used in GNOME
-PackageKit*                # we switched to yumex, so we don't need this
-foomatic-db-ppds
-foomatic
-stix-fonts
-ibus-typing-booster
-libqzeitgeist
-wqy-zenhei-fonts

# FIXME: can be removed once mtpaint is gone from lxde-apps in comps
-mtpaint

# drop some system-config things
-system-config-boot
#-system-config-language
#-system-config-network
-system-config-rootpassword
#-system-config-services
-policycoreutils-gui
#-gnome-disk-utility

# we need UPower for suspend and hibernate
upower

%end
