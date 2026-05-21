#!/system/bin/sh
MODDIR="${0%/*}"

# لو المستخدم كتب أمر التحديث (click) من التيرمكس
if [ "$1" = "click" ]; then
    echo "[*] Killing Play Integrity - Fetching latest pif.json..."
    # جلب أحدث بصمة من رابط الـ Raw الخاص بجيتهاب بتاعك
    curl -sL "https://raw.githubusercontent.com/vphcity/Kill-Play-Integrity/main/module/pif.json" -o "$MODDIR/pif.json"
    
    if [ $? -eq 0 ] && [ -s "$MODDIR/pif.json" ]; then
        echo "[+] Successfully updated pif.json from GitHub!"
        # عمل محاكاة لتطبيق البصمة فوراً في كاش خدمات جوجل بدون ريبوت كاملاً
        killall com.google.android.gms 2>/dev/null
        killall com.google.android.gms.unstable 2>/dev/null
        exit 0
    else
        echo "[-] Failed to download pif.json. Check network connection."
        exit 1
    fi
fi

# الكود الأصلي للموديول اللي بيشتغل مع إقلاع الجهاز (Boot)
until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 2
done

# هنا السكربت بيكمل تشغيل التمويه العسكري بتاعه اللي بيعمي النظام
