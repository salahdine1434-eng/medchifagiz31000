<?php
// ═══════════════════════════════════════════════════════════════
//  Envoi via API Resend (HTTPS port 443) — Compatible Render Free
//  Variables Render → Environment :
//    RESEND_API_KEY  → votre clé API Resend (re_xxxxx)
// ═══════════════════════════════════════════════════════════════

define('RESEND_API_KEY', getenv('RESEND_API_KEY') ?: 're_N6SxMjRv_CwV9MWGeCWkEm4opkbxa2cuR');

function sendOtpEmail(string $toEmail, string $otp): bool
{
    if (RESEND_API_KEY === '') {
        error_log('[MedChifaGiz] RESEND_API_KEY non défini.');
        return false;
    }

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

    // ⚠️ onboarding@resend.dev = adresse officielle Resend
    // → envoie vers N'IMPORTE QUEL email sans domaine vérifié
    $payload = json_encode([
        'from'    => 'MedChifaGiz <onboarding@resend.dev>',
        'to'      => [$toEmail],
        'subject' => 'رمز التحقق - MedChifaGiz',
        'html'    => $htmlBody,
    ]);

    $ch = curl_init('https://api.resend.com/emails');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => $payload,
        CURLOPT_TIMEOUT        => 15,
        CURLOPT_HTTPHEADER     => [
            'Content-Type: application/json',
            'Authorization: Bearer ' . RESEND_API_KEY,
        ],
    ]);

    $response  = curl_exec($ch);
    $httpCode  = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);

    if ($curlError) {
        error_log('[MedChifaGiz] Resend cURL error: ' . $curlError);
        return false;
    }

    if ($httpCode !== 200 && $httpCode !== 201) {
        error_log('[MedChifaGiz] Resend API error ' . $httpCode . ': ' . $response);
        return false;
    }

    return true;
}
