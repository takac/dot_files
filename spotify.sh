#!/bin/bash

function shell_is_osx()
{
	return 1
}

function shell_is_linux()
{
	return 0
}


function now_playing()
{
	if shell_is_linux; then
		metadata=$(dbus-send --reply-timeout=42 --print-reply --dest=org.mpris.MediaPlayer2.spotify / org.freedesktop.MediaPlayer2.GetMetadata 2>/dev/null)
		if [ "$?" -eq 0 ] && [ -n "$metadata" ]; then
			# TODO how do one express this with dbus-send? It works with qdbus but the problem is that it's probably not as common as dbus-send.
			state=$(qdbus org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus)
			if [[ $state == "Playing" ]]; then
				artist=$(echo "$metadata" | grep -PA2 "string\s\"xesam:artist\"" | tail -1 | grep -Po "(?<=\").*(?=\")")
				track=$(echo "$metadata" | grep -PA1 "string\s\"xesam:title\"" | tail -1 | grep -Po "(?<=\").*(?=\")")
				np=$(echo "${artist} - ${track}")
			fi
		fi
	elif shell_is_osx; then
		echo "Bad"
		exit 1
		# np=$(${TMUX_POWERLINE_DIR_SEGMENTS}/np_spotify_mac.script)
	fi
	echo "$np"
}

now_playing
