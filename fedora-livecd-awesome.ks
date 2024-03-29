# Original file: fedora-livecd-lxde.ks ; cwickert@fedoraproject.org
# fedora-livecd-awesome.ks
#
# Description:
# - Fedora Live Spin with the light-weight Awesome Window Manager
#
# Maintainer(s):
# - Simon A. Erat <erat.simon@gmail.com>

%include fedora-live-base.ks
%include fedora-live-minimization.ks
%include fedora-awesome-packages.ks

%post
# AWESOME and LXDM configuration
sed 's|# autologin=dgod|autologin=liveuser|g' -i /etc/lxdm/lxdm.conf
sed 's|# session=/usr/bin/startlxde|session=/bin/awesome|g' -i /etc/lxdm/lxdm.conf

# create /etc/sysconfig/desktop (needed for installation)
cat > /etc/sysconfig/desktop <<EOF
PREFERRED=/bin/awesome
DISPLAYMANAGER=/usr/sbin/lxdm
EOF

cat >> /etc/rc.d/init.d/livesys << EOF
# disable screensaver locking and make sure gamin gets started
cat > /etc/xdg/lxsession/LXDE/autostart << FOE
/usr/libexec/gam_server
@lxpanel --profile LXDE
@pcmanfm --desktop --profile LXDE
/usr/libexec/notification-daemon
FOE

# set up preferred apps 
cat > /etc/xdg/libfm/pref-apps.conf << FOE 
[Preferred Applications]
WebBrowser=firefox.desktop
MailClient=sylpheed.desktop
FOE

# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# create default config for clipit, otherwise it displays a dialog on startup
mkdir -p /home/liveuser/.config/clipit
cat .config/clipit/clipitrc  << FOE
[rc]
use_copy=true
use_primary=false
synchronize=false
automatic_paste=false
show_indexes=false
save_uris=true
use_rmb_menu=false
save_history=false
history_limit=50
items_menu=20
statics_show=true
statics_items=10
hyperlinks_only=false
confirm_clear=false
single_line=true
reverse_history=false
item_length=50
ellipsize=2
history_key=<Ctrl><Alt>H
actions_key=<Ctrl><Alt>A
menu_key=<Ctrl><Alt>P
search_key=<Ctrl><Alt>F
offline_key=<Ctrl><Alt>O
offline_mode=false
FOE

# this goes at the end after all other changes.
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser
EOF
%end
