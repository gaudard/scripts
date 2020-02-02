function apt-updater {
	apt-get update &&
	apt-get dist-upgrade -Vy &&
	apt-get autoremove -y &&
	apt-get autoclean &&
	apt-get clean
	}
alias ping="ping -c1"
alias b=byobu
function xwin {
	xfce4-terminal --geometry 140x35-0+31 &
	xfce4-terminal --geometry 94x55+0-0 &
	xfce4-terminal --geometry 140x16-0-0 &
	}
