

function editDir() { cd $1 && $EDITOR . && cd - > /dev/null }

export function existCommand() {
	command -v "$1" > /dev/null
}

export function botstrap_plugin() {
	if [ -z $1 ] || [ -z $2 ]; then
		printf "usage:\n\t${BLUE}botstrap_plugin${NC} [name] [repo-url]\n"	
	else
		ZSH_PLUGIN_DIR=$ZSH_PLUGINS/$1
		if [ ! -d $ZSH_PLUGIN_DIR ]; then
			git clone $2 $ZSH_PLUGIN_DIR
		fi
	fi
}

export function botstrap_omzsh_plugin() {
	if [ -z $1 ]; then
		printf "usage: \n\t${BLUE}botstrap_plugin${NC} \"[name1] [name2] ...\" <dir>\n\t${BLUE}botstrap_plugin${NC} \"[name1],[name2],...\" <dir>\n"
	else

		if [ ! -z $2 ]; then OMZ_PLUGIN_INSTALL_DIR=$2
		else OMZ_PLUGIN_INSTALL_DIR=$ZSH_PLUGINS; fi

			# echo $1 | tr " " "\n"
			echo $1 | tr "," "\n" | tr " " "\n" | while read -r plugin; do 
			if [ ! -d "$OMZ_PLUGIN_INSTALL_DIR/$plugin" ]; then 
				if [ ! -d "/tmp/omzh" ]; then
					git clone https://github.com/ohmyzsh/ohmyzsh.git /tmp/omzh
				fi
				cp -r /tmp/omzh/plugins/$plugin $OMZ_PLUGIN_INSTALL_DIR/
			fi
		done
	fi

	if [ -d /tmp/omzh ]; then rm -rf /tmp/omzh; fi
}

function packageAdd() {
  ([ -z $2 ] && existCommand $1 || eval "$2 $1" > /dev/null) || PACKAGES="$PACKAGES $1"
}

function bootstrapSubstitution() {
	APPS=$1
	echo $2 | tr " " "\n" | while read -r SUBST; do
		APPS=$(echo $APPS | sed -e "s/$(echo $SUBST | cut -d '=' -f1)/$(echo $SUBST | cut -d '=' -f2 | tr ';' ' ')/g")
	done
	printf "$APPS"
	unset APPS
}

##
#	$1 = PACKAGES
#	$2 = SUBSTITUTIONS
#	$3 = DOWNLOAD COMMAND
##
function generalPackageBootstrap() {
	PACKAGES=""
	echo $2 | tr " " "\n" | while read -r PACKET; do
		packageAdd "$PACKET" $4
	done
	[ ! -z "$PACKAGES" ] && print "Installing apps:$PACKAGES" && eval "$1$(bootstrapSubstitution $PACKAGES $3)";
	unset PACKAGES
}

function unsetCustomFuncs() {
	unset -f packageAdd
	unset -f bootstrapSubstitution
	unset -f generalPackageBootstrap
	unset -f botstrap_plugin
	unset -f botstrap_omzsh_plugin
}

