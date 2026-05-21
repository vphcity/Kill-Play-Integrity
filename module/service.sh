#!/system/bin/sh
# 🌟 Advanced Kill Play Integrity Module - By Nox & Advanced AI 🌟

MODDIR=${0%/*}
GMS_PATH="/data/data/com.google.android.gms"

echo "=========================================="
echo "💀 INITIATING ADVANCED PIF BYPASS 💀"
echo "=========================================="

# 1. سحب البصمة الحصرية من الجيتهاب
echo "[*] Downloading the latest encrypted fingerprint..."
curl -s "https://raw.githubusercontent.com/vphcity/Kill-Play-Integrity/main/module/pif.json" -o "$MODDIR/pif.json"

if [ -f "$MODDIR/pif.json" ]; then
    echo "[+] Fingerprint loaded successfully!"
else
    echo "[-] ERROR: Fetch failed. Check your connection."
    exit 1
fi

# 2. الضربة القاضية: تدمير ذاكرة جوجل (SQLite DB Wipe)
echo "[*] Executing deep GMS database wipe..."
if [ -d "$GMS_PATH/databases" ]; then
    rm -rf $GMS_PATH/databases/gservices.db* 2>/dev/null
    rm -rf $GMS_PATH/databases/dg.db* 2>/dev/null
    echo "[+] Google's memory wiped clean."
fi

# 3. مسح كاش الـ DroidGuard (المسؤول عن الفحص)
echo "[*] Purging GMS cache & DroidGuard..."
rm -rf $GMS_PATH/cache/* 2>/dev/null
rm -rf $GMS_PATH/app_dg_cache/* 2>/dev/null

# 4. إغلاق الخدمات بقوة لفرض البصمة الجديدة
echo "[*] Terminating GMS processes..."
killall com.google.android.gms >/dev/null 2>&1
killall com.google.android.gms.unstable >/dev/null 2>&1

echo "=========================================="
echo "🔥 DONE! SYSTEM IS READY. TEST NOW! 🔥"
echo "=========================================="
