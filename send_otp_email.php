<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require __DIR__ . '/PHPMailer/Exception.php';
require __DIR__ . '/PHPMailer/PHPMailer.php';
require __DIR__ . '/PHPMailer/SMTP.php';

// ═══════════════════════════════════════════════════════════════
//  Envoi via Elastic Email — port 2525
//  Variables Render → Environment :
//    ELASTIC_USER      → votre adresse email Elastic Email
//    ELASTIC_PASSWORD  → votre clé API Elastic Email
//    SENDER_EMAIL      → adresse expéditrice
//    SENDER_NAME       → nom affiché (optionnel)
//
//  Créer un compte : https://elasticemail.com
//  Clé API : Settings → SMTP → Create SMTP Credentials
// ═══════════════════════════════════════════════════════════════

define('ELASTIC_USER',     getenv('ELASTIC_USER')     ?: 'salahdine1434@gmail.com
');
define('ELASTIC_PASSWORD', getenv('ELASTIC_PASSWORD') ?: 'B632C8F5B4AD1D4225761643FA09060E4B68');
define('SENDER_EMAIL',     getenv('SENDER_EMAIL')     ?: 'salahdine1434@gmail.com
');
define('SENDER_NAME',      getenv('SENDER_NAME')      ?: 'MedChifaGiz');

function sendOtpEmail(string $toEmail, string $otp): bool
{
    if (ELASTIC_USER === '' || ELASTIC_PASSWORD === '') {
        error_log('[MedChifaGiz] ELASTIC_USER ou ELASTIC_PASSWORD non défini.');
        return false;
    }

    $mail = new PHPMailer(true);

    try {
        $mail->CharSet  = 'UTF-8';
        $mail->Encoding = 'base64';

        $mail->isSMTP();
        $mail->Host       = 'smtp.elasticemail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = ELASTIC_USER;
        $mail->Password   = ELASTIC_PASSWORD;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 2525;
        $mail->Timeout    = 15;

        $mail->setFrom(SENDER_EMAIL ?: ELASTIC_USER, SENDER_NAME);
        $mail->addAddress($toEmail);

        $mail->isHTML(true);
        $mail->Subject = 'رمز التحقق - MedChifaGiz';
        $mail->Body    = "
<div style='font-family:Tahoma,Arial,sans-serif;direction:rtl;line-height:1.8;color:#222;font-size:15px'>
    <h2 style='color:#2e7d32'>مرحباً بك في MedChifaGiz</h2>
    <p>رمز التحقق الخاص بك:</p>
    <div style='display:inline-block;padding:12px 25px;font-size:26px;font-weight:bold;color:#2e7d32;background:#f1f8f4;border:2px dashed #2e7d32;border-radius:8px;letter-spacing:3px;margin:10px 0'>
        $otp
    </div>
    <p>يرجى إدخال هذا الرمز لتفعيل حسابك.</p>
    <hr style='margin:25px 0'>
    <div style='direction:ltr;text-align:left'>
        <h3 style='color:#2e7d32'>Welcome to MedChifaGiz</h3>
        <p>Your verification code is: <strong>$otp</strong></p>
        <p>Please enter this code to activate your account.</p>
    </div>
    <hr style='margin:25px 0'>
    <p style='font-size:13px;color:gray'>If you did not request this, please ignore this email.</p>
    <p>MedChifaGiz Team</p>
</div>";
        $mail->AltBody = "رمز التحقق: $otp";

        $mail->send();
        return true;

    } catch (Exception $e) {
        error_log('[MedChifaGiz] Mailer Error: ' . $mail->ErrorInfo);
        return false;
    }
}
