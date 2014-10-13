# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

[[ -s "/Users/dholland/.rvm/scripts/rvm" ]] && source "/Users/dholland/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

source ~/.git-prompt.sh

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
L_YELLOW="\[\033[1;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[1;34m\]"
NO_COLOUR="\[\033[0m\]"
CYAN="\[\033[0;36m\]"
PURPLE="\[\033[0;35m\]"

# Determine active Python virtualenv details.
function set_virtualenv () {
	if test -z "$VIRTUAL_ENV" ; then
		PYTHON_VIRTUALENV=""
	else
    PYTHON_VIRTUALENV="$CYAN(`basename \"$VIRTUAL_ENV\"`)${NO_COLOUR} "
	fi
}

function set_rvm_prompt () {
  local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
	[ "$gemset" != "" ] && echo "[@$gemset] "
}

function parse_git_branch () {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function set_git_branch () {
  # Capture the output of the "git status" command.

	git_status="$(git status 2> /dev/null)"
	# Set color based on clean/staged/dirty.
	if [[ ${git_status} =~ .*"working directory clean".* ]]; then
	  B_STATE="${GREEN}"
	elif [[ ${git_status} =~ .*"Changes to be committed".* ]]; then
		B_STATE="${YELLOW}"
	else
		B_STATE="${RED}"
	fi
}

prompt_cmd () {
  set_virtualenv
	set_git_branch
	PS1="$L_YELLOW\w $CYAN\$(set_rvm_prompt)${B_STATE}\$(parse_git_branch)$NO_COLOUR "
}

PROMPT_COMMAND=prompt_cmd
