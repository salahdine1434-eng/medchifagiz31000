<?php
session_start();
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    echo json_encode([
        'success' => false,
        'message' => 'المستخدم غير مسجل الدخول'
    ]);
    exit;
}

require 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

if (!$data) {
    echo json_encode([
        'success' => false,
        'message' => 'ماكانتش بيانات'
    ]);
    exit;
}

try {
    $stmt = $pdo->prepare("
        UPDATE patients SET
            first_name = ?,
            last_name = ?,
            birth_date = ?,
            gender = ?,
            blood_type = ?,
            weight = ?,
            height = ?,
            phone = ?,
            chronic_diseases = ?,
            allergies = ?,
            medications = ?,
            health_notes = ?,
            emergency_name = ?,
            emergency_phone = ?,
            medical_completed = 1
        WHERE user_id = ?
    ");

    $stmt->execute([
        $data['first_name'] ?? null,
        $data['last_name'] ?? null,
        $data['birth_date'] ?? null,
        $data['gender'] ?? null,
        $data['blood_type'] ?? null,
        $data['weight'] ?? null,
        $data['height'] ?? null,
        $data['phone'] ?? null,
        $data['chronic_diseases'] ?? null,
        $data['allergies'] ?? null,
        $data['medications'] ?? null,
        $data['health_notes'] ?? null,
        $data['emergency_name'] ?? null,
        $data['emergency_phone'] ?? null,
        $_SESSION['user_id']
    ]);
// حفظ الموعد القادم إذا كان موجود
if (
    !empty($data['next_appointment_date']) &&
    !empty($data['next_appointment_time'])
) {
    // نجيب doctor_id الحقيقي
    $stmtDoctor = $pdo->prepare("SELECT id FROM doctors WHERE user_id = ?");
    $stmtDoctor->execute([$_SESSION['user_id']]);
    $doctor = $stmtDoctor->fetch(PDO::FETCH_ASSOC);

    $doctor_id = $doctor['id'];

    // patient_id
    $patient_id = $data['patient_id'];

    // نسجل الموعد
    $stmtApp = $pdo->prepare("
        INSERT INTO appointments
        (patient_id, doctor_id, status, created_at, appointment_date, appointment_time)
        VALUES (?, ?, 'confirmed', NOW(), ?, ?)
    ");

    $stmtApp->execute([
        $patient_id,
        $doctor_id,
        $data['next_appointment_date'],
        $data['next_appointment_time']
    ]);
}
    echo json_encode([
        'success' => true,
        'message' => 'تم الحفظ'
    ]);

} catch (PDOException $e) {
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>