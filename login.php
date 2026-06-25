<?php
session_start();
require_once "db.php";

$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {

$email = $_POST['email'];
$password = $_POST['password'];

if(!empty($email) && !empty($password)){

$stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
$stmt->execute([$email]);

$user = $stmt->fetch(PDO::FETCH_ASSOC);

if($user && password_verify($password,$user['password_hash'])){

$_SESSION['user_id'] = $user['id'];
$_SESSION['role'] = $user['role'];
$_SESSION['user_email'] = $user['email'];

$_SESSION['name'] = $user['full_name'];
$_SESSION['doctor_id'] = $user['id'];

# هنا نتحقق هل 2FA مفعل
if($user['twofa_enabled']==1){

$_SESSION['temp_user_2fa'] = $user['id'];

header("Location: login_2fa.php");
exit();

}
# إذا لم يكن مفعل يدخل مباشرة

if($user['role']=="doctor"){
header("Location: dr_dashboard.php");
}else{
header("Location: patient_dashboard.php");
}

exit();

}else{
$error="البريد الإلكتروني أو كلمة السر غير صحيحة";
}

}else{
$error="يرجى ملء جميع الحقول";
}
}
?>

<!DOCTYPE html>
<html lang="ar" dir="rtl">

<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>تسجيل الدخول</title>

<link rel="stylesheet" href="style.css">

<link rel="stylesheet"
href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</head>

<body>

<div class="container">

<div class="logo-area">
<img src="medchifagz.png" alt="Logo">
</div>

<div class="card login-card show">

<h2>تسجيل الدخول</h2>

<?php if(!empty($error)): ?>
<p style="color:red;text-align:center;"><?php echo $error; ?></p>
<?php endif; ?>

<form method="POST">

<div class="input-group">
<i class="fas fa-envelope icon"></i>
<input type="email" name="email" placeholder="البريد الإلكتروني" required>
</div>

<div class="input-group">
<i class="fas fa-lock icon"></i>
<input type="password" name="password" placeholder="كلمة السر" required>
</div>

<div class="action-buttons">
<button type="submit" class="primary-btn">
دخول
</button>
</div>
<p class="forgot-pass">
<a href="forgot_password.php">نسيت كلمة السر؟</a>
</p>

</form>

<p class="step-text" style="margin-top:30px;text-align:center;">
ليس لديك حساب؟
<a href="index.html" style="color:#1231e3;font-weight:bold;">
إنشاء حساب
</a>
</p>

</div>

</div>

</body>
</html>