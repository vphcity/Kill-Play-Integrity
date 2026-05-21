MODPATH="${0%/*}"
. $MODPATH/common_func.sh

# Conditional sensitive properties

# Magisk Recovery Mode
resetprop_if_match ro.boot.mode recovery unknown
resetprop_if_match ro.bootmode recovery unknown
resetprop_if_match vendor.boot.mode recovery unknown

# SELinux
resetprop_if_diff ro.boot.selinux enforcing
# use delete since it can be 0 or 1 for enforcing depending on OEM
if ! $SKIPDELPROP; then
    delprop_if_exist ro.build.selinux
fi
# use toybox to protect stat access time reading
if [ "$(toybox cat /sys/fs/selinux/enforce)" = "0" ]; then
    chmod 640 /sys/fs/selinux/enforce
    chmod 440 /sys/fs/selinux/policy
fi

# Conditional late sensitive properties

# must be set after boot_completed for various OEMs
{
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

# SafetyNet/Play Integrity + OEM
# avoid bootloop on some Xiaomi devices
resetprop_if_diff ro.secureboot.lockstate locked
# avoid breaking Realme fingerprint scanners
resetprop_if_diff ro.boot.flash.locked 1
resetprop_if_diff ro.boot.realme.lockstate 1
# avoid breaking Oppo fingerprint scanners
resetprop_if_diff ro.boot.vbmeta.device_state locked
# avoid breaking OnePlus display modes/fingerprint scanners
resetprop_if_diff vendor.boot.verifiedbootstate green
# avoid breaking OnePlus/Oppo fingerprint scanners on OOS/ColorOS 12+
resetprop_if_diff ro.boot.verifiedbootstate green
resetprop_if_diff ro.boot.veritymode enforcing
resetprop_if_diff vendor.boot.vbmeta.device_state locked

# Other
resetprop_if_diff sys.oem_unlock_allowed 0

}&

# ========================================================
# 💀 KILL PLAY INTEGRITY BY NOX (DYNAMIC AUTO-UPDATE) 💀
# ========================================================



# هنا الرابط بتاعك اللي جوجل هتطاردك فيه! 
# (لما تعمل الريبو بتاعك على جيتهاب حط رابط الـ Raw هنا)
NOX_SERVER="https://github.com/vphcity/Kill-Play-Integrity/blob/main/pif.json"

kill_integrity() {
    echo "[*] Killing Play Integrity... Fetching fresh config from Nox Server."
    # سحب الملف الجديد في جزء من الثانية
    curl -s -k -L "$NOX_SERVER" -o "$PIF_PATH"
    
    if [ -f "$PIF_PATH" ]; then
        # عمل ريستارت لخدمات جوجل عشان تبص على البصمة الجديدة فوراً
        killall com.google.android.gms > /dev/null 2>&1
        am force-stop com.google.android.gms > /dev/null 2>&1
        echo "[+] Google Fooled Successfully! Integrity Killed. 🔥"
    else
        echo "[-] Failed to fetch patch. Check internet."
    fi
}

# لو المستخدم كتب الاختصار ده في الـ Termux، السكربت هيشتغل فوراً بضغطة زرار
if [ "$1" = "click" ]; then
    kill_integrity
fi

