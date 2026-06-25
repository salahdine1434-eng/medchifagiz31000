<?php
session_start();
require 'db.php';

if (!isset($_SESSION['user_id']) || $_SESSION['role'] != 'doctor') {
    header("Location: login.php");
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {

    $license = trim($_POST['license_number']);
    $specialty = trim($_POST['specialty']);
    $workplace = trim($_POST['workplace']);
    $lat = $_POST['lat'];
    $lng = $_POST['lng'];

    $stmt = $pdo->prepare("
    UPDATE doctors 
    SET license_number = ?, specialty = ?, workplace = ?, lat = ?, lng = ?, is_profile_complete = 1
    WHERE user_id = ?
");

$stmt->execute([$license, $specialty, $workplace, $lat, $lng, $_SESSION['user_id']]);

    header("Location: dr_dashboard.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>إكمال معلومات الطبيب</title>

    <!-- نفس الروابط لي تستعمليهم -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">

    <!-- نفس مكان اللوغو -->
    <div class="logo-area">
        <img src="medchifagz.png" alt="Logo">
    </div>

    <!-- نفس الكارد -->
    <div class="card card">
        <h2>إكمال معلومات الطبيب</h2>

        <p class="verify-text">من فضلك كمل معلوماتك باش تقدر تدخل للوحة التحكم</p>

        <form method="POST">

            <div class="input-group">
                <i class="fas fa-id-card icon"></i>
                <input type="text" name="license_number" placeholder="رقم التسجيل المهني" required>
            </div>

            <div class="input-group">
                <i class="fas fa-user-doctor icon"></i>
                <input type="text" name="specialty" placeholder="التخصص" required>
            </div>

            <div class="input-group">
                <i class="fas fa-hospital icon"></i>
                <input type="text" name="workplace" placeholder="مكان العمل" required>
            </div>

           <button type="button" onclick="getLocation()">📍 تحديد موقعي</button>

<input type="hidden" name="lat" id="lat">
<input type="hidden" name="lng" id="lng">

<div class="action-buttons">
    <button type="submit" class="primary-btn">حفظ المعلومات</button>
</div>

        </form>
    </div>

</div>

<script src="script.js"></script>
<script>
function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function(position) {
            document.getElementById("lat").value = position.coords.latitude;
            document.getElementById("lng").value = position.coords.longitude;
            alert("تم تحديد موقعك بنجاح ✅");
        }, function() {
            alert("ما قدرناش نحددو الموقع ❌");
        });
    } else {
        alert("المتصفح ما يدعمش تحديد الموقع");
    }
}
</script>
</body>
</html>