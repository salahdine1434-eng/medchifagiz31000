<?php
error_reporting(E_ALL);
ini_set('display_errors', 0); // désactivé en production
header('Content-Type: application/json; charset=utf-8');

// ═══════════════════════════════════════════════════════════════
//  ⚠️  Remplacez par votre nouvelle clé Groq
//  https://console.groq.com → API Keys → Create new key
//  L'ancienne clé a été exposée et doit être révoquée.
// ═══════════════════════════════════════════════════════════════
$apiKey = "VOTRE_NOUVELLE_CLE_GROQ";

// ───────────────────────────────────────────────────────────────
//  Vérification curl (désactivé sur InfinityFree gratuit)
// ───────────────────────────────────────────────────────────────
if (!function_exists('curl_init')) {
    echo json_encode([
        "reply" => "عذراً، خدمة الذكاء الاصطناعي غير متاحة على هذا الخادم. يرجى التواصل مع المسؤول.",
        "error" => "curl_disabled"
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$message = trim($_POST['message'] ?? '');
$isImage = isset($_FILES['image']) && $_FILES['image']['error'] === 0 && $_FILES['image']['size'] > 0;
$imageBase64 = null;

if ($isImage) {
    $imageData   = file_get_contents($_FILES['image']['tmp_name']);
    $imageBase64 = base64_encode($imageData);
}

$healthKeywords = [
    "pain","fever","headache","stomach","cough","nausea","blood","pressure","sugar","diabetes",
    "وجع","ألم","رأسي","بطني","سعال","حرارة","ضغط","سكر","دم","دواء","مرض"
];

$isHealth = false;
foreach ($healthKeywords as $word) {
    if (strpos(mb_strtolower($message), $word) !== false) {
        $isHealth = true;
        break;
    }
}

$isFirstMessage = empty($_POST['history']);

if ($isFirstMessage && !$isHealth && !$isImage) {
    echo json_encode([
        "reply" => "أنا مساعد صحي وأجيب فقط على الأسئلة المتعلقة بالصحة"
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

$history = [];
if (!empty($_POST['history'])) {
    $decoded = json_decode($_POST['history'], true);
    if (is_array($decoded)) {
        $history = $decoded;
    }
}

$systemPrompt = "أنت مساعد طبي ذكي باسم MedChifaGiz. تجيب فقط على الأسئلة الصحية والطبية باللغة العربية أو الفرنسية أو الإنجليزية حسب لغة المستخدم. لا تقدم تشخيصاً نهائياً وانصح دائماً بزيارة الطبيب.";

$messages = [["role" => "system", "content" => $systemPrompt]];
foreach ($history as $h) {
    if (isset($h['role'], $h['content'])) {
        $messages[] = ["role" => $h['role'], "content" => $h['content']];
    }
}

if ($isImage && $imageBase64) {
    $messages[] = [
        "role" => "user",
        "content" => [
            ["type" => "text", "text" => $message ?: "حلل هذه الصورة الطبية"],
            ["type" => "image_url", "image_url" => ["url" => "data:image/jpeg;base64," . $imageBase64]]
        ]
    ];
} else {
    $messages[] = ["role" => "user", "content" => $message];
}

$payload = json_encode([
    "model"       => "llama-3.3-70b-versatile",
    "messages"    => $messages,
    "max_tokens"  => 800,
    "temperature" => 0.5
]);

$ch = curl_init('https://api.groq.com/openai/v1/chat/completions');
curl_setopt_array($ch, [
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_POST           => true,
    CURLOPT_POSTFIELDS     => $payload,
    CURLOPT_HTTPHEADER     => [
        "Authorization: Bearer $apiKey",
        "Content-Type: application/json"
    ],
    CURLOPT_TIMEOUT        => 20
]);

$response = curl_exec($ch);
$curlErr  = curl_error($ch);
curl_close($ch);

if ($curlErr) {
    echo json_encode(["reply" => "خطأ في الاتصال: " . $curlErr], JSON_UNESCAPED_UNICODE);
    exit;
}

$data  = json_decode($response, true);
$reply = $data['choices'][0]['message']['content'] ?? "لم أتمكن من الإجابة، حاول مرة أخرى.";

echo json_encode(["reply" => $reply], JSON_UNESCAPED_UNICODE);
