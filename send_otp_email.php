<?php
// ═══════════════════════════════════════════════════════════════
//  Envoi via API HTTP Elastic Email (port 443 HTTPS)
//  Compatible Render Free Plan
//  Variables Render → Environment :
//    ELASTIC_API_KEY  → votre clé API Elastic Email
//    SENDER_EMAIL     → adresse expéditrice vérifiée
//    SENDER_NAME      → nom affiché (optionnel)
//
//  Clé API : app.elasticemail.com → Paramètres → API Keys → Créer
// ═══════════════════════════════════════════════════════════════

define('ELASTIC_API_KEY', getenv('ELASTIC_API_KEY') ?: 8BDF94E0834C76772D875545C86FE56A72C181F2F4253AF34F74652E4E6785DE99D8159F420275C3B5B12DA509A2CCFA'');
define('SENDER_EMAIL',    getenv('SENDER_EMAIL')    ?: 'salahdine1434@gmail.com');
define('SENDER_NAME',     getenv('SENDER_NAME')     ?: 'MedChifaGiz');

function sendOtpEmail(string $toEmail, string $otp): bool
{
    if (ELASTIC_API_KEY === '' || SENDER_EMAIL === '') {
        error_log('[MedChifaGiz] ELASTIC_API_KEY ou SENDER_EMAIL non défini.');
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

    $payload = http_build_query([
        'apikey'          => ELASTIC_API_KEY,
        'to'              => $toEmail,
        'from'            => SENDER_EMAIL,
        'fromName'        => SENDER_NAME,
        'subject'         => 'رمز التحقق - MedChifaGiz',
        'bodyHtml'        => $htmlBody,
        'bodyText'        => "رمز التحقق: {$otp}",
        'isTransactional' => true,
    ]);

    $ch = curl_init('https://api.elasticemail.com/v2/email/send');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => $payload,
        CURLOPT_TIMEOUT        => 15,
        CURLOPT_HTTPHEADER     => ['Content-Type: application/x-www-form-urlencoded'],
    ]);

    $response  = curl_exec($ch);
    $httpCode  = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    curl_close($ch);

    if ($curlError) {
        error_log('[MedChifaGiz] Elastic Email cURL error: ' . $curlError);
        return false;
    }

    $result = json_decode($response, true);

    if ($httpCode !== 200 || !isset($result['success']) || $result['success'] !== true) {
        error_log('[MedChifaGiz] Elastic Email error: ' . $response);
        return false;
    }

    return true;
}
