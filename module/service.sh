#!/system/bin/sh
# 🌟 Advanced Kill Play Integrity Module - By Nox & 🌟

MODDIR=${0%/*}

[ -f "$MODDIR/config.sh" ] && . "$MODDIR/config.sh"

GMS_PATH="/data/data/com.google.android.gms"
RAW_URL="https://raw.githubusercontent.com/vphcity/Kill-Play-Integrity/main/module"

# Force Bootloader status to locked
resetprop ro.boot.flash.locked "1"
resetprop ro.boot.vbmeta.device_state "locked"
resetprop ro.boot.verifiedbootstate "green"
resetprop ro.boot.flash.locked "1"
resetprop ro.boot.selinux "enforcing"
resetprop -n ro.hardware.keystore "none"

# ... (config.sh) ...


if [ "$SPOOF_BUILD" = "true" ]; then
    resetprop -n ro.product.model "$MODEL"
    resetprop -n ro.product.brand "$BRAND"
    resetprop -n ro.product.name "$PRODUCT"
    resetprop -n ro.product.device "$DEVICE"
    resetprop -n ro.build.product "$PRODUCT"
fi




# Hide Magisk/Root props
resetprop ro.debuggable "0"
resetprop ro.secure "1"
resetprop ro.build.type "user"
resetprop ro.build.tags "release-keys"


update_module() {
    echo "[*] Checking for updates..."
    curl -s "$RAW_URL/service.sh" -o "$MODDIR/service.sh.tmp"
    if [ $? -eq 0 ]; then
        mv "$MODDIR/service.sh.tmp" "$MODDIR/service.sh"
        chmod +x "$MODDIR/service.sh"
        echo "[+] Module updated! Please run the command again."
        exit 0
    else
        echo "[-] Update failed."
    fi
}

# التحقق من الأوامر
if [ "$1" = "update" ]; then
    update_module
fi

echo "=========================================="
echo "💀 INITIATING ADVANCED PIF BYPASS 💀"
echo "=========================================="

# 1. سحب البصمة الحصرية
echo "[*] Downloading the latest fingerprint..."
curl -s "$RAW_URL/pif.json" -o "$MODDIR/pif.json"

if [ ! -f "$MODDIR/pif.json" ]; then
    echo "[-] ERROR: Fetch failed."
    exit 1
fi

# 2. تدمير ذاكرة جوجل و الـ DroidGuard
echo "[*] Executing deep GMS database wipe..."
rm -rf $GMS_PATH/databases/gservices.db* 2>/dev/null
rm -rf $GMS_PATH/databases/dg.db* 2>/dev/null
rm -rf $GMS_PATH/cache/* 2>/dev/null
rm -rf $GMS_PATH/app_dg_cache/* 2>/dev/null

# 3. إعادة التشغيل
killall com.google.android.gms com.google.android.gms.unstable >/dev/null 2>&1

echo "=========================================="
echo "🔥 DONE! SYSTEM IS READY. TEST NOW! 🔥"
echo "=========================================="
