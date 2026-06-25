<?php
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require __DIR__ . '/PHPMailer/Exception.php';
require __DIR__ . '/PHPMailer/PHPMailer.php';
require __DIR__ . '/PHPMailer/SMTP.php';

// ═══════════════════════════════════════════════════════════════
//  ⚠️  IMPORTANT : ces valeurs viennent des variables d'environnement
//  (GMAIL_ADDRESS / GMAIL_APP_PASSWORD), définies dans Render →
//  Environment. Créez un mot de passe d'application Google sur :
//     https://myaccount.google.com/apppasswords
// ═══════════════════════════════════════════════════════════════
define('GMAIL_ADDRESS',      getenv('GMAIL_ADDRESS') ?: 'nadjetkheira631@gmail.com');
define('GMAIL_APP_PASSWORD', getenv('GMAIL_APP_PASSWORD') ?: 'REMPLACER_PAR_NOUVEAU_MOT_DE_PASSE_APP');

function sendOtpEmail($toEmail, $otp) {

    $mail = new PHPMailer(true);

    try {
        $mail->CharSet  = 'UTF-8';
        $mail->Encoding = 'base64';

        $mail->isSMTP();
        $mail->Host       = 'smtp.gmail.com';
        $mail->SMTPAuth   = true;
        $mail->Username   = GMAIL_ADDRESS;
        $mail->Password   = GMAIL_APP_PASSWORD;
        $mail->SMTPSecure = PHPMailer::ENCRYPTION_STARTTLS;
        $mail->Port       = 587;

        $mail->setFrom(GMAIL_ADDRESS, 'MedChifaGiz');
        $mail->addAddress($toEmail);

        // ✅ BUG CORRIGÉ : même nom de fichier partout (medchifagz.png)
        $logoPath = __DIR__ . '/medchifagz.png';
        if (file_exists($logoPath)) {
            $mail->addEmbeddedImage($logoPath, 'logo_med');
        }

        $mail->isHTML(true);
        $mail->Subject = 'رمز التحقق - MedChifaGiz';

        $mail->Body = "
<div style='font-family:Tahoma, Arial, sans-serif; direction:rtl; line-height:1.8; color:#222; font-size:15px'>

    <h2 style='color:#2e7d32; margin-bottom:10px'>
        مرحباً بك في MedChifaGiz
    </h2>

    <p>نحن سعداء بانضمامك إلى منصتنا الصحية الذكية</p>
    <p>رمز التحقق الخاص بك:</p>

    <div style='
        display:inline-block;
        padding:12px 25px;
        font-size:26px;
        font-weight:bold;
        color:#2e7d32;
        background:#f1f8f4;
        border:2px dashed #2e7d32;
        border-radius:8px;
        letter-spacing:3px;
        margin:10px 0;
    '>
        $otp
    </div>

    <p>يرجى إدخال هذا الرمز لتفعيل حسابك.</p>
    <hr style='margin:25px 0'>

    <div style='direction:ltr; text-align:left; font-size:15px'>
        <h3 style='color:#2e7d32'>Welcome to MedChifaGiz</h3>
        <p>Your verification code is:</p>
        <div style='
            display:inline-block;
            padding:10px 20px;
            font-size:24px;
            font-weight:bold;
            color:#2e7d32;
            background:#f1f8f4;
            border:2px dashed #2e7d32;
            border-radius:8px;
            letter-spacing:3px;
            margin:10px 0;
        '>
            $otp
        </div>
        <p>Please enter this code to activate your account.</p>
    </div>

    <hr style='margin:25px 0'>
    <p style='font-size:13px; color:gray'>
        إذا لم تقم بطلب هذا، يرجى تجاهل هذه الرسالة /
        If you did not request this, please ignore this email.
    </p>
    <p>MedChifaGiz Team</p>
</div>
";

        $mail->send();
        return true;

    } catch (Exception $e) {
        error_log("Mailer Error: " . $mail->ErrorInfo);
        return false;
    }
}
