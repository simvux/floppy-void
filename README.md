```bash
USER=simon

# Edit the username for the runsvdir folder in `etc/sv/runsvdir-MY_USERNAME`
# Then; copy over the global config folder
cp etc/* /etc/
chmod +x /etc/sv/runsvdir-$USER/run

# Edit the username in any files that contains it
grep -R "$USER" # change each

./packages.sh
./create_user.sh $USER

# `app` directory (and more) should now exist
ls /home/$USER

./install_extras.sh $USER

# Copy over scripts
mkdir -p /home/$USER/.local/bin/
cp -r bin/* /home/$USER/.local/bin/

# From now you need to be booted into the target system so that runit symlinks are active
./services.sh $USER

# Move the floppy-void directory into the home folder for dotfiles synchronization
mv ../floppy-void /home/$USER/app/system/floppy-void
chown -R simon /home/$USER/app/system/floppy-void
```
