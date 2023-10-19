#!/bin/bash
# bootstrap script source by murmurlab: https://github.com/murmurlab/scripts/blob/master/bootstrap.sh

# echo 'bozulduğu için bakımda.'
# exit 1

cecho()
{
    local text="$1"
    local color_name="$2"
    local style="$3"
    local color_code=""
    local style_code=""

    case "$color_name" in
        "black") color_code="30";;
        "red") color_code="31";;
        "green") color_code="32";;
        "yellow") color_code="33";;
        "blue") color_code="34";;
        "magenta") color_code="35";;
        "orange") color_code="36";;
        "gray") color_code="90";;
        "light_red") color_code="91";;
        "light_green") color_code="92";;
        "light_yellow") color_code="93";;
        "light_blue") color_code="94";;
        "pink") color_code="95";;
        "light_orange") color_code="96";;
        "white") color_code="97";;
        *) color_code="97";;
    esac

    case "$style" in
        "bold") style_code="1";;
        "underline") style_code="4";;
        "reversed") style_code="7";;
        *) style_code="0";;  # Normal stil
    esac

    echo -e "\033[${style_code};${color_code}m${text}\033[0m"
}

f_break=1
eval "$(curl -sSL https://raw.githubusercontent.com/murmurlab/scripts/master/murmurbox.bash)"

cd $HOME/.local/temp/palgrind-1.0

mkdir -p $HOME/.local/valgrind
mkdir -p $HOME/.local/bin
cp -Rn bin $HOME/.local/valgrind
cp -Rn libexec $HOME/.local/valgrind
ln $HOME/.local/valgrind/bin/valgrind $HOME/.local/bin/vg

vg="alias vg=VALGRIND_LIB=$HOME/.local/valgrind/libexec/valgrind/\ $HOME/.local/bin/vg"

if ! grep -qF "$vg" $shell_f; then
    echo -e "\n$vg" >> $shell_f
    source $shell_f
    cecho "vg Alias added." "green" ""
else
    cecho "vg Alias already exists." "yellow" ""
fi

# manual zshrc because zsh is trash -----------------------------
if ! grep -qF "$vg" $HOME/.zshrc; then
    echo -e "\n$vg" >> $HOME/.zshrc
    source $HOME/.zshrc
    cecho "vg Alias added." "green" ""
else
    cecho "vg Alias already exists." "yellow" ""
fi
# manual zshrc because zsh is trash -----------------------------
