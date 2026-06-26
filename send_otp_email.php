<?php
// ═══════════════════════════════════════════════════════════════
//  Envoi via API Brevo (HTTPS port 443)
//  Compatible Render Free Plan
//  Variables Render → Environment :
//    BREVO_API_KEY  → clé API Brevo
//    SENDER_EMAIL   → adresse expéditrice vérifiée dans Brevo
//    SENDER_NAME    → nom affiché (optionnel)
// ═══════════════════════════════════════════════════════════════

define('BREVO_API_KEY', getenv('BREVO_API_KEY') ?: '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');
define('SENDER_EMAIL',  getenv('SENDER_EMAIL')  ?: 'salahdine1434@gmail.com');
define('SENDER_NAME',   getenv('SENDER_NAME')   ?: 'MedChifaGiz');

function sendOtpEmail(string $toEmail, string $otp): bool
{
    $htmlBody = "
<div style='font-family:Tahoma,Arial,sans-serif;direction:rtl;line-height:1.8;color:#222;font-size:15px'>
    <h2 style='color:#2e7d32'>مرحباً بك في MedChifaGiz</h2>
    <p>رمز التحقق الخاص بك:</p>
    <div style='display:inline-block;padding:12px 25px;font-size:26px;font-weight:bold;color:#2e7d32;background:#f1f8f4;border:2px dashed #2e7d32;border-radius:8px;letter-spacing:3px;margin:10px 0'>
        {$otp}
    </div>
    <p>يرجى إدخال هذا الرمز لتفعيل حسابك.</p>
    <hr style='margin:25px 0'>
    <div style='direction:ltr;text-align:left'>
        <h3 style='color:#2e7d32'>Welcome to MedChifaGiz</h3>
        <p>Your verification code is: <strong>{$otp}</strong></p>
        <p>Please enter this code to activate your account.</p>
    </div>
    <hr style='margin:25px 0'>
    <p style='font-size:13px;color:gray'>If you did not request this, please ignore this email.</p>
    <p>MedChifaGiz Team</p>
</div>";

    $payload = json_encode([
        'sender'      => ['name' => SENDER_NAME, 'email' => SENDER_EMAIL],
        'to'          => [['email' => $toEmail]],
        'subject'     => 'رمز التحقق - MedChifaGiz',
        'htmlContent' => $htmlBody,
    ]);

    $ch = curl_init('https://api.brevo.com/v3/smtp/email');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => $payload,
        CURLOPT_TIMEOUT        => 15,
        CURLOPT_HTTPHEADER     => [
            'Content-Type: application/json',
            'Accept: application/json',
            'api-key: ' . BREVO_API_KEY,
        ],
    ]);

    $response  = curl_exec($ch);
    $httpCode  = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);

    if ($curlError) {
        error_log('[MedChifaGiz] Brevo cURL error: ' . $curlError);
        return false;
    }

    if ($httpCode !== 201) {
        error_log('[MedChifaGiz] Brevo API error ' . $httpCode . ': ' . $response);
        return false;
    }

    return true;
}
