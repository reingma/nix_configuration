#!/bin/sh
hyprctl clients | grep class:.kitty \
	&& echo hyprctl keyword workspace $( hyprctl clients | grep class..kitty -B4 && wlrctl window focus kitty) || kitty -L
