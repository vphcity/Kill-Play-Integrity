#!/system/bin/sh
# killpi.sh by Nox @ CCraft Space
#
# Kill the Google Play services DroidGuard and Play Store processes
# (com.google.android.gms.unstable and com.android.vending)

if [ "$USER" != "root" -a "$(whoami 2>/dev/null)" != "root" ]; then
  echo "killpi: need root permissions";
  exit 1;
fi;

killall -v com.google.android.gms.unstable;
killall -v com.android.vending;
