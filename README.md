# MedChifaGiz — AI Daily Journal Analysis
## ترقية التحليل الصحي إلى Groq AI

---

## الملفات في هذا الـ Package

```
medchifagiz-ai-journal/
├── analyze_daily_ai.php     ← جديد: endpoint التحليل بالذكاء الاصطناعي
├── daily_journal.js         ← معدّل: نفس الملف + منطق AI
├── config/
│   └── .env.example         ← نموذج إعداد مفتاح API
└── README.md
```

---

## خطوات التثبيت

### 1. إعداد مفتاح Groq API

```bash
# انسخ ملف الإعداد
cp config/.env.example config/.env

# افتح config/.env وأضف مفتاحك
GROQ_API_KEY=gsk_xxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

احصل على مفتاح مجاني من: https://console.groq.com

### 2. نقل الملفات للسيرفر

```bash
# ضع هذين الملفين في نفس مجلد مشروعك (مع save_daily_journal.php)
analyze_daily_ai.php  →  /your-project-root/
daily_journal.js      →  /your-project-root/assets/js/   (أو مكانه الحالي)

# ضع مجلد الـ config بأمان خارج public_html أو أضفه لـ .htaccess
config/.env           →  /your-project-root/config/.env
```

### 3. حماية ملف .env (مهم!)

أضف هذا لـ `.htaccess` في مجلد `config/`:

```apache
<Files ".env">
    Order allow,deny
    Deny from all
</Files>
```

أو ضع مجلد `config/` خارج `public_html` تماماً وعدّل المسار في `analyze_daily_ai.php`:

```php
$envFile = __DIR__ . '/../config/.env'; // مثال لمسار خارجي
```

### 4. أضف .env لـ .gitignore

```
config/.env
```

---

## كيف يعمل

```
زر "حفظ وتحليل"
       │
       ▼
  djCollect() ← يجمع البيانات من الـ form
       │
       ├──► djCalcScore()         ← حساب الـ score (rule-based، كالسابق)
       │
       ├──► djSaveToServer()      ← حفظ في DB (save_daily_journal.php، بدون تغيير)
       │
       └──► djAnalyzeWithAI()     ← إرسال البيانات لـ analyze_daily_ai.php
                   │
                   ├── نجاح → djRenderAIResults()   (عرض تحليل Groq AI)
                   │
                   └── فشل → djRenderResults()      (fallback rule-based)
```

---

## شكل استجابة AI

```json
{
  "summary": "ملخص الحالة الصحية بأسلوب طبي عربي",
  "risk_level": "low | medium | high",
  "warnings": ["تحذير 1", "تحذير 2"],
  "recommendations": ["توصية 1", "توصية 2", "توصية 3"]
}
```

---

## ما لم يتغير

- ✅ UI كامل (CSS، HTML، navbar، bottom nav)
- ✅ قاعدة البيانات وجدول `daily_journal`
- ✅ `save_daily_journal.php` بدون أي تعديل
- ✅ المؤشر الصحي الحسابي (rule-based score) يُحسب دائماً
- ✅ PDF export، Share، SOS
- ✅ سجل الأسبوع (weekly chart)
- ✅ تاب السجل التاريخي

---

## Groq Model المستخدم

`llama-3.3-70b-versatile` — سريع، مجاني، ودقيق في اللغة العربية الطبية.
