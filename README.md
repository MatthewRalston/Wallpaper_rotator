# README

This project ccontains two files: a script to be put on the cron 'wallpaper_changer.sh'
The second file is conky.conf.defaults, which is just a conky template with some colors defined at the top, and we redefine 6 of them via sed commands in the 'wallpaper_changer.sh' script. Simply put, the defaults are echoed through the sed commands and into the final location $HOME/.config/conky/conky.conf of course, where it is picked up by the line to launch conky at the end of the file.



All you have to do is set up a crontab with this script rotating wallpapers.







# Acknowledgements

This is something I actually had to make twice. I combined an issue on stackoverflow involving gsettings and the gnome desktop, which essentially cinnamon is, 

But wait the other part of the recipe was this:
https://forums.linuxmint.com/viewtopic.php?t=177294

We used this and that to rotate the wallpaper on the cron. 


But we missed this 

https://serverfault.com/questions/332255/how-to-backup-crontab-e-files

We're currently investigating crontab backup solutions, it hasn't been a huge priority.


And then we added this 
http://blog.z3bra.org/2015/06/vomiting-colors.html

Through the following.

https://github.com/rickellis/ConkyMatic


All in all 4 sources combined to do some wallpaper rotation in cinnamon and some rgb swatch rotations into a conky theme.

